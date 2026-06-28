import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link, useLocation } from 'react-router-dom';
import { ArrowLeft, Send } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { offerService } from '@/services/offerService';
import { applicationService } from '@/services/applicationService';
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
import { Application, User, Job } from '@/types';

export default function OfferFormPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const location = useLocation();
  const { token } = useAuth();
  const isEditing = !!id;

  const [applications, setApplications] = useState<Application[]>([]);
  const [isLoadingApps, setIsLoadingApps] = useState(true);

  const [formData, setFormData] = useState({
    applicationId: '',
    position: '',
    startDate: '',
    salary: '',
    department: '',
    message: '',
    expiresInDays: 14,
  });
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    if (!token) return;
    setIsLoadingApps(true);
    applicationService.getAll(token)
      .then((res) => {
        const items = (res as unknown as Record<string, unknown>)['applications'] as Application[] ?? [];
        setApplications(items);

        const preSelectedId = (location.state as Record<string, string>)?.['applicationId'];
        if (preSelectedId && items.some(a => a._id === preSelectedId)) {
          setFormData(prev => ({ ...prev, applicationId: preSelectedId }));
        }
      })
      .catch(() => {})
      .finally(() => setIsLoadingApps(false));
  }, [token, location.state]);

  const applicationOptions = applications.map(a => {
    const user = a.userId as User | undefined;
    const job = a.jobId as Job | undefined;
    return {
      value: a._id,
      label: `${user?.name ?? 'Unknown'} - ${job?.jobTitle ?? 'Unknown'} at ${job?.companyName ?? 'Unknown'}`,
    };
  });

  const handleChange = (field: string, value: string | number) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = async () => {
    if (!token) return;
    setIsSaving(true);
    try {
      const selectedApp = applications.find(a => a._id === formData.applicationId);
      const job = selectedApp?.jobId as Job | undefined;
      const user = selectedApp?.userId as User | undefined;

      await offerService.create(token, {
        userId: user?._id ?? '',
        jobId: job?._id ?? '',
        applicationId: formData.applicationId,
        salary: formData.salary,
        startDate: formData.startDate,
        position: formData.position,
        department: formData.department,
        message: formData.message,
        expiresInDays: formData.expiresInDays,
      });
      navigate('/offers');
    } catch {
      // Handled by interceptor
    } finally {
      setIsSaving(false);
    }
  };

  return (
    <div className="space-y-6 animate-fadeIn">
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
        <div className="lg:col-span-2 space-y-6">
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
                placeholder={isLoadingApps ? 'Loading applications...' : 'Select an application'}
              />
              <Input
                label="Position Title"
                value={formData.position}
                onChange={(e) => handleChange('position', e.target.value)}
                placeholder="e.g., Senior UI Designer"
              />
            </div>
          </Card>

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

          <Card>
            <SectionHeader title="Offer Details" />
            <div className="space-y-4">
              <Input
                label="Department"
                value={formData.department}
                onChange={(e) => handleChange('department', e.target.value)}
                placeholder="e.g., Design"
              />
              <Textarea
                label="Message"
                value={formData.message}
                onChange={(e) => handleChange('message', e.target.value)}
                placeholder="Personal message to the candidate..."
                rows={4}
              />
              <Input
                label="Expires In (days)"
                type="number"
                value={String(formData.expiresInDays)}
                onChange={(e) => handleChange('expiresInDays', parseInt(e.target.value) || 14)}
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

        <div className="space-y-6">
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
        </div>
      </div>
    </div>
  );
}
