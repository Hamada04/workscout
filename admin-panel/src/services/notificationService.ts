import { apiClient } from './api';
import { ApiResponse, Notification, PaginatedResponse } from '@/types';

export const notificationService = {
  getAll: async (token: string, params?: { 
    page?: number; 
    limit?: number; 
    type?: string;
    userId?: string;
    isRead?: boolean;
  }) => {
    const queryParams = new URLSearchParams();
    if (params?.page) queryParams.append('page', params.page.toString());
    if (params?.limit) queryParams.append('limit', params.limit.toString());
    if (params?.type) queryParams.append('type', params.type);
    if (params?.userId) queryParams.append('userId', params.userId);
    if (params?.isRead !== undefined) queryParams.append('isRead', params.isRead.toString());
    
    const query = queryParams.toString() ? `?${queryParams.toString()}` : '';
    return apiClient.get<PaginatedResponse<Notification>>(`/admin/notifications${query}`, token);
  },

  create: async (token: string, data: {
    userId: string;
    type: string;
    title: string;
    description: string;
    actionLabel?: string;
    relatedJobId?: string;
    relatedApplicationId?: string;
  }) => {
    return apiClient.post<ApiResponse<Notification>>('/admin/notifications', data, token);
  },

  sendBulk: async (token: string, data: {
    userIds: string[];
    type: string;
    title: string;
    description: string;
  }) => {
    return apiClient.post<ApiResponse<{ sent: number }>>('/admin/notifications/bulk', data, token);
  },

  markAsRead: async (token: string, id: string) => {
    return apiClient.put<ApiResponse<Notification>>(`/admin/notifications/${id}/read`, {}, token);
  },

  delete: async (token: string, id: string) => {
    return apiClient.delete<ApiResponse<null>>(`/admin/notifications/${id}`, token);
  },
};
