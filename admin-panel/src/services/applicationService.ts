import { apiClient } from './api';
import { ApiResponse, Application, PaginatedResponse, ApplicationStatus } from '@/types';

export const applicationService = {
  getAll: async (token: string, params?: { 
    page?: number; 
    limit?: number; 
    status?: ApplicationStatus;
    jobId?: string;
    userId?: string;
  }) => {
    const queryParams = new URLSearchParams();
    if (params?.page) queryParams.append('page', params.page.toString());
    if (params?.limit) queryParams.append('limit', params.limit.toString());
    if (params?.status) queryParams.append('status', params.status);
    if (params?.jobId) queryParams.append('jobId', params.jobId);
    if (params?.userId) queryParams.append('userId', params.userId);
    
    const query = queryParams.toString() ? `?${queryParams.toString()}` : '';
    return apiClient.get<PaginatedResponse<Application>>(`/admin/applications${query}`, token);
  },

  getById: async (token: string, id: string) => {
    return apiClient.get<ApiResponse<Application>>(`/admin/applications/${id}`, token);
  },

  updateStatus: async (token: string, id: string, status: ApplicationStatus, message?: string) => {
    return apiClient.put<ApiResponse<Application>>(`/admin/applications/${id}/status`, 
      { status, message }, token);
  },

  sendMessage: async (token: string, id: string, message: string) => {
    return apiClient.post<ApiResponse<Application>>(`/admin/applications/${id}/message`, 
      { message }, token);
  },

  getStats: async (token: string) => {
    return apiClient.get<{
      total: number;
      byStatus: Record<ApplicationStatus, number>;
      thisWeek: number;
    }>('/admin/applications/stats', token);
  },
};
