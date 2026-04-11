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
  XCircle,
  Clock,
  Briefcase,
  User
} from 'lucide-react';
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
import { Application, ApplicationStatus } from '@/types';
import { APPLICATION_STATUSES } from '@/utils/constants';

const mockApplication = {
  _id: '1',
  userId: 'u1',
  jobId: 'j1',
  resumeUrl: '/resumes/sarah-johnson.pdf',
  coverLetter: 'Dear Hiring Team,\n\nI am writing to express my strong interest in the Senior UI Designer position at Netflix. With over 5 years of experience in UI/UX design and a passion for creating exceptional user experiences, I believe I would be a valuable addition to your team.\n\nThroughout my career, I have had the opportunity to work on various projects that have honed my skills in user research, wireframing, prototyping, and visual design. I am proficient in Figma, Sketch, and Adobe Creative Suite, and I stay up-to-date with the latest design trends and best practices.\n\nI am particularly drawn to Netflix\'s commitment to delivering high-quality content and seamless user experiences across multiple platforms. Your focus on data-driven design decisions aligns perfectly with my approach to creating intuitive and engaging interfaces.\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to Netflix\'s continued success.\n\nBest regards,\nSarah Johnson',
  status: 'Interview' as ApplicationStatus,
  adminMessage: 'We are impressed with your profile and would like to schedule an interview.',
  appliedDate: new Date(Date.now() - 2 * 60 * 60 * 1000).toISOString(),
  createdAt: new Date().toISOString(),
  updatedAt: new Date().toISOString(),
  user: {
    _id: 'u1',
    name: 'Sarah Johnson',
    email: 'sarah@example.com',
    role: 'user' as const,
    location: 'California, USA',
    profilePic: '',
    skills: ['UI Design', 'Figma', 'User Research', 'Prototyping'],
    languages: ['English', 'Spanish'],
    education: [{ degree: 'BSc Computer Science', university: 'Stanford', level: 'Bachelor', date: '2018' }],
    experiences: [{ title: 'Senior Designer', company: 'Tech Corp', date: '2022-Present', logo: '' }],
    savedJobsIds: [],
    createdAt: '',
    updatedAt: '',
    isActive: true,
  },
  job: {
    _id: 'j1',
    companyName: 'Netflix',
    jobTitle: 'Senior UI Designer',
    location: 'California, USA',
    jobType: 'Fulltime',
    contractType: 'Permanent',
    experienceLevel: 'Senior',
    postedDate: '',
    salary: '$ 15,000',
    companyLogo: '',
    category: 'Design',
    description: '',
    officeAddress: 'Los Gatos, California',
    skills: ['UI Design', 'UX Design'],
    responsibilities: [],
    requirements: [],
    benefits: [],
    isActive: true,
    createdAt: '',
    updatedAt: '',
  },
};

const statusOptions = APPLICATION_STATUSES.map(s => ({ value: s, label: s }));

