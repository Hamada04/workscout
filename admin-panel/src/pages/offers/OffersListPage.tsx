import React, { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { Plus, Eye, Send, CheckCircle, XCircle, Clock, FileText } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { offerService } from '@/services/offerService';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  DataTable, 
  Button,
  Badge,
  EmptyState
} from '@/components/common';
import { timeAgo } from '@/utils/helpers';
import { OfferLetter, User, Job } from '@/types';

const getStatusBadge = (status: string) => {
  switch (status) {
    case 'sent':
    case 'pending':
      return <Badge variant="warning" dot>Pending</Badge>;
    case 'accepted':
      return <Badge variant="success" dot>Accepted</Badge>;
    case 'rejected':
    case 'declined':
      return <Badge variant="danger" dot>Declined</Badge>;
    default:
      return <Badge variant="default">{status}</Badge>;
  }
};

export default function OffersListPage() {
  const navigate = useNavigate();
  const { token } = useAuth();
  
  const [offers, setOffers] = useState<OfferLetter[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [statusFilter, setStatusFilter] = useState('');

  useEffect(() => {
    if (!token) return;
    setIsLoading(true);
    offerService.getAll(token)
      .then((res) => {
        const items = (res as unknown as Record<string, unknown>)['offers'] as OfferLetter[] ?? [];
        setOffers(items);
      })
      .catch(() => {})
      .finally(() => setIsLoading(false));
  }, [token]);

  const filteredOffers = useMemo(() => {
    return offers.filter(offer => {
      const matchesStatus = statusFilter === '' || offer.status === statusFilter;
      return matchesStatus;
    });
  }, [offers, statusFilter]);

  const columns = [
    {
      key: 'user',
      label: 'Candidate',
      sortable: true,
      render: (offer: OfferLetter) => {
        const user = offer.userId as User;
        return (
          <div>
            <p className="font-medium text-gray-900">{user.name}</p>
            <p className="text-sm text-gray-500">{user.email}</p>
          </div>
        );
      },
    },
    {
      key: 'job',
      label: 'Position',
      render: (offer: OfferLetter) => {
        const job = offer.jobId as Job;
        return (
          <div>
            <p className="font-medium text-gray-900">{offer.position}</p>
            <p className="text-sm text-gray-500">{job?.companyName ?? ''}</p>
          </div>
        );
      },
    },
    {
      key: 'salary',
      label: 'Salary',
      render: (offer: OfferLetter) => (
        <span className="font-medium text-gray-900">{offer.salary}</span>
      ),
    },
    {
      key: 'status',
      label: 'Status',
      sortable: true,
      render: (offer: OfferLetter) => getStatusBadge(offer.status),
    },
    {
      key: 'createdAt',
      label: 'Sent',
      sortable: true,
      render: (offer: OfferLetter) => (
        <span className="text-gray-500 text-sm">{timeAgo(offer.createdAt ?? '')}</span>
      ),
    },
    {
      key: 'actions',
      label: 'Actions',
      render: (offer: OfferLetter) => (
        <div className="flex items-center gap-1">
          <button
            onClick={(e) => { e.stopPropagation(); navigate(`/offers/${offer._id}`); }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="View Details"
          >
            <Eye className="w-4 h-4" />
          </button>
          <button
            onClick={(e) => { e.stopPropagation(); navigate(`/offers/${offer._id}`); }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="Send Reminder"
          >
            <Send className="w-4 h-4" />
          </button>
        </div>
      ),
    },
  ];

  const statusCounts = useMemo(() => ({
    pending: offers.filter(o => o.status === 'sent' || o.status === 'pending').length,
    accepted: offers.filter(o => o.status === 'accepted').length,
    declined: offers.filter(o => o.status === 'rejected' || o.status === 'declined').length,
  }), [offers]);

  return (
    <div className="space-y-6 animate-fadeIn">
      <PageHeader
        title="Offer Letters"
        subtitle="Manage job offers and track responses"
        showAddButton
        onAddClick={() => navigate('/offers/new')}
        addButtonText="Create Offer"
      />

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Card 
          hover 
          className="cursor-pointer"
          onClick={() => setStatusFilter(statusFilter === 'pending' ? '' : 'pending')}
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-2xl font-bold text-yellow-600">{statusCounts.pending}</p>
              <p className="text-sm text-gray-500">Pending Response</p>
            </div>
            <div className="w-12 h-12 bg-yellow-50 rounded-xl flex items-center justify-center">
              <Clock className="w-6 h-6 text-yellow-500" />
            </div>
          </div>
        </Card>
        <Card 
          hover 
          className="cursor-pointer"
          onClick={() => setStatusFilter(statusFilter === 'accepted' ? '' : 'accepted')}
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-2xl font-bold text-green-600">{statusCounts.accepted}</p>
              <p className="text-sm text-gray-500">Accepted</p>
            </div>
            <div className="w-12 h-12 bg-green-50 rounded-xl flex items-center justify-center">
              <CheckCircle className="w-6 h-6 text-green-500" />
            </div>
          </div>
        </Card>
        <Card 
          hover 
          className="cursor-pointer"
          onClick={() => setStatusFilter(statusFilter === 'declined' ? '' : 'declined')}
        >
          <div className="flex items-center justify-between">
            <div>
              <p className="text-2xl font-bold text-red-600">{statusCounts.declined}</p>
              <p className="text-sm text-gray-500">Declined</p>
            </div>
            <div className="w-12 h-12 bg-red-50 rounded-xl flex items-center justify-center">
              <XCircle className="w-6 h-6 text-red-500" />
            </div>
          </div>
        </Card>
      </div>

      <Card padding="none">
        <DataTable
          columns={columns}
          data={filteredOffers}
          keyField="_id"
          isLoading={isLoading}
          onRowClick={(offer) => navigate(`/offers/${offer._id}`)}
          emptyMessage="No offers found"
        />
      </Card>
    </div>
  );
}
