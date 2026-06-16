import { apiClient } from './api';
import { ApiResponse, User, PaginatedResponse, UserFormData } from '@/types';

export const userService = {
  getAll: async (token: string, params?: { page?: number; limit?: number; search?: string; role?: string }) => {
    const queryParams = new URLSearchParams();
    if (params?.page) queryParams.append('page', params.page.toString());
    if (params?.limit) queryParams.append('limit', params.limit.toString());
    if (params?.search) queryParams.append('search', params.search);
    if (params?.role) queryParams.append('role', params.role);
    
    const query = queryParams.toString() ? `?${queryParams.toString()}` : '';
    return apiClient.get<PaginatedResponse<User>>(`/admin/users${query}`, token);
  },

  getById: async (token: string, id: string) => {
    return apiClient.get<ApiResponse<User>>(`/admin/users/${id}`, token);
  },

  create: async (token: string, data: UserFormData) => {
    return apiClient.post<ApiResponse<User>>('/auth/signup', data, token);
  },

  update: async (token: string, id: string, data: Partial<UserFormData>) => {
    return apiClient.put<ApiResponse<User>>(`/admin/users/${id}`, data, token);
  },

  delete: async (token: string, id: string) => {
    return apiClient.delete<ApiResponse<null>>(`/admin/users/${id}`, token);
  },

  toggleBlock: async (token: string, id: string) => {
    return apiClient.put<ApiResponse<User>>(`/admin/users/${id}/block`, {}, token);
  },

  getStats: async (token: string) => {
    return apiClient.get<{ totalUsers: number; totalAdmins: number }>(`/admin/users/stats/overview`, token);
  },
};
