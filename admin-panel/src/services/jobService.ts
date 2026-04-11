import { apiClient } from './api';
import { ApiResponse, Job, PaginatedResponse, JobFormData } from '@/types';

export const jobService = {
  getAll: async (token: string, params?: { 
    page?: number; 
    limit?: number; 
    search?: string;
    category?: string;
    isActive?: boolean;
  }) => {
    const queryParams = new URLSearchParams();
    if (params?.page) queryParams.append('page', params.page.toString());
    if (params?.limit) queryParams.append('limit', params.limit.toString());
    if (params?.search) queryParams.append('search', params.search);
    if (params?.category) queryParams.append('category', params.category);
    if (params?.isActive !== undefined) queryParams.append('isActive', params.isActive.toString());
    
    const query = queryParams.toString() ? `?${queryParams.toString()}` : '';
    return apiClient.get<PaginatedResponse<Job>>(`/admin/jobs${query}`, token);
  },

  getById: async (token: string, id: string) => {
    return apiClient.get<ApiResponse<Job>>(`/admin/jobs/${id}`, token);
  },

  create: async (token: string, data: JobFormData) => {
    return apiClient.post<ApiResponse<Job>>('/admin/jobs', data, token);
  },

  update: async (token: string, id: string, data: Partial<JobFormData>) => {
    return apiClient.put<ApiResponse<Job>>(`/admin/jobs/${id}`, data, token);
  },

  delete: async (token: string, id: string) => {
    return apiClient.delete<ApiResponse<null>>(`/admin/jobs/${id}`, token);
  },

  toggleStatus: async (token: string, id: string, isActive: boolean) => {
    return apiClient.put<ApiResponse<Job>>(`/admin/jobs/${id}/status`, { isActive }, token);
  },

  getCategories: async (token: string) => {
    return apiClient.get<string[]>('/admin/jobs/categories', token);
  },

  getStats: async (token: string) => {
    return apiClient.get<{
      totalJobs: number;
      activeJobs: number;
      newJobsThisWeek: number;
      jobsByCategory: Record<string, number>;
    }>('/admin/jobs/stats', token);
  },
};
