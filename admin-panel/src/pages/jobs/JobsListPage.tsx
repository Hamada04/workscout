import React, { useState, useEffect, useMemo, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { Eye, Edit2, Trash2, ToggleLeft, ToggleRight } from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  DataTable, 
  SearchFilterBar, 
  ConfirmDialog,
  Badge,
  Pagination
} from '@/components/common';
import { timeAgo } from '@/utils/helpers';
import { Job } from '@/types';
import { useAuth } from '@/contexts/AuthContext';
import { jobService } from '@/services/jobService';

const categoryOptions = [
  { value: '', label: 'All Categories' },
  { value: 'Technology', label: 'Technology' },
  { value: 'Design', label: 'Design' },
  { value: 'Marketing', label: 'Marketing' },
  // { value: 'Sales', label: 'Sales' },
  // { value: 'Healthcare', label: 'Healthcare' },
  // { value: 'Education', label: 'Education' },
  // { value: 'Finance', label: 'Finance' },
];

const jobTypeOptions = [
  { value: '', label: 'All Types' },
  { value: 'Full-time', label: 'Full-time' },
  { value: 'Part-time', label: 'Part-time' },
  { value: 'Remote', label: 'Remote' },
  { value: 'Contract', label: 'Contract' },
];

const statusOptions = [
  { value: '', label: 'All Status' },
  { value: 'active', label: 'Active' },
  { value: 'inactive', label: 'Inactive' },
];

export default function JobsListPage() {
  const navigate = useNavigate();
  const { token } = useAuth();
  
  const [jobs, setJobs] = useState<Job[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('');
  const [typeFilter, setTypeFilter] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  const [selectedJob, setSelectedJob] = useState<Job | null>(null);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);

  const loadJobs = useCallback(async () => {
    if (!token) return;
    
    try {
      setIsLoading(true);
      const response = await jobService.getAll(token, {
        page: currentPage,
        limit: 10,
        search: searchQuery,
        category: categoryFilter,
      });
      
      let filteredJobs = response.jobs ?? [];
      if (typeFilter) {
        filteredJobs = filteredJobs.filter(j => j.jobType === typeFilter);
      }
      
      setJobs(filteredJobs);
      setTotalPages(response.pages);
      setTotal(response.total);
    } catch (error) {
      console.error('Failed to load jobs:', error);
    } finally {
      setIsLoading(false);
    }
  }, [token, currentPage, searchQuery, categoryFilter, typeFilter]);

  useEffect(() => {
    let cancelled = false;
    loadJobs().then(() => {
      if (cancelled) return;
    });
    return () => { cancelled = true; };
  }, [loadJobs]);

  const filteredJobs = useMemo(() => {
    if (statusFilter === '') return jobs;
    return jobs.filter(job =>
      statusFilter === 'active' ? job.isActive !== false : job.isActive === false
    );
  }, [jobs, statusFilter]);

  const columns = [
    {
      key: 'jobTitle',
      label: 'Job',
      sortable: true,
      render: (job: Job) => (
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-gray-100 flex items-center justify-center overflow-hidden">
            {job.companyLogo ? (
              <img src={job.companyLogo} alt={job.companyName} className="w-full h-full object-cover" />
            ) : (
              <span className="text-lg font-bold text-gray-400">{job.companyName?.[0]}</span>
            )}
          </div>
          <div>
            <p className="font-medium text-gray-900">{job.jobTitle}</p>
            <p className="text-sm text-gray-500">{job.companyName}</p>
          </div>
        </div>
      ),
    },
    {
      key: 'category',
      label: 'Category',
      sortable: true,
      render: (job: Job) => <Badge variant="default">{job.category}</Badge>,
    },
    {
      key: 'jobType',
      label: 'Type',
      render: (job: Job) => <Badge variant="gray">{job.jobType}</Badge>,
    },
    {
      key: 'location',
      label: 'Location',
      render: (job: Job) => <span className="text-gray-600 text-sm">{job.location}</span>,
    },
    {
      key: 'salary',
      label: 'Salary',
      sortable: true,
      render: (job: Job) => <span className="font-medium text-gray-900">{job.salary}</span>,
    },
    {
      key: 'postedDate',
      label: 'Posted',
      sortable: true,
      render: (job: Job) => <span className="text-gray-500 text-sm">{timeAgo(job.postedDate)}</span>,
    },
    {
      key: 'actions',
      label: 'Actions',
      render: (job: Job) => (
        <div className="flex items-center gap-1">
          <button
            onClick={(e) => { e.stopPropagation(); navigate(`/jobs/${job._id}`); }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="View"
          >
            <Eye className="w-4 h-4" />
          </button>
          <button
            onClick={(e) => { e.stopPropagation(); navigate(`/jobs/${job._id}/edit`); }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="Edit"
          >
            <Edit2 className="w-4 h-4" />
          </button>
          <button
            onClick={(e) => {
              e.stopPropagation();
              setSelectedJob(job);
              setShowDeleteDialog(true);
            }}
            className="p-1.5 text-gray-500 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
            title="Delete"
          >
            <Trash2 className="w-4 h-4" />
          </button>
        </div>
      ),
    },
  ];

  const handleDelete = async () => {
    if (!token || !selectedJob) return;
    
    try {
      await jobService.delete(token, selectedJob._id);
      setJobs(jobs.filter(j => j._id !== selectedJob._id));
      setShowDeleteDialog(false);
      setSelectedJob(null);
    } catch (error) {
      console.error('Failed to delete job:', error);
    }
  };

  const handleResetFilters = () => {
    setSearchQuery('');
    setCategoryFilter('');
    setTypeFilter('');
    setStatusFilter('');
    setCurrentPage(1);
  };

  const handleSearchChange = (value: string) => {
    setSearchQuery(value);
    setCurrentPage(1);
  };

  return (
    <div className="space-y-6 animate-fadeIn">
      <PageHeader
        title="Jobs"
        subtitle="Manage job postings and listings"
        showAddButton
        onAddClick={() => navigate('/jobs/new')}
        addButtonText="Add Job"
      />

      <Card>
        <SearchFilterBar
          searchValue={searchQuery}
          onSearchChange={handleSearchChange}
          searchPlaceholder="Search jobs by title or company..."
          filters={[
            { key: 'category', label: 'Category', options: categoryOptions, value: categoryFilter, onChange: (v) => { setCategoryFilter(v); setCurrentPage(1); } },
            { key: 'type', label: 'Type', options: jobTypeOptions, value: typeFilter, onChange: (v) => { setTypeFilter(v); setCurrentPage(1); } },
          ]}
          onReset={handleResetFilters}
        />
      </Card>

      <Card padding="none">
        <DataTable
          columns={columns}
          data={filteredJobs}
          keyField="_id"
          isLoading={isLoading}
          onRowClick={(job) => navigate(`/jobs/${job._id}`)}
          emptyMessage="No jobs found matching your criteria"
        />
        {totalPages > 1 && (
          <div className="border-t">
            <Pagination
              currentPage={currentPage}
              totalPages={totalPages}
              onPageChange={setCurrentPage}
              totalItems={total}
              itemsPerPage={10}
            />
          </div>
        )}
      </Card>

      <ConfirmDialog
        isOpen={showDeleteDialog}
        onClose={() => { setShowDeleteDialog(false); setSelectedJob(null); }}
        onConfirm={handleDelete}
        title="Delete Job"
        message={`Are you sure you want to delete "${selectedJob?.jobTitle}"? This action cannot be undone.`}
        confirmText="Delete"
        variant="danger"
      />
    </div>
  );
}
