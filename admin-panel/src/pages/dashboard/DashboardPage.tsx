import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { 
  Users, 
  Briefcase, 
  FileText, 
  TrendingUp, 
  TrendingDown,
  Eye,
  ArrowRight,
  Clock
} from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { Card, StatCard, DataTable, StatusBadge, Button } from '@/components/common';
import { formatDate, timeAgo } from '@/utils/helpers';
import { useAuth } from '@/contexts/AuthContext';

// Mock data for demonstration
const mockStats = {
  totalUsers: 1250,
  totalJobs: 342,
  totalApplications: 2156,
  pendingApplications: 47,
  newUsersThisWeek: 23,
  newJobsThisWeek: 12,
  applicationsTrend: 15,
  jobsTrend: 8,
};

const recentApplications = [
  { 
    _id: '1', 
    user: { name: 'Sarah Johnson', email: 'sarah@example.com' },
    job: { jobTitle: 'Senior UI Designer', companyName: 'Netflix' },
    status: 'Interview' as const,
    appliedDate: new Date(Date.now() - 2 * 60 * 60 * 1000).toISOString(),
  },
  { 
    _id: '2', 
    user: { name: 'Michael Chen', email: 'michael@example.com' },
    job: { jobTitle: 'Flutter Developer', companyName: 'Telegram' },
    status: 'Submitted' as const,
    appliedDate: new Date(Date.now() - 5 * 60 * 60 * 1000).toISOString(),
  },
  { 
    _id: '3', 
    user: { name: 'Emma Wilson', email: 'emma@example.com' },
    job: { jobTitle: 'Product Manager', companyName: 'Invision' },
    status: 'Under Review' as const,
    appliedDate: new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString(),
  },
];

const recentJobs = [
  {
    _id: '1',
    jobTitle: 'Senior UI Designer',
    companyName: 'Netflix',
    location: 'California, USA',
    postedDate: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
    isActive: true,
  },
  {
    _id: '2',
    jobTitle: 'Flutter Developer',
    companyName: 'Telegram',
    location: 'Dubai, UAE',
    postedDate: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
    isActive: true,
  },
  {
    _id: '3',
    jobTitle: 'Digital Marketing Specialist',
    companyName: 'Startup Inc',
    location: 'Remote',
    postedDate: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000).toISOString(),
    isActive: false,
  },
];

const applicationColumns = [
  { 
    key: 'user', 
    label: 'Applicant',
    render: (item: typeof recentApplications[0]) => (
      <div>
        <p className="font-medium text-gray-900">{item.user.name}</p>
        <p className="text-xs text-gray-500">{item.user.email}</p>
      </div>
    )
  },
  { 
    key: 'job', 
    label: 'Job',
    render: (item: typeof recentApplications[0]) => (
      <div>
        <p className="font-medium text-gray-900">{item.job.jobTitle}</p>
        <p className="text-xs text-gray-500">{item.job.companyName}</p>
      </div>
    )
  },
  { 
    key: 'status', 
    label: 'Status',
    render: (item: typeof recentApplications[0]) => <StatusBadge status={item.status} />
  },
  { 
    key: 'appliedDate', 
    label: 'Applied',
    render: (item: typeof recentApplications[0]) => (
      <span className="text-gray-500 text-sm">{timeAgo(item.appliedDate)}</span>
    )
  },
];

const jobColumns = [
  { key: 'jobTitle', label: 'Job Title', sortable: true },
  { key: 'companyName', label: 'Company', sortable: true },
  { key: 'location', label: 'Location' },
  { 
    key: 'postedDate', 
    label: 'Posted',
    render: (item: typeof recentJobs[0]) => (
      <span className="text-gray-500 text-sm">{timeAgo(item.postedDate)}</span>
    )
  },
  { 
    key: 'isActive', 
    label: 'Status',
    render: (item: typeof recentJobs[0]) => (
      <span className={`inline-flex px-2 py-1 text-xs font-medium rounded-full ${item.isActive ? 'bg-green-50 text-green-700' : 'bg-gray-100 text-gray-600'}`}>
        {item.isActive ? 'Active' : 'Inactive'}
      </span>
    )
  },
];

