import React, { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { Eye, FileText, Mail } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { applicationService } from '@/services/applicationService';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  DataTable, 
  SearchFilterBar, 
  Button,
  Select,
  Avatar,
  StatusBadge,
  EmptyState
} from '@/components/common';
import { timeAgo } from '@/utils/helpers';
import { Application, ApplicationStatus, User, Job } from '@/types';
import { APPLICATION_STATUSES } from '@/utils/constants';

const statusOptions = [
  { value: '', label: 'All Status' },
  ...APPLICATION_STATUSES.map(s => ({ value: s, label: s })),
];

export default function ApplicationsListPage() {
  const navigate = useNavigate();
  const { token } = useAuth();
  
  const [applications, setApplications] = useState<Application[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState('');

  useEffect(() => {
    if (!token) return;
    setIsLoading(true);
    applicationService.getAll(token)
      .then((res) => {
        const items = (res as unknown as Record<string, unknown>)['applications'] as Application[] ?? [];
        setApplications(items);
      })
      .catch(() => {})
      .finally(() => setIsLoading(false));
  }, [token]);

  const filteredApplications = useMemo(() => {
    return applications.filter(app => {
      const user = app.userId as User;
      const job = app.jobId as Job;
      const userName = user?.name ?? '';
      const userEmail = user?.email ?? '';
      const jobTitle = job?.jobTitle ?? '';
      const companyName = job?.companyName ?? '';

      const matchesSearch = searchQuery === '' || 
        userName.toLowerCase().includes(searchQuery.toLowerCase()) ||
        userEmail.toLowerCase().includes(searchQuery.toLowerCase()) ||
        jobTitle.toLowerCase().includes(searchQuery.toLowerCase()) ||
        companyName.toLowerCase().includes(searchQuery.toLowerCase());
      
      const matchesStatus = statusFilter === '' || app.status === statusFilter;
      
      return matchesSearch && matchesStatus;
    });
  }, [applications, searchQuery, statusFilter]);

  const columns = [
    {
      key: 'user',
      label: 'Applicant',
      sortable: true,
      render: (app: Application) => {
        const user = app.userId as User;
        return (
          <div className="flex items-center gap-3">
            <Avatar name={user.name} size="md" />
            <div>
              <p className="font-medium text-gray-900">{user.name}</p>
              <p className="text-sm text-gray-500">{user.email}</p>
            </div>
          </div>
        );
      },
    },
    {
      key: 'job',
      label: 'Job',
      render: (app: Application) => {
        const job = app.jobId as Job;
        return (
          <div>
            <p className="font-medium text-gray-900">{job.jobTitle}</p>
            <p className="text-sm text-gray-500">{job.companyName}</p>
          </div>
        );
      },
    },
    {
      key: 'status',
      label: 'Status',
      sortable: true,
      render: (app: Application) => <StatusBadge status={app.status} />,
    },
    {
      key: 'appliedDate',
      label: 'Applied',
      sortable: true,
      render: (app: Application) => (
        <span className="text-gray-500 text-sm">{timeAgo(app.appliedAt ?? app.appliedDate ?? '')}</span>
      ),
    },
    {
      key: 'actions',
      label: 'Actions',
      render: (app: Application) => (
        <div className="flex items-center gap-1">
          <button
            onClick={(e) => { e.stopPropagation(); navigate(`/applications/${app._id}`); }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="View Details"
          >
            <Eye className="w-4 h-4" />
          </button>
          <button
            onClick={(e) => { e.stopPropagation(); navigate(`/applications/${app._id}`); }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="Download Resume"
          >
            <FileText className="w-4 h-4" />
          </button>
          <button
            onClick={(e) => { e.stopPropagation(); navigate(`/applications/${app._id}`); }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="Send Message"
          >
            <Mail className="w-4 h-4" />
          </button>
        </div>
      ),
    },
  ];

  const statusCounts = useMemo(() => {
    return APPLICATION_STATUSES.reduce((acc, status) => {
      acc[status] = applications.filter(a => a.status === status).length;
      return acc;
    }, {} as Record<ApplicationStatus, number>);
  }, [applications]);

  const handleResetFilters = () => {
    setSearchQuery('');
    setStatusFilter('');
  };

  return (
    <div className="space-y-6 animate-fadeIn">
      <PageHeader
        title="Applications"
        subtitle="Manage job applications and track their status"
      />

      <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
        {APPLICATION_STATUSES.map((status) => (
          <Card 
            key={status}
            hover
            className={`cursor-pointer ${statusFilter === status ? 'ring-2 ring-primary-500' : ''}`}
            onClick={() => setStatusFilter(statusFilter === status ? '' : status)}
          >
            <p className="text-2xl font-bold text-gray-900">{statusCounts[status]}</p>
            <p className="text-sm text-gray-500 mt-1">{status}</p>
          </Card>
        ))}
      </div>

      <Card>
        <SearchFilterBar
          searchValue={searchQuery}
          onSearchChange={setSearchQuery}
          searchPlaceholder="Search by applicant, job, or company..."
          filters={[
            { key: 'status', label: 'Status', options: statusOptions, value: statusFilter, onChange: setStatusFilter },
          ]}
          onReset={handleResetFilters}
        />
      </Card>

      <Card padding="none">
        <DataTable
          columns={columns}
          data={filteredApplications}
          keyField="_id"
          isLoading={isLoading}
          onRowClick={(app) => navigate(`/applications/${app._id}`)}
          emptyMessage="No applications found matching your criteria"
        />
      </Card>
    </div>
  );
}
