import { apiClient } from './api';
import { ApiResponse, Notification, PaginatedResponse } from '@/types';

export const notificationService = {
  getAll: async (token: string, params?: { 
    page?: number; 
    limit?: number; 
    isRead?: string;
  }) => {
    const queryParams = new URLSearchParams();
    if (params?.page) queryParams.append('page', params.page.toString());
    if (params?.limit) queryParams.append('limit', params.limit.toString());
    if (params?.isRead) queryParams.append('isRead', params.isRead);
    
    const query = queryParams.toString() ? `?${queryParams.toString()}` : '';
    return apiClient.get<PaginatedResponse<Notification>>(`/admin/notifications${query}`, token);
  },

  send: async (token: string, data: {
    userId: string;
    title: string;
    message: string;
    type?: string;
    relatedId?: string;
  }) => {
    return apiClient.post<ApiResponse<Notification>>('/admin/notifications/send', data, token);
  },

  sendAll: async (token: string, data: {
    title: string;
    message: string;
    type?: string;
  }) => {
    return apiClient.post<ApiResponse<{ message: string }>>('/admin/notifications/send-all', data, token);
  },

  markAsRead: async (token: string, id: string) => {
    return apiClient.put<ApiResponse<Notification>>(`/admin/notifications/${id}/read`, {}, token);
  },

  markAllRead: async (token: string) => {
    return apiClient.put<ApiResponse<{ message: string }>>('/admin/notifications/mark-all-read', {}, token);
  },

  delete: async (token: string, id: string) => {
    return apiClient.delete<ApiResponse<null>>(`/admin/notifications/${id}`, token);
  },

  getStats: async (token: string) => {
    return apiClient.get<{ total: number; unread: number }>(`/admin/notifications/stats/count`, token);
  },
};
