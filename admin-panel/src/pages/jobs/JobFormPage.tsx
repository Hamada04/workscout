import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { ArrowLeft, Save } from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  Button, 
  Input,
  Select,
  Textarea,
  ChipsInput,
  FormActions,
  SectionHeader
} from '@/components/common';
import { JOB_CATEGORIES, JOB_TYPES, EXPERIENCE_LEVELS } from '@/utils/constants';
import { JobFormData } from '@/types';

const emptyForm: JobFormData = {
  companyName: '',
  jobTitle: '',
  location: '',
  jobType: 'Fulltime',
  contractType: 'Permanent',
  experienceLevel: 'Senior',
  salary: '',
  companyLogo: '',
  category: 'Technology',
  description: '',
  officeAddress: '',
  skills: [],
  responsibilities: [],
  requirements: [],
  benefits: [],
};

const categoryOptions = JOB_CATEGORIES.map(c => ({ value: c, label: c }));
const jobTypeOptions = JOB_TYPES.map(t => ({ value: t, label: t }));
const experienceOptions = EXPERIENCE_LEVELS.map(e => ({ value: e, label: e }));

export default function JobFormPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const isEditing = !!id;
  
  const [formData, setFormData] = useState<JobFormData>(emptyForm);
  const [isLoading, setIsLoading] = useState(false);
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    if (isEditing) {
      // Load job data for editing
      setIsLoading(false);
    }
  }, [id]);

  const handleChange = (field: keyof JobFormData, value: string | string[]) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = async () => {
    setIsSaving(true);
    // API call would go here
    setTimeout(() => {
      setIsSaving(false);
      navigate('/jobs');
    }, 1000);
  };

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
            <h1 className="text-2xl font-bold text-gray-900">
              {isEditing ? 'Edit Job' : 'Create New Job'}
            </h1>
            <p className="text-gray-500">
              {isEditing ? 'Update job posting details' : 'Fill in the details to create a new job posting'}
            </p>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Main Form */}
        <div className="lg:col-span-2 space-y-6">
          {/* Basic Information */}
          <Card>
            <SectionHeader title="Basic Information" description="Job title, company, and location" />
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <Input
                label="Job Title"
                value={formData.jobTitle}
                onChange={(e) => handleChange('jobTitle', e.target.value)}
                placeholder="e.g., Senior UI Designer"
                required
              />
              <Input
                label="Company Name"
                value={formData.companyName}
                onChange={(e) => handleChange('companyName', e.target.value)}
                placeholder="e.g., Netflix"
                required
              />
              <Input
                label="Location"
                value={formData.location}
                onChange={(e) => handleChange('location', e.target.value)}
                placeholder="e.g., California, USA"
                required
              />
              <Input
                label="Office Address"
                value={formData.officeAddress}
                onChange={(e) => handleChange('officeAddress', e.target.value)}
                placeholder="Full office address"
              />
            </div>
          </Card>

          {/* Job Details */}
          <Card>
            <SectionHeader title="Job Details" description="Category, type, and requirements" />
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <Select
                label="Category"
                value={formData.category}
                onChange={(e) => handleChange('category', e.target.value)}
                options={categoryOptions}
              />
              <Select
                label="Job Type"
                value={formData.jobType}
                onChange={(e) => handleChange('jobType', e.target.value)}
                options={jobTypeOptions}
              />
              <Select
                label="Experience Level"
                value={formData.experienceLevel}
                onChange={(e) => handleChange('experienceLevel', e.target.value)}
                options={experienceOptions}
              />
              <Input
                label="Salary"
                value={formData.salary}
                onChange={(e) => handleChange('salary', e.target.value)}
                placeholder="e.g., $ 12,000"
              />
            </div>
          </Card>

          {/* Description */}
          <Card>
            <SectionHeader title="Job Description" description="Detailed description of the role" />
            <Textarea
              value={formData.description}
              onChange={(e) => handleChange('description', e.target.value)}
              placeholder="Describe the role, team, and what makes this opportunity exciting..."
              rows={6}
            />
          </Card>

          {/* Requirements & Benefits */}
          <Card>
            <SectionHeader title="Requirements & Benefits" />
            <div className="space-y-4">
              <ChipsInput
                label="Requirements"
                value={formData.requirements}
                onChange={(value) => handleChange('requirements', value)}
                placeholder="Type requirement and press Enter"
              />
              <ChipsInput
                label="Benefits"
                value={formData.benefits}
                onChange={(value) => handleChange('benefits', value)}
                placeholder="Type benefit and press Enter"
              />
            </div>
          </Card>

          {/* Form Actions */}
          <FormActions
            onCancel={() => navigate('/jobs')}
            onSubmit={handleSubmit}
            isLoading={isSaving}
            submitText={isEditing ? 'Update Job' : 'Create Job'}
          />
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Skills */}
          <Card>
            <SectionHeader title="Required Skills" />
            <ChipsInput
              value={formData.skills}
              onChange={(value) => handleChange('skills', value)}
              placeholder="Type skill and press Enter"
            />
          </Card>

          {/* Company Logo */}
          <Card>
            <SectionHeader title="Company Logo" />
            <Input
              label="Logo URL"
              value={formData.companyLogo}
              onChange={(e) => handleChange('companyLogo', e.target.value)}
              placeholder="https://example.com/logo.png"
            />
            {formData.companyLogo && (
              <div className="mt-4 p-4 bg-gray-50 rounded-lg">
                <img 
                  src={formData.companyLogo} 
                  alt="Company Logo" 
                  className="w-20 h-20 object-contain mx-auto"
                  onError={(e) => (e.target as HTMLImageElement).style.display = 'none'}
                />
              </div>
            )}
          </Card>

          {/* Help Card */}
          <Card className="bg-primary-50 border-primary-100">
            <h4 className="font-semibold text-primary-900 mb-2">Tips for a great job posting</h4>
            <ul className="text-sm text-primary-700 space-y-2">
              <li>• Use a clear and specific job title</li>
              <li>• Include realistic salary ranges</li>
              <li>• List specific required skills</li>
              <li>• Describe growth opportunities</li>
              <li>• Highlight company culture</li>
            </ul>
          </Card>
        </div>
      </div>
    </div>
  );
}
