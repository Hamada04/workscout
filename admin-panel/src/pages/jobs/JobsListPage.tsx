import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { Plus, Eye, Edit2, Trash2, MoreHorizontal, ToggleLeft, ToggleRight } from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  DataTable, 
  SearchFilterBar, 
  Button,
  ConfirmDialog,
  Select,
  Badge,
  EmptyState
} from '@/components/common';
import { formatDate, timeAgo } from '@/utils/helpers';
import { Job } from '@/types';
import { JOB_CATEGORIES, JOB_TYPES, EXPERIENCE_LEVELS } from '@/utils/constants';

// Mock data
const mockJobs: Job[] = [
  {
    _id: '1',
    companyName: 'Netflix',
    jobTitle: 'Senior UI Designer',
    location: 'California, USA',
    jobType: 'Fulltime',
    contractType: 'Permanent',
    experienceLevel: 'Senior',
    postedDate: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
    salary: '$ 15,000',
    companyLogo: '',
    category: 'Design',
    description: 'Join Netflix design team...',
    officeAddress: 'Los Gatos, California',
    skills: ['UI Design', 'UX Design', 'Figma'],
    responsibilities: ['Lead design projects'],
    requirements: ['5+ years experience'],
    benefits: ['Health insurance', 'Stock options'],
    isActive: true,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    _id: '2',
    companyName: 'Telegram',
    jobTitle: 'Flutter Developer',
    location: 'Dubai, UAE',
    jobType: 'Remote',
    contractType: 'Contract',
    experienceLevel: 'Mid',
    postedDate: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
    salary: '$ 12,000',
    companyLogo: '',
    category: 'Technology',
    description: 'Build mobile apps...',
    officeAddress: 'Dubai, UAE',
    skills: ['Flutter', 'Dart', 'Firebase'],
    responsibilities: ['Develop mobile apps'],
    requirements: ['3+ years experience'],
    benefits: ['Remote work'],
    isActive: true,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    _id: '3',
    companyName: 'Startup Inc',
    jobTitle: 'Digital Marketing Specialist',
    location: 'Remote',
    jobType: 'Parttime',
    contractType: 'Contract',
    experienceLevel: 'Junior',
    postedDate: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000).toISOString(),
    salary: '$ 5,000',
    companyLogo: '',
    category: 'Marketing',
    description: 'Marketing role...',
    officeAddress: 'Remote',
    skills: ['SEO', 'Social Media'],
    responsibilities: ['Manage campaigns'],
    requirements: ['1+ years experience'],
    benefits: ['Flexible hours'],
    isActive: false,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
];

const categoryOptions = [
  { value: '', label: 'All Categories' },
  ...JOB_CATEGORIES.map(c => ({ value: c, label: c })),
];

const jobTypeOptions = [
  { value: '', label: 'All Types' },
  ...JOB_TYPES.map(t => ({ value: t, label: t })),
];

const statusOptions = [
  { value: '', label: 'All Status' },
  { value: 'active', label: 'Active' },
  { value: 'inactive', label: 'Inactive' },
];

export default function JobsListPage() {
  const navigate = useNavigate();
  
  const [jobs, setJobs] = useState<Job[]>(mockJobs);
  const [isLoading, setIsLoading] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('');
  const [typeFilter, setTypeFilter] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [selectedJob, setSelectedJob] = useState<Job | null>(null);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);

  const filteredJobs = useMemo(() => {
    return jobs.filter(job => {
      const matchesSearch = searchQuery === '' || 
        job.jobTitle.toLowerCase().includes(searchQuery.toLowerCase()) ||
        job.companyName.toLowerCase().includes(searchQuery.toLowerCase());
      
      const matchesCategory = categoryFilter === '' || job.category === categoryFilter;
      const matchesType = typeFilter === '' || job.jobType === typeFilter;
      const matchesStatus = statusFilter === '' || 
        (statusFilter === 'active' && job.isActive) ||
        (statusFilter === 'inactive' && !job.isActive);
      
      return matchesSearch && matchesCategory && matchesType && matchesStatus;
    });
  }, [jobs, searchQuery, categoryFilter, typeFilter, statusFilter]);

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
              <span className="text-lg font-bold text-gray-400">{job.companyName[0]}</span>
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
      key: 'isActive',
      label: 'Status',
      sortable: true,
      render: (job: Job) => (
        <span className={`inline-flex px-2.5 py-1 text-xs font-medium rounded-full ${
          job.isActive ? 'bg-green-50 text-green-700' : 'bg-gray-100 text-gray-600'
        }`}>
          {job.isActive ? 'Active' : 'Inactive'}
        </span>
      ),
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
              setJobs(jobs.map(j => j._id === job._id ? { ...j, isActive: !j.isActive } : j));
            }}
            className="p-1.5 text-gray-500 hover:text-green-600 hover:bg-green-50 rounded-lg transition-colors"
            title={job.isActive ? 'Deactivate' : 'Activate'}
          >
            {job.isActive ? <ToggleRight className="w-4 h-4" /> : <ToggleLeft className="w-4 h-4" />}
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

  const handleDelete = () => {
    if (selectedJob) {
      setJobs(jobs.filter(j => j._id !== selectedJob._id));
      setShowDeleteDialog(false);
      setSelectedJob(null);
    }
  };

  const handleResetFilters = () => {
    setSearchQuery('');
    setCategoryFilter('');
    setTypeFilter('');
    setStatusFilter('');
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
          onSearchChange={setSearchQuery}
          searchPlaceholder="Search jobs by title or company..."
          filters={[
            { key: 'category', label: 'Category', options: categoryOptions, value: categoryFilter, onChange: setCategoryFilter },
            { key: 'type', label: 'Type', options: jobTypeOptions, value: typeFilter, onChange: setTypeFilter },
            { key: 'status', label: 'Status', options: statusOptions, value: statusFilter, onChange: setStatusFilter },
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
