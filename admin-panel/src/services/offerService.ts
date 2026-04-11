import { apiClient } from './api';
import { ApiResponse, OfferLetter, PaginatedResponse } from '@/types';

export const offerService = {
  getAll: async (token: string, params?: { 
    page?: number; 
    limit?: number; 
    status?: string;
    userId?: string;
  }) => {
    const queryParams = new URLSearchParams();
    if (params?.page) queryParams.append('page', params.page.toString());
    if (params?.limit) queryParams.append('limit', params.limit.toString());
    if (params?.status) queryParams.append('status', params.status);
    if (params?.userId) queryParams.append('userId', params.userId);
    
    const query = queryParams.toString() ? `?${queryParams.toString()}` : '';
    return apiClient.get<PaginatedResponse<OfferLetter>>(`/admin/offers${query}`, token);
  },

  getById: async (token: string, id: string) => {
    return apiClient.get<ApiResponse<OfferLetter>>(`/admin/offers/${id}`, token);
  },

  create: async (token: string, data: {
    applicationId: string;
    position: string;
    startDate: string;
    salary: string;
    location: string;
    reportingTo: string;
    responsibilities: string;
    benefits: string;
    termsAndConditions: string;
  }) => {
    return apiClient.post<ApiResponse<OfferLetter>>('/admin/offers', data, token);
  },

  resend: async (token: string, id: string) => {
    return apiClient.post<ApiResponse<OfferLetter>>(`/admin/offers/${id}/resend`, {}, token);
  },

  getStats: async (token: string) => {
    return apiClient.get<{
      total: number;
      pending: number;
      accepted: number;
      declined: number;
    }>('/admin/offers/stats', token);
  },
};
