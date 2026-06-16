import { apiClient } from './api';
import { ApiResponse, OfferLetter, PaginatedResponse } from '@/types';

export const offerService = {
  getAll: async (token: string, params?: { 
    page?: number; 
    limit?: number; 
    status?: string;
  }) => {
    const queryParams = new URLSearchParams();
    if (params?.page) queryParams.append('page', params.page.toString());
    if (params?.limit) queryParams.append('limit', params.limit.toString());
    if (params?.status) queryParams.append('status', params.status);
    
    const query = queryParams.toString() ? `?${queryParams.toString()}` : '';
    return apiClient.get<PaginatedResponse<OfferLetter>>(`/admin/offers${query}`, token);
  },

  getById: async (token: string, id: string) => {
    return apiClient.get<ApiResponse<OfferLetter>>(`/admin/offers/${id}`, token);
  },

  create: async (token: string, data: {
    userId: string;
    jobId: string;
    applicationId: string;
    salary: string;
    startDate: string;
    position: string;
    department?: string;
    message?: string;
    expiresInDays?: number;
  }) => {
    return apiClient.post<ApiResponse<OfferLetter>>('/admin/offers/create', data, token);
  },

  update: async (token: string, id: string, data: Partial<OfferLetter>) => {
    return apiClient.put<ApiResponse<OfferLetter>>(`/admin/offers/${id}`, data, token);
  },

  resend: async (token: string, id: string) => {
    return apiClient.put<ApiResponse<OfferLetter>>(`/admin/offers/${id}/resend`, {}, token);
  },

  delete: async (token: string, id: string) => {
    return apiClient.delete<ApiResponse<null>>(`/admin/offers/${id}`, token);
  },

  getStats: async (token: string) => {
    return apiClient.get<{
      total: number;
      sent: number;
      accepted: number;
      rejected: number;
    }>('/admin/offers/stats/count', token);
  },
};
