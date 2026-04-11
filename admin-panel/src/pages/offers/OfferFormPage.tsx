import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { ArrowLeft, Send } from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  Button,
  Input,
  Select,
  Textarea,
  FormActions,
  SectionHeader,
  Badge
} from '@/components/common';
import { formatDate } from '@/utils/helpers';
import { JOB_CATEGORIES } from '@/utils/constants';

// Mock applications for selection
const mockApplications = [
  { _id: 'a1', user: { name: 'Sarah Johnson' }, job: { jobTitle: 'Senior UI Designer', companyName: 'Netflix' } },
  { _id: 'a2', user: { name: 'Michael Chen' }, job: { jobTitle: 'Flutter Developer', companyName: 'Telegram' } },
];

const applicationOptions = mockApplications.map(a => ({
  value: a._id,
  label: `${a.user.name} - ${a.job.jobTitle} at ${a.job.companyName}`,
}));

export default function OfferFormPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const isEditing = !!id;
  
  const [formData, setFormData] = useState({
    applicationId: '',
    position: '',
    startDate: '',
    salary: '',
    location: '',
    reportingTo: '',
    responsibilities: '',
    benefits: '',
    termsAndConditions: '',
  });
  const [isSaving, setIsSaving] = useState(false);

  const handleChange = (field: string, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = () => {
    setIsSaving(true);
    setTimeout(() => {
      setIsSaving(false);
      navigate('/offers');
    }, 1000);
  };

  return (
    <div className="space-y-6 animate-fadeIn">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/offers">
            <Button variant="ghost" size="sm" className="p-2">
              <ArrowLeft className="w-5 h-5" />
            </Button>
          </Link>
          <div>
            <h1 className="text-2xl font-bold text-gray-900">
              {isEditing ? 'Edit Offer Letter' : 'Create Offer Letter'}
            </h1>
            <p className="text-gray-500">
              {isEditing ? 'Update offer details' : 'Create a new job offer for a candidate'}
            </p>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Main Form */}
        <div className="lg:col-span-2 space-y-6">
          {/* Application Selection */}
          <Card>
            <SectionHeader 
              title="Candidate & Position" 
              description="Select the application and position details"
            />
            <div className="space-y-4">
              <Select
                label="Application"
                value={formData.applicationId}
                onChange={(e) => handleChange('applicationId', e.target.value)}
                options={applicationOptions}
                placeholder="Select an application"
              />
              <Input
                label="Position Title"
                value={formData.position}
                onChange={(e) => handleChange('position', e.target.value)}
                placeholder="e.g., Senior UI Designer"
              />
            </div>
          </Card>

          {/* Compensation */}
          <Card>
            <SectionHeader title="Compensation & Start Date" />
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <Input
                label="Salary"
                value={formData.salary}
                onChange={(e) => handleChange('salary', e.target.value)}
                placeholder="e.g., $ 15,000/month"
              />
              <Input
                label="Proposed Start Date"
                type="date"
                value={formData.startDate}
                onChange={(e) => handleChange('startDate', e.target.value)}
              />
            </div>
          </Card>

          {/* Details */}
          <Card>
            <SectionHeader title="Offer Details" />
            <div className="space-y-4">
              <Input
                label="Work Location"
                value={formData.location}
                onChange={(e) => handleChange('location', e.target.value)}
                placeholder="e.g., California, USA or Remote"
              />
              <Input
                label="Reporting To"
                value={formData.reportingTo}
                onChange={(e) => handleChange('reportingTo', e.target.value)}
                placeholder="e.g., Design Director"
              />
              <Textarea
                label="Job Responsibilities"
                value={formData.responsibilities}
                onChange={(e) => handleChange('responsibilities', e.target.value)}
                placeholder="Describe key responsibilities..."
                rows={4}
              />
              <Textarea
                label="Benefits"
                value={formData.benefits}
                onChange={(e) => handleChange('benefits', e.target.value)}
                placeholder="List employee benefits..."
                rows={3}
              />
              <Textarea
                label="Terms & Conditions"
                value={formData.termsAndConditions}
                onChange={(e) => handleChange('termsAndConditions', e.target.value)}
                placeholder="Employment terms and conditions..."
                rows={3}
              />
            </div>
          </Card>

          <FormActions
            onCancel={() => navigate('/offers')}
            onSubmit={handleSubmit}
            isLoading={isSaving}
            submitText={isEditing ? 'Update Offer' : 'Send Offer'}
          />
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Help Card */}
          <Card className="bg-primary-50 border-primary-100">
            <h4 className="font-semibold text-primary-900 mb-2">Creating an Offer Letter</h4>
            <ul className="text-sm text-primary-700 space-y-2">
              <li>• Select the candidate's application</li>
              <li>• Verify position and compensation</li>
              <li>• Include start date and location</li>
              <li>• Detail responsibilities and benefits</li>
              <li>• Review terms and conditions</li>
            </ul>
          </Card>

          {/* Preview Card */}
          <Card>
            <SectionHeader title="Preview" />
            <div className="p-4 bg-gray-50 rounded-lg space-y-3">
              <div className="text-center border-b border-gray-200 pb-4">
                <h3 className="font-bold text-gray-900">WorkScout</h3>
                <p className="text-xs text-gray-500">Official Offer Letter</p>
              </div>
              <div className="space-y-2 text-sm">
                <p><span className="text-gray-500">Position:</span> {formData.position || 'Position Title'}</p>
                <p><span className="text-gray-500">Salary:</span> {formData.salary || '$ 0/month'}</p>
                <p><span className="text-gray-500">Start Date:</span> {formData.startDate || 'TBD'}</p>
                <p><span className="text-gray-500">Location:</span> {formData.location || 'TBD'}</p>
              </div>
            </div>
          </Card>
        </div>
      </div>
    </div>
  );
}
