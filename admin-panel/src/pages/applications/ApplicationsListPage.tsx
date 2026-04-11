import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { Eye, FileText, Mail, MessageSquare } from 'lucide-react';
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
import { formatDate, timeAgo } from '@/utils/helpers';
import { Application, ApplicationStatus } from '@/types';
import { APPLICATION_STATUSES } from '@/utils/constants';

// Mock data
const mockApplications: (Application & { user: { name: string; email: string }; job: { jobTitle: string; companyName: string } })[] = [
  {
    _id: '1',
    userId: 'u1',
    jobId: 'j1',
    user: { name: 'Sarah Johnson', email: 'sarah@example.com' },
    job: { jobTitle: 'Senior UI Designer', companyName: 'Netflix' },
    resumeUrl: '/resumes/sarah-johnson.pdf',
    coverLetter: 'I am excited to apply...',
    status: 'Interview',
    adminMessage: '',
    appliedDate: new Date(Date.now() - 2 * 60 * 60 * 1000).toISOString(),
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    _id: '2',
    userId: 'u2',
    jobId: 'j2',
    user: { name: 'Michael Chen', email: 'michael@example.com' },
    job: { jobTitle: 'Flutter Developer', companyName: 'Telegram' },
    resumeUrl: '/resumes/michael-chen.pdf',
    coverLetter: '',
    status: 'Submitted',
    adminMessage: '',
    appliedDate: new Date(Date.now() - 5 * 60 * 60 * 1000).toISOString(),
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    _id: '3',
    userId: 'u3',
    jobId: 'j3',
    user: { name: 'Emma Wilson', email: 'emma@example.com' },
    job: { jobTitle: 'Product Manager', companyName: 'Invision' },
    resumeUrl: '/resumes/emma-wilson.pdf',
    coverLetter: 'I have extensive experience...',
    status: 'Under Review',
    adminMessage: 'Reviewing application...',
    appliedDate: new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString(),
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    _id: '4',
    userId: 'u4',
    jobId: 'j1',
    user: { name: 'James Brown', email: 'james@example.com' },
    job: { jobTitle: 'Senior UI Designer', companyName: 'Netflix' },
    resumeUrl: '/resumes/james-brown.pdf',
    coverLetter: '',
    status: 'Accepted',
    adminMessage: 'Congratulations!',
    appliedDate: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString(),
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    _id: '5',
    userId: 'u5',
    jobId: 'j2',
    user: { name: 'Lisa Anderson', email: 'lisa@example.com' },
    job: { jobTitle: 'Flutter Developer', companyName: 'Telegram' },
    resumeUrl: '/resumes/lisa-anderson.pdf',
    coverLetter: 'I would be great for this role...',
    status: 'Rejected',
    adminMessage: 'We have decided to move forward with other candidates.',
    appliedDate: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString(),
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
];

const statusOptions = [
  { value: '', label: 'All Status' },
  ...APPLICATION_STATUSES.map(s => ({ value: s, label: s })),
];

export default function ApplicationsListPage() {
  const navigate = useNavigate();
  
  const [applications, setApplications] = useState(mockApplications);
  const [isLoading, setIsLoading] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState('');

  const filteredApplications = useMemo(() => {
    return applications.filter(app => {
      const matchesSearch = searchQuery === '' || 
        app.user.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        app.user.email.toLowerCase().includes(searchQuery.toLowerCase()) ||
        app.job.jobTitle.toLowerCase().includes(searchQuery.toLowerCase()) ||
        app.job.companyName.toLowerCase().includes(searchQuery.toLowerCase());
      
      const matchesStatus = statusFilter === '' || app.status === statusFilter;
      
      return matchesSearch && matchesStatus;
    });
  }, [applications, searchQuery, statusFilter]);

  const columns = [
    {
      key: 'user',
      label: 'Applicant',
      sortable: true,
      render: (app: typeof mockApplications[0]) => (
        <div className="flex items-center gap-3">
          <Avatar name={app.user.name} size="md" />
          <div>
            <p className="font-medium text-gray-900">{app.user.name}</p>
            <p className="text-sm text-gray-500">{app.user.email}</p>
          </div>
        </div>
      ),
    },
    {
      key: 'job',
      label: 'Job',
      render: (app: typeof mockApplications[0]) => (
        <div>
          <p className="font-medium text-gray-900">{app.job.jobTitle}</p>
          <p className="text-sm text-gray-500">{app.job.companyName}</p>
        </div>
      ),
    },
    {
      key: 'status',
      label: 'Status',
      sortable: true,
      render: (app: typeof mockApplications[0]) => <StatusBadge status={app.status} />,
    },
    {
      key: 'appliedDate',
      label: 'Applied',
      sortable: true,
      render: (app: typeof mockApplications[0]) => (
        <span className="text-gray-500 text-sm">{timeAgo(app.appliedDate)}</span>
      ),
    },
    {
      key: 'actions',
      label: 'Actions',
      render: (app: typeof mockApplications[0]) => (
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

  // Status counts
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

      {/* Status Summary Cards */}
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
