import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { 
  ArrowLeft, 
  Edit2, 
  Trash2, 
  MapPin, 
  DollarSign,
  Clock,
  Users,
  Briefcase,
  CheckCircle,
  XCircle
} from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  Button, 
  Badge,
  ConfirmDialog,
  SectionHeader
} from '@/components/common';
import { formatDate, timeAgo } from '@/utils/helpers';
import { Job, JobFormData } from '@/types';
import { useAuth } from '@/contexts/AuthContext';
import { jobService } from '@/services/jobService';

export default function JobDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { token } = useAuth();
  
  const [job, setJob] = useState<Job | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);

  useEffect(() => {
    if (!token || !id) return;
    setIsLoading(true);
    jobService.getById(token, id)
      .then(setJob)
      .catch(() => setJob(null))
      .finally(() => setIsLoading(false));
  }, [id, token]);

  const handleDelete = async () => {
    if (!token || !id) return;
    try {
      await jobService.delete(token, id);
      navigate('/jobs');
    } catch (error) {
      console.error('Failed to delete job:', error);
    }
  };

  const handleToggleStatus = async () => {
    if (!token || !id || !job) return;
    const newStatus = !job.isActive;
    try {
      await jobService.update(token, id, { isActive: newStatus } as Partial<JobFormData>);
      setJob({ ...job, isActive: newStatus });
    } catch (error) {
      console.error('Failed to toggle status:', error);
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="w-8 h-8 border-4 border-primary-200 border-t-primary-600 rounded-full animate-spin" />
      </div>
    );
  }

  if (!job) {
    return (
      <Card>
        <div className="text-center py-12">
          <p className="text-gray-500">Job not found</p>
          <Button variant="outline" onClick={() => navigate('/jobs')} className="mt-4">
            Back to Jobs
          </Button>
        </div>
      </Card>
    );
  }

  return (
    <div className="space-y-6 animate-fadeIn">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/jobs">
            <Button variant="ghost" size="sm" className="p-2">
              <ArrowLeft className="w-5 h-5" />
            </Button>
          </Link>
          <div>
            <div className="flex items-center gap-3">
              <h1 className="text-2xl font-bold text-gray-900">{job.jobTitle}</h1>
              <span className={`inline-flex px-3 py-1 text-sm font-medium rounded-full ${
                job.isActive ? 'bg-green-50 text-green-700' : 'bg-gray-100 text-gray-600'
              }`}>
                {job.isActive ? 'Active' : 'Inactive'}
              </span>
            </div>
            <p className="text-gray-500 mt-1">{job.companyName} • Posted {timeAgo(job.postedDate)}</p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          <Button 
            variant="outline" 
            onClick={() => navigate(`/jobs/${id}/edit`)}
            leftIcon={<Edit2 className="w-4 h-4" />}
          >
            Edit
          </Button>
          <Button 
            variant={job.isActive ? 'outline' : 'primary'} 
            onClick={handleToggleStatus}
          >
            {job.isActive ? 'Deactivate' : 'Activate'}
          </Button>
          <Button 
            variant="danger" 
            onClick={() => setShowDeleteDialog(true)}
            leftIcon={<Trash2 className="w-4 h-4" />}
          >
            Delete
          </Button>
        </div>
      </div>

      {/* Main Content */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left Column - Job Details */}
        <div className="lg:col-span-2 space-y-6">
          {/* Quick Stats */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <Card className="text-center">
              <DollarSign className="w-6 h-6 text-green-500 mx-auto mb-2" />
              <p className="text-lg font-bold text-gray-900">{job.salary}</p>
              <p className="text-sm text-gray-500">Salary</p>
            </Card>
            <Card className="text-center">
              <MapPin className="w-6 h-6 text-blue-500 mx-auto mb-2" />
              <p className="text-sm font-medium text-gray-900">{job.location}</p>
              <p className="text-sm text-gray-500">Location</p>
            </Card>
            <Card className="text-center">
              <Briefcase className="w-6 h-6 text-purple-500 mx-auto mb-2" />
              <p className="text-sm font-medium text-gray-900">{job.jobType}</p>
              <p className="text-sm text-gray-500">Type</p>
            </Card>
            <Card className="text-center">
              <Users className="w-6 h-6 text-orange-500 mx-auto mb-2" />
              <p className="text-sm font-medium text-gray-900">{job.experienceLevel}</p>
              <p className="text-sm text-gray-500">Experience</p>
            </Card>
          </div>

          {/* Description */}
          <Card>
            <SectionHeader title="Job Description" />
            <p className="text-gray-600 leading-relaxed">{job.description}</p>
          </Card>

          {/* Responsibilities */}
          <Card>
            <SectionHeader title="Responsibilities" />
            <ul className="space-y-3">
              {job.responsibilities.map((item, index) => (
                <li key={index} className="flex items-start gap-3">
                  <CheckCircle className="w-5 h-5 text-green-500 flex-shrink-0 mt-0.5" />
                  <span className="text-gray-600">{item}</span>
                </li>
              ))}
            </ul>
          </Card>

          {/* Requirements */}
          <Card>
            <SectionHeader title="Requirements" />
            <ul className="space-y-3">
              {job.requirements.map((item, index) => (
                <li key={index} className="flex items-start gap-3">
                  <div className="w-5 h-5 rounded-full bg-primary-100 text-primary-600 flex items-center justify-center flex-shrink-0 mt-0.5">
                    <span className="text-xs font-bold">{index + 1}</span>
                  </div>
                  <span className="text-gray-600">{item}</span>
                </li>
              ))}
            </ul>
          </Card>

          {/* Benefits */}
          <Card>
            <SectionHeader title="Benefits" />
            <ul className="space-y-3">
              {job.benefits.map((item, index) => (
                <li key={index} className="flex items-start gap-3">
                  <CheckCircle className="w-5 h-5 text-green-500 flex-shrink-0 mt-0.5" />
                  <span className="text-gray-600">{item}</span>
                </li>
              ))}
            </ul>
          </Card>
        </div>

        {/* Right Column - Sidebar */}
        <div className="space-y-6">
          {/* Skills */}
          <Card>
            <SectionHeader title="Required Skills" />
            <div className="flex flex-wrap gap-2">
              {job.skills.map((skill) => (
                <Badge key={skill} variant="default">{skill}</Badge>
              ))}
            </div>
          </Card>

          {/* Job Info */}
          <Card>
            <SectionHeader title="Job Information" />
            <div className="space-y-4">
              <div className="flex justify-between py-2 border-b border-gray-100">
                <span className="text-gray-500">Category</span>
                <span className="font-medium text-gray-900">{job.category}</span>
              </div>
              <div className="flex justify-between py-2 border-b border-gray-100">
                <span className="text-gray-500">Job Type</span>
                <span className="font-medium text-gray-900">{job.jobType}</span>
              </div>
              <div className="flex justify-between py-2 border-b border-gray-100">
                <span className="text-gray-500">Contract Type</span>
                <span className="font-medium text-gray-900">{job.contractType}</span>
              </div>
              <div className="flex justify-between py-2 border-b border-gray-100">
                <span className="text-gray-500">Experience</span>
                <span className="font-medium text-gray-900">{job.experienceLevel}</span>
              </div>
              <div className="flex justify-between py-2 border-b border-gray-100">
                <span className="text-gray-500">Salary</span>
                <span className="font-medium text-gray-900">{job.salary}</span>
              </div>
              <div className="flex justify-between py-2">
                <span className="text-gray-500">Office Address</span>
                <span className="font-medium text-gray-900 text-right max-w-[180px]">{job.officeAddress}</span>
              </div>
            </div>
          </Card>

          {/* Stats */}
          <Card>
            <SectionHeader title="Statistics" />
            <div className="grid grid-cols-2 gap-4">
              <div className="text-center p-4 bg-gray-50 rounded-lg">
                <p className="text-2xl font-bold text-gray-900">24</p>
                <p className="text-sm text-gray-500">Applications</p>
              </div>
              <div className="text-center p-4 bg-gray-50 rounded-lg">
                <p className="text-2xl font-bold text-gray-900">156</p>
                <p className="text-sm text-gray-500">Views</p>
              </div>
            </div>
          </Card>
        </div>
      </div>

      <ConfirmDialog
        isOpen={showDeleteDialog}
        onClose={() => setShowDeleteDialog(false)}
        onConfirm={handleDelete}
        title="Delete Job"
        message={`Are you sure you want to delete "${job.jobTitle}"? This action cannot be undone.`}
        confirmText="Delete"
        variant="danger"
      />
    </div>
  );
}
