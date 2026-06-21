import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { 
  ArrowLeft, 
  Mail, 
  FileText,
  Download,
  MessageSquare,
  Send,
  CheckCircle,
  Clock,
  Briefcase,
  User as UserIcon
} from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { applicationService } from '@/services/applicationService';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  Button, 
  Avatar,
  StatusBadge,
  Select,
  Textarea,
  Modal,
  SectionHeader
} from '@/components/common';
import { formatDate, timeAgo } from '@/utils/helpers';
import { Application, ApplicationStatus, User, Job } from '@/types';
import { APPLICATION_STATUSES } from '@/utils/constants';

const statusOptions = APPLICATION_STATUSES.map(s => ({ value: s, label: s }));

export default function ApplicationDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { token } = useAuth();
  
  const [application, setApplication] = useState<Application | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [showMessageModal, setShowMessageModal] = useState(false);
  const [showStatusModal, setShowStatusModal] = useState(false);
  const [message, setMessage] = useState('');
  const [newStatus, setNewStatus] = useState<ApplicationStatus>('pending');

  useEffect(() => {
    if (!token || !id) return;
    setIsLoading(true);
    applicationService.getById(token, id)
      .then(res => {
        const app = (res as unknown as Record<string, unknown>)?.['data'] as Application ?? (res as unknown as Application);
        setApplication(app);
        setNewStatus(app.status);
      })
      .catch(() => setApplication(null))
      .finally(() => setIsLoading(false));
  }, [id, token]);

  const handleStatusUpdate = async () => {
    if (!token || !id || !application) return;
    try {
      await applicationService.updateStatus(token, id, newStatus);
      const fresh = await applicationService.getById(token, id);
      const app = (fresh as unknown as Record<string, unknown>)?.['data'] as Application ?? (fresh as unknown as Application);
      setApplication(app);
      setShowStatusModal(false);
    } catch {
      // Handled by interceptor
    }
  };

  const quickUpdate = async (status: ApplicationStatus) => {
    if (!token || !id || !application) return;
    try {
      await applicationService.updateStatus(token, id, status);
      const fresh = await applicationService.getById(token, id);
      const app = (fresh as unknown as Record<string, unknown>)?.['data'] as Application ?? (fresh as unknown as Application);
      setApplication(app);
    } catch {
      // Handled by interceptor
    }
  };

  const handleSendMessage = async () => {
    if (!token || !id || !application || !message.trim()) return;
    try {
      await applicationService.updateStatus(token, id, application.status, message);
      setApplication({ ...application, notes: message });
      setShowMessageModal(false);
      setMessage('');
    } catch {
      // Handled by interceptor
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="w-8 h-8 border-4 border-primary-200 border-t-primary-600 rounded-full animate-spin" />
      </div>
    );
  }

  if (!application) {
    return (
      <Card>
        <div className="text-center py-12">
          <p className="text-gray-500">Application not found</p>
          <Button variant="outline" onClick={() => navigate('/applications')} className="mt-4">
            Back to Applications
          </Button>
        </div>
      </Card>
    );
  }

  const applicant = application.userId as User;
  const job = application.jobId as Job;

  return (
    <div className="space-y-6 animate-fadeIn">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/applications">
            <Button variant="ghost" size="sm" className="p-2">
              <ArrowLeft className="w-5 h-5" />
            </Button>
          </Link>
          <div>
            <div className="flex items-center gap-3">
              <h1 className="text-2xl font-bold text-gray-900">Application Details</h1>
              <StatusBadge status={application.status} />
            </div>
            <p className="text-gray-500 mt-1">
              Applied {timeAgo(application.appliedAt ?? application.appliedDate ?? '')}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          <Button 
            variant="outline" 
            onClick={() => setShowStatusModal(true)}
            leftIcon={<Clock className="w-4 h-4" />}
          >
            Update Status
          </Button>
          {application.status === 'pending' && (
            <Button
              variant="outline"
              onClick={() => quickUpdate('reviewed')}
            >
              Mark Reviewed
            </Button>
          )}
          {(application.status === 'pending' || application.status === 'reviewed') && (
            <Button
              variant="outline"
              onClick={() => quickUpdate('interview')}
            >
              Shortlist Interview
            </Button>
          )}
          {application.status !== 'accepted' && application.status !== 'rejected' && (
            <>
              <Button
                variant="primary"
                onClick={() => quickUpdate('accepted')}
              >
                Accept
              </Button>
              <Button
                variant="outline"
                onClick={() => quickUpdate('rejected')}
              >
                Reject
              </Button>
            </>
          )}
          <Button 
            variant="outline" 
            onClick={() => setShowMessageModal(true)}
            leftIcon={<MessageSquare className="w-4 h-4" />}
          >
            Send Message
          </Button>
          <Button 
            variant="primary"
            onClick={() => navigate('/offers/new', { state: { applicationId: application._id } })}
            leftIcon={<Send className="w-4 h-4" />}
          >
            Send Offer
          </Button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="space-y-6">
          <Card>
            <SectionHeader title="Applicant" />
            <div className="flex items-center gap-4 mb-4">
              <Avatar name={applicant.name} size="lg" />
              <div>
                <p className="font-semibold text-gray-900">{applicant.name}</p>
                <p className="text-sm text-gray-500">{applicant.email}</p>
              </div>
            </div>
            <div className="space-y-2">
              <div className="flex items-center gap-2 text-sm">
                <UserIcon className="w-4 h-4 text-gray-400" />
                <span className="text-gray-600">{applicant.location}</span>
              </div>
              <div className="flex items-center gap-2 text-sm">
                <Briefcase className="w-4 h-4 text-gray-400" />
                <span className="text-gray-600">
                  {applicant.experiences?.[0]?.title || 'No experience listed'}
                </span>
              </div>
            </div>
            <div className="mt-4 pt-4 border-t border-gray-100">
              <p className="text-sm font-medium text-gray-700 mb-2">Skills</p>
              <div className="flex flex-wrap gap-1.5">
                {applicant.skills?.map((skill) => (
                  <span key={skill} className="px-2 py-0.5 bg-gray-100 text-gray-700 text-xs rounded">
                    {skill}
                  </span>
                ))}
              </div>
            </div>
          </Card>

          <Card>
            <SectionHeader title="Applied For" />
            <div className="p-3 bg-gray-50 rounded-lg">
              <p className="font-semibold text-gray-900">{job.jobTitle}</p>
              <p className="text-sm text-gray-500">{job.companyName}</p>
              <div className="flex items-center gap-4 mt-2 text-sm text-gray-500">
                <span>{job.location}</span>
                <span>•</span>
                <span>{job.salary}</span>
              </div>
            </div>
            <Button variant="outline" className="w-full mt-4" size="sm">
              View Job Details
            </Button>
          </Card>

          <Card>
            <SectionHeader title="Resume" />
            {application.cvUrl || application.resumeUrl ? (
              <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                <div className="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center">
                  <FileText className="w-5 h-5 text-red-500" />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="font-medium text-gray-900 truncate">
                    {(application.cvUrl || application.resumeUrl || '').split('/').pop() || 'Resume'}
                  </p>
                  <p className="text-xs text-gray-500">PDF</p>
                </div>
                <a
                  href={
                    (application.cvUrl || application.resumeUrl || '').startsWith('http')
                      ? (application.cvUrl || application.resumeUrl)
                      : `http://localhost:3000${application.cvUrl || application.resumeUrl}`
                  }
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <Button variant="ghost" size="sm">
                    <Download className="w-4 h-4" />
                  </Button>
                </a>
              </div>
            ) : (
              <p className="text-sm text-gray-400">No resume uploaded</p>
            )}
          </Card>
        </div>

        <div className="lg:col-span-2 space-y-6">
          <Card>
            <SectionHeader title="Cover Letter" />
            <div className="prose prose-sm max-w-none">
              <p className="text-gray-600 whitespace-pre-line leading-relaxed">
                {application.coverLetter || 'No cover letter provided'}
              </p>
            </div>
          </Card>

          {application.notes && (
            <Card className="bg-primary-50 border-primary-100">
              <SectionHeader title="Your Message to Applicant" />
              <p className="text-gray-700">{application.notes}</p>
              <p className="text-xs text-gray-400 mt-2">
                Sent {formatDate(application.updatedAt ?? '')}
              </p>
            </Card>
          )}

          <Card>
            <SectionHeader title="Application Timeline" />
            <div className="space-y-4">
              <div className="flex gap-4">
                <div className="w-8 h-8 rounded-full bg-primary-100 flex items-center justify-center flex-shrink-0">
                  <CheckCircle className="w-4 h-4 text-primary-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">Application Submitted</p>
                  <p className="text-sm text-gray-500">{formatDate(application.appliedAt ?? application.appliedDate ?? '', 'long')}</p>
                </div>
              </div>
              {application.status !== 'pending' && (
                <div className="flex gap-4">
                  <div className="w-8 h-8 rounded-full bg-yellow-100 flex items-center justify-center flex-shrink-0">
                    <Clock className="w-4 h-4 text-yellow-600" />
                  </div>
                  <div>
                    <p className="font-medium text-gray-900">Under Review</p>
                    <p className="text-sm text-gray-500">Application reviewed by team</p>
                  </div>
                </div>
              )}
              {(application.status === 'interview' || application.status === 'accepted') && (
                <div className="flex gap-4">
                  <div className="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center flex-shrink-0">
                    <UserIcon className="w-4 h-4 text-purple-600" />
                  </div>
                  <div>
                    <p className="font-medium text-gray-900">Interview Scheduled</p>
                    <p className="text-sm text-gray-500">Interview with hiring team</p>
                  </div>
                </div>
              )}
            </div>
          </Card>
        </div>
      </div>

      <Modal
        isOpen={showStatusModal}
        onClose={() => setShowStatusModal(false)}
        title="Update Application Status"
        footer={
          <div className="flex justify-end gap-3">
            <Button variant="outline" onClick={() => setShowStatusModal(false)}>Cancel</Button>
            <Button onClick={handleStatusUpdate}>Update Status</Button>
          </div>
        }
      >
        <Select
          label="New Status"
          value={newStatus}
          onChange={(e) => setNewStatus(e.target.value as ApplicationStatus)}
          options={statusOptions}
        />
      </Modal>

      <Modal
        isOpen={showMessageModal}
        onClose={() => setShowMessageModal(false)}
        title="Send Message to Applicant"
        footer={
          <div className="flex justify-end gap-3">
            <Button variant="outline" onClick={() => setShowMessageModal(false)}>Cancel</Button>
            <Button onClick={handleSendMessage} leftIcon={<Send className="w-4 h-4" />}>
              Send Message
            </Button>
          </div>
        }
      >
        <Textarea
          label="Message"
          value={message}
          onChange={(e) => setMessage(e.target.value)}
          placeholder="Type your message to the applicant..."
          rows={5}
        />
      </Modal>
    </div>
  );
}