export default function DashboardPage() {
  const { user } = useAuth();
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Simulate data loading
    const timer = setTimeout(() => setIsLoading(false), 500);
    return () => clearTimeout(timer);
  }, []);

  const getGreeting = () => {
    const hour = new Date().getHours();
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  };

  return (
    <div className="space-y-6 animate-fadeIn">
      {/* Page Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">
            {getGreeting()}, {user?.name?.split(' ')[0] || 'Admin'}
          </h1>
          <p className="text-gray-500 mt-1">Here's what's happening with your platform today.</p>
        </div>
        <div className="flex items-center gap-2 text-sm text-gray-500">
          <Clock className="w-4 h-4" />
          {new Date().toLocaleDateString('en-US', { 
            weekday: 'long', 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
          })}
        </div>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard
          title="Total Users"
          value={mockStats.totalUsers.toLocaleString()}
          icon={<Users className="w-6 h-6" />}
          trend={{ value: mockStats.newUsersThisWeek, isPositive: true }}
          color="primary"
        />
        <StatCard
          title="Active Jobs"
          value={mockStats.totalJobs.toLocaleString()}
          icon={<Briefcase className="w-6 h-6" />}
          trend={{ value: mockStats.newJobsThisWeek, isPositive: true }}
          color="success"
        />
        <StatCard
          title="Total Applications"
          value={mockStats.totalApplications.toLocaleString()}
          icon={<FileText className="w-6 h-6" />}
          trend={{ value: mockStats.applicationsTrend, isPositive: true }}
          color="purple"
        />
        <StatCard
          title="Pending Review"
          value={mockStats.pendingApplications.toLocaleString()}
          icon={<Eye className="w-6 h-6" />}
          color="warning"
        />
      </div>

      {/* Content Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Recent Applications */}
        <Card>
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-lg font-semibold text-gray-900">Recent Applications</h3>
              <p className="text-sm text-gray-500">Latest job applications</p>
            </div>
            <Link to="/applications">
              <Button variant="ghost" size="sm" rightIcon={<ArrowRight className="w-4 h-4" />}>
                View All
              </Button>
            </Link>
          </div>
          <DataTable
            columns={applicationColumns}
            data={recentApplications}
            keyField="_id"
            isLoading={isLoading}
            emptyMessage="No recent applications"
            className="border-0"
          />
        </Card>

        {/* Recent Jobs */}
        <Card>
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-lg font-semibold text-gray-900">Recent Jobs</h3>
              <p className="text-sm text-gray-500">Latest job postings</p>
            </div>
            <Link to="/jobs">
              <Button variant="ghost" size="sm" rightIcon={<ArrowRight className="w-4 h-4" />}>
                View All
              </Button>
            </Link>
          </div>
          <DataTable
            columns={jobColumns}
            data={recentJobs}
            keyField="_id"
            isLoading={isLoading}
            emptyMessage="No recent jobs"
            className="border-0"
          />
        </Card>
      </div>

      {/* Quick Actions */}
      <Card>
        <h3 className="text-lg font-semibold text-gray-900 mb-4">Quick Actions</h3>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <Link to="/jobs/new">
            <div className="p-4 rounded-lg border border-gray-200 hover:border-primary-300 hover:bg-primary-50 transition-all cursor-pointer group">
              <div className="w-10 h-10 rounded-lg bg-primary-100 text-primary-600 flex items-center justify-center mb-3 group-hover:bg-primary-200">
                <Briefcase className="w-5 h-5" />
              </div>
              <p className="font-medium text-gray-900">Add New Job</p>
              <p className="text-sm text-gray-500 mt-0.5">Create a job posting</p>
            </div>
          </Link>
          <Link to="/users">
            <div className="p-4 rounded-lg border border-gray-200 hover:border-success-300 hover:bg-green-50 transition-all cursor-pointer group">
              <div className="w-10 h-10 rounded-lg bg-green-100 text-green-600 flex items-center justify-center mb-3 group-hover:bg-green-200">
                <Users className="w-5 h-5" />
              </div>
              <p className="font-medium text-gray-900">Manage Users</p>
              <p className="text-sm text-gray-500 mt-0.5">View user accounts</p>
            </div>
          </Link>
          <Link to="/applications">
            <div className="p-4 rounded-lg border border-gray-200 hover:border-purple-300 hover:bg-purple-50 transition-all cursor-pointer group">
              <div className="w-10 h-10 rounded-lg bg-purple-100 text-purple-600 flex items-center justify-center mb-3 group-hover:bg-purple-200">
                <FileText className="w-5 h-5" />
              </div>
              <p className="font-medium text-gray-900">Review Applications</p>
              <p className="text-sm text-gray-500 mt-0.5">{mockStats.pendingApplications} pending</p>
            </div>
          </Link>
          <Link to="/offers/new">
            <div className="p-4 rounded-lg border border-gray-200 hover:border-warning-300 hover:bg-yellow-50 transition-all cursor-pointer group">
              <div className="w-10 h-10 rounded-lg bg-yellow-100 text-yellow-600 flex items-center justify-center mb-3 group-hover:bg-yellow-200">
                <TrendingUp className="w-5 h-5" />
              </div>
              <p className="font-medium text-gray-900">Send Offer</p>
              <p className="text-sm text-gray-500 mt-0.5">Create offer letter</p>
            </div>
          </Link>
        </div>
      </Card>
    </div>
  );
}
