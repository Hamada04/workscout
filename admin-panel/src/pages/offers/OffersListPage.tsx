import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { Plus, Eye, Send, CheckCircle, XCircle, Clock, FileText } from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  DataTable, 
  Button,
  Badge,
  EmptyState
} from '@/components/common';
import { formatDate, timeAgo } from '@/utils/helpers';
import { OfferLetter } from '@/types';

// Mock data
const mockOffers: (OfferLetter & { user: { name: string; email: string }; job: { jobTitle: string; companyName: string } })[] = [
  {
    _id: '1',
    applicationId: 'a1',
    userId: 'u1',
    user: { name: 'Sarah Johnson', email: 'sarah@example.com' },
    job: { jobTitle: 'Senior UI Designer', companyName: 'Netflix' },
    position: 'Senior UI Designer',
    startDate: '2026-06-01',
    salary: '$ 15,000/month',
    location: 'California, USA',
    reportingTo: 'Design Director',
    responsibilities: 'Lead UI design projects...',
    benefits: 'Health, dental, vision...',
    termsAndConditions: 'Standard employment terms...',
    status: 'pending',
    createdAt: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
  },
  {
    _id: '2',
    applicationId: 'a2',
    userId: 'u2',
    user: { name: 'Michael Chen', email: 'michael@example.com' },
    job: { jobTitle: 'Flutter Developer', companyName: 'Telegram' },
    position: 'Senior Flutter Developer',
    startDate: '2026-05-15',
    salary: '$ 12,000/month',
    location: 'Remote',
    reportingTo: 'Engineering Manager',
    responsibilities: 'Develop mobile applications...',
    benefits: 'Remote work, equipment...',
    termsAndConditions: 'Standard employment terms...',
    status: 'accepted',
    createdAt: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString(),
    respondedAt: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
  },
  {
    _id: '3',
    applicationId: 'a3',
    userId: 'u3',
    user: { name: 'Emma Wilson', email: 'emma@example.com' },
    job: { jobTitle: 'Product Manager', companyName: 'Invision' },
    position: 'Product Manager',
    startDate: '2026-04-01',
    salary: '$ 14,000/month',
    location: 'New York, USA',
    reportingTo: 'VP of Product',
    responsibilities: 'Lead product strategy...',
    benefits: 'Comprehensive benefits...',
    termsAndConditions: 'Standard employment terms...',
    status: 'declined',
    createdAt: new Date(Date.now() - 14 * 24 * 60 * 60 * 1000).toISOString(),
    respondedAt: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000).toISOString(),
  },
];

const getStatusBadge = (status: string) => {
  switch (status) {
    case 'pending':
      return <Badge variant="warning" dot>Pending</Badge>;
    case 'accepted':
      return <Badge variant="success" dot>Accepted</Badge>;
    case 'declined':
      return <Badge variant="danger" dot>Declined</Badge>;
    default:
      return <Badge variant="default">{status}</Badge>;
  }
};

export default function OffersListPage() {
  const navigate = useNavigate();
  
  const [offers, setOffers] = useState(mockOffers);
  const [isLoading, setIsLoading] = useState(false);
  const [statusFilter, setStatusFilter] = useState('');

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
      render: (offer: typeof mockOffers[0]) => (
        <div>
          <p className="font-medium text-gray-900">{offer.user.name}</p>
          <p className="text-sm text-gray-500">{offer.user.email}</p>
        </div>
      ),
    },
    {
      key: 'job',
      label: 'Position',
      render: (offer: typeof mockOffers[0]) => (
        <div>
          <p className="font-medium text-gray-900">{offer.position}</p>
          <p className="text-sm text-gray-500">{offer.job.companyName}</p>
        </div>
      ),
    },
    {
      key: 'salary',
      label: 'Salary',
      render: (offer: typeof mockOffers[0]) => (
        <span className="font-medium text-gray-900">{offer.salary}</span>
      ),
    },
    {
      key: 'status',
      label: 'Status',
      sortable: true,
      render: (offer: typeof mockOffers[0]) => getStatusBadge(offer.status),
    },
    {
      key: 'createdAt',
      label: 'Sent',
      sortable: true,
      render: (offer: typeof mockOffers[0]) => (
        <span className="text-gray-500 text-sm">{timeAgo(offer.createdAt)}</span>
      ),
    },
    {
      key: 'actions',
      label: 'Actions',
      render: (offer: typeof mockOffers[0]) => (
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

  // Status counts
  const statusCounts = useMemo(() => ({
    pending: offers.filter(o => o.status === 'pending').length,
    accepted: offers.filter(o => o.status === 'accepted').length,
    declined: offers.filter(o => o.status === 'declined').length,
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

      {/* Status Summary */}
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

      {/* Offers Table */}
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
