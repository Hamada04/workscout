import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { 
  Users, 
  Briefcase, 
  FileText, 
  TrendingUp, 
  Eye,
  ArrowRight,
  Clock
} from 'lucide-react';
import { Card, StatCard, DataTable, StatusBadge, Button } from '@/components/common';
import { timeAgo } from '@/utils/helpers';
import { useAuth } from '@/contexts/AuthContext';
import { userService } from '@/services/userService';
import { jobService } from '@/services/jobService';
import { applicationService } from '@/services/applicationService';
import { Application, Job } from '@/types';

export default function DashboardPage() {
  const navigate = useNavigate();
  const { user, token } = useAuth();
  const [isLoading, setIsLoading] = useState(true);
  const [stats, setStats] = useState({
    totalUsers: 0,
    totalJobs: 0,
    totalApplications: 0,
    pendingApplications: 0,
  });
  const [recentApplications, setRecentApplications] = useState<Application[]>([]);
  const [recentJobs, setRecentJobs] = useState<Job[]>([]);

  useEffect(() => {
    if (token) {
      loadDashboardData();
    }
  }, [token]);

  const loadDashboardData = async () => {
    try {
      setIsLoading(true);
      
      const [userStats, jobStats, appStats, appsData, jobsData] = await Promise.all([
        userService.getStats(token!).catch(() => ({ totalUsers: 0, totalAdmins: 0 })),
        jobService.getStats(token!).catch(() => ({ total: 0 })),
        applicationService.getStats(token!).catch(() => ({ 
          total: 0, 
          pending: 0,
          reviewed: 0,
          interview: 0,
          accepted: 0,
          rejected: 0 
        })),
        applicationService.getAll(token!, { page: 1, limit: 5 }).catch(() => ({ applications: [], total: 0 })),
        jobService.getAll(token!, { page: 1, limit: 5 }).catch(() => ({ jobs: [], total: 0 })),
      ]);

      setStats({
        totalUsers: userStats.totalUsers,
        totalJobs: jobStats.total,
        totalApplications: appStats.total,
        pendingApplications: appStats.pending,
      });
      setRecentApplications(appsData.applications || []);
      setRecentJobs(jobsData.jobs || []);
    } catch (error) {
      console.error('Failed to load dashboard data:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const getGreeting = () => {
    const hour = new Date().getHours();
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  };

  const applicationColumns = [
    { 
      key: 'user', 
      label: 'Applicant',
      render: (item: Application) => (
        <div>
          <p className="font-medium text-gray-900">{(item.userId as unknown as { name: string })?.name || 'Unknown'}</p>
          <p className="text-xs text-gray-500">{(item.userId as unknown as { email: string })?.email || ''}</p>
        </div>
      )
    },
    { 
      key: 'job', 
      label: 'Job',
      render: (item: Application) => (
        <div>
          <p className="font-medium text-gray-900">{(item.jobId as unknown as { jobTitle: string })?.jobTitle || 'Unknown'}</p>
          <p className="text-xs text-gray-500">{(item.jobId as unknown as { companyName: string })?.companyName || ''}</p>
        </div>
      )
    },
    { 
      key: 'status', 
      label: 'Status',
      render: (item: Application) => <StatusBadge status={item.status} />
    },
    { 
      key: 'appliedAt', 
      label: 'Applied',
      render: (item: Application) => (
        <span className="text-gray-500 text-sm">{timeAgo(item.appliedAt)}</span>
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
      render: (item: Job) => (
        <span className="text-gray-500 text-sm">{timeAgo(item.postedDate)}</span>
      )
    },
  ];

  return (
    <div className="space-y-6 animate-fadeIn">
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

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard
          title="Total Users"
          value={stats.totalUsers.toLocaleString()}
          icon={<Users className="w-6 h-6" />}
          color="primary"
        />
        <StatCard
          title="Active Jobs"
          value={stats.totalJobs.toLocaleString()}
          icon={<Briefcase className="w-6 h-6" />}
          color="success"
        />
        <StatCard
          title="Total Applications"
          value={stats.totalApplications.toLocaleString()}
          icon={<FileText className="w-6 h-6" />}
          color="purple"
        />
        <StatCard
          title="Pending Review"
          value={stats.pendingApplications.toLocaleString()}
          icon={<Eye className="w-6 h-6" />}
          color="warning"
        />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
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
            onRowClick={(app) => navigate(`/applications/${app._id}`)}
          />
        </Card>

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
              <p className="text-sm text-gray-500 mt-0.5">{stats.pendingApplications} pending</p>
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
