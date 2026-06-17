import { apiClient } from './api';
import { ApiResponse, Job, PaginatedResponse, JobFormData } from '@/types';

export const jobService = {
  getAll: async (token: string, params?: { 
    page?: number; 
    limit?: number; 
    search?: string;
    category?: string;
  }) => {
    const queryParams = new URLSearchParams();
    if (params?.page) queryParams.append('page', params.page.toString());
    if (params?.limit) queryParams.append('limit', params.limit.toString());
    if (params?.search) queryParams.append('search', params.search);
    if (params?.category) queryParams.append('category', params.category);
    
    const query = queryParams.toString() ? `?${queryParams.toString()}` : '';
    return apiClient.get<PaginatedResponse<Job>>(`/admin/jobs/${query}`, token);
  },

  getById: async (token: string, id: string) => {
    return apiClient.get<Job>(`/admin/jobs/${id}`, token);
  },

  create: async (token: string, data: JobFormData) => {
    return apiClient.post<ApiResponse<Job>>('/admin/jobs/add', data, token);
  },

  update: async (token: string, id: string, data: Partial<JobFormData>) => {
    return apiClient.put<ApiResponse<Job>>(`/admin/jobs/${id}`, data, token);
  },

  delete: async (token: string, id: string) => {
    return apiClient.delete<ApiResponse<null>>(`/admin/jobs/${id}`, token);
  },

  getCategories: async () => {
    return apiClient.get<string[]>('/jobs/categories/list');
  },

  getStats: async (token: string) => {
    return apiClient.get<{ total: number }>(`/admin/jobs/stats/count`, token);
  },
};
