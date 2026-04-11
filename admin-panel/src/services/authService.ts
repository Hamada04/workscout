import { ApiResponse, LoginCredentials, AuthResponse } from '@/types';
import { apiClient } from './api';

export const authService = {
  login: async (credentials: LoginCredentials): Promise<AuthResponse> => {
    return apiClient.post<AuthResponse>('/auth/login', credentials);
  },

  logout: async (): Promise<void> => {
    // Implement logout API call if needed
  },

  getProfile: async (token: string) => {
    return apiClient.get<ApiResponse<AuthResponse>>('/auth/me', token);
  },
};