export default function ApplicationDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  
  const [application, setApplication] = useState<typeof mockApplication | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [showMessageModal, setShowMessageModal] = useState(false);
  const [showStatusModal, setShowStatusModal] = useState(false);
  const [message, setMessage] = useState('');
  const [newStatus, setNewStatus] = useState<ApplicationStatus>('Submitted');

  useEffect(() => {
    const timer = setTimeout(() => {
      setApplication(mockApplication);
      setNewStatus(mockApplication.status);
      setIsLoading(false);
    }, 500);
    return () => clearTimeout(timer);
  }, [id]);

  const handleStatusUpdate = () => {
    if (application) {
      setApplication({ ...application, status: newStatus });
      setShowStatusModal(false);
    }
  };

  const handleSendMessage = () => {
    if (application && message.trim()) {
      setApplication({ ...application, adminMessage: message });
      setShowMessageModal(false);
      setMessage('');
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

  return (
    <div className="space-y-6 animate-fadeIn">
      {/* Header */}
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
              Applied {timeAgo(application.appliedDate)}
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

      {/* Main Content */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left Column */}
        <div className="space-y-6">
          {/* Applicant Card */}
          <Card>
            <SectionHeader title="Applicant" />
            <div className="flex items-center gap-4 mb-4">
              <Avatar name={application.user.name} size="lg" />
              <div>
                <p className="font-semibold text-gray-900">{application.user.name}</p>
                <p className="text-sm text-gray-500">{application.user.email}</p>
              </div>
            </div>
            <div className="space-y-2">
              <div className="flex items-center gap-2 text-sm">
                <User className="w-4 h-4 text-gray-400" />
                <span className="text-gray-600">{application.user.location}</span>
              </div>
              <div className="flex items-center gap-2 text-sm">
                <Briefcase className="w-4 h-4 text-gray-400" />
                <span className="text-gray-600">{application.user.experiences[0]?.title || 'No experience listed'}</span>
              </div>
            </div>
            <div className="mt-4 pt-4 border-t border-gray-100">
              <p className="text-sm font-medium text-gray-700 mb-2">Skills</p>
              <div className="flex flex-wrap gap-1.5">
                {application.user.skills.map((skill) => (
                  <span key={skill} className="px-2 py-0.5 bg-gray-100 text-gray-700 text-xs rounded">
                    {skill}
                  </span>
                ))}
              </div>
            </div>
          </Card>

          {/* Job Card */}
          <Card>
            <SectionHeader title="Applied For" />
            <div className="p-3 bg-gray-50 rounded-lg">
              <p className="font-semibold text-gray-900">{application.job.jobTitle}</p>
              <p className="text-sm text-gray-500">{application.job.companyName}</p>
              <div className="flex items-center gap-4 mt-2 text-sm text-gray-500">
                <span>{application.job.location}</span>
                <span>•</span>
                <span>{application.job.salary}</span>
              </div>
            </div>
            <Button variant="outline" className="w-full mt-4" size="sm">
              View Job Details
            </Button>
          </Card>

          {/* Resume */}
          <Card>
            <SectionHeader title="Resume" />
            <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
              <div className="w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center">
                <FileText className="w-5 h-5 text-red-500" />
              </div>
              <div className="flex-1">
                <p className="font-medium text-gray-900">Sarah_Johnson_Resume.pdf</p>
                <p className="text-xs text-gray-500">245 KB • PDF</p>
              </div>
              <Button variant="ghost" size="sm">
                <Download className="w-4 h-4" />
              </Button>
            </div>
          </Card>
        </div>

        {/* Right Column - Cover Letter & Messages */}
        <div className="lg:col-span-2 space-y-6">
          {/* Cover Letter */}
          <Card>
            <SectionHeader title="Cover Letter" />
            <div className="prose prose-sm max-w-none">
              <p className="text-gray-600 whitespace-pre-line leading-relaxed">
                {application.coverLetter}
              </p>
            </div>
          </Card>

          {/* Admin Message */}
          {application.adminMessage && (
            <Card className="bg-primary-50 border-primary-100">
              <SectionHeader title="Your Message to Applicant" />
              <p className="text-gray-700">{application.adminMessage}</p>
              <p className="text-xs text-gray-400 mt-2">
                Sent {formatDate(application.updatedAt)}
              </p>
            </Card>
          )}

          {/* Timeline / Activity */}
          <Card>
            <SectionHeader title="Application Timeline" />
            <div className="space-y-4">
              <div className="flex gap-4">
                <div className="w-8 h-8 rounded-full bg-primary-100 flex items-center justify-center flex-shrink-0">
                  <CheckCircle className="w-4 h-4 text-primary-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">Application Submitted</p>
                  <p className="text-sm text-gray-500">{formatDate(application.appliedDate, 'long')}</p>
                </div>
              </div>
              {application.status !== 'Submitted' && (
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
              {(application.status === 'Interview' || application.status === 'Accepted') && (
                <div className="flex gap-4">
                  <div className="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center flex-shrink-0">
                    <User className="w-4 h-4 text-purple-600" />
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

      {/* Status Update Modal */}
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

      {/* Message Modal */}
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
