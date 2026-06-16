import { ApiResponse, LoginCredentials, AuthResponse } from '@/types';
import { apiClient } from './api';

export const authService = {
  login: async (credentials: LoginCredentials): Promise<AuthResponse> => {
    return apiClient.post<AuthResponse>('/admin/auth/login', credentials);
  },

  logout: async (): Promise<void> => {
    localStorage.removeItem('adminToken');
    localStorage.removeItem('adminUser');
  },

  getProfile: async (token: string) => {
    return apiClient.get<ApiResponse<AuthResponse>>('/admin/auth/me', token);
  },
};
