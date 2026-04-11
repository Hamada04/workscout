import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { 
  ArrowLeft, 
  Edit2, 
  Trash2, 
  Mail, 
  MapPin, 
  Calendar,
  Briefcase,
  GraduationCap,
  Languages,
  FileText,
  Bookmark
} from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  Button, 
  Avatar, 
  Badge,
  RoleBadge,
  ActiveBadge,
  ConfirmDialog,
  Tabs,
  SectionHeader,
  ChipsInput
} from '@/components/common';
import { formatDate } from '@/utils/helpers';
import { User } from '@/types';
import { USER_ROLES, JOB_CATEGORIES } from '@/utils/constants';

// Mock user data
const mockUser: User = {
  _id: '1',
  name: 'Sarah Johnson',
  email: 'sarah.j@example.com',
  role: 'user',
  location: 'California, USA',
  profilePic: '',
  skills: ['UI Design', 'Figma', 'User Research', 'Prototyping', 'Sketch'],
  languages: ['English', 'Spanish'],
  education: [
    { degree: 'BSc Computer Science', university: 'Stanford University', level: 'Bachelor', date: '2018 - 2022' },
  ],
  experiences: [
    { title: 'Senior UI Designer', company: 'Tech Corp', date: '2022 - Present', logo: '' },
    { title: 'Junior Designer', company: 'Startup Inc', date: '2020 - 2022', logo: '' },
  ],
  savedJobsIds: ['1', '2', '3'],
  createdAt: new Date(Date.now() - 90 * 24 * 60 * 60 * 1000).toISOString(),
  updatedAt: new Date().toISOString(),
  isActive: true,
};

export default function UserDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [activeTab, setActiveTab] = useState('overview');

  useEffect(() => {
    // Simulate API call
    const timer = setTimeout(() => {
      setUser(mockUser);
      setIsLoading(false);
    }, 500);
    return () => clearTimeout(timer);
  }, [id]);

  const handleDelete = () => {
    // Delete user API call would go here
    navigate('/users');
  };

  const handleStatusToggle = () => {
    if (user) {
      setUser({ ...user, isActive: !user.isActive });
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="w-8 h-8 border-4 border-primary-200 border-t-primary-600 rounded-full animate-spin" />
      </div>
    );
  }

  if (!user) {
    return (
      <Card>
        <div className="text-center py-12">
          <p className="text-gray-500">User not found</p>
          <Button variant="outline" onClick={() => navigate('/users')} className="mt-4">
            Back to Users
          </Button>
        </div>
      </Card>
    );
  }

  const tabs = [
    { id: 'overview', label: 'Overview' },
    { id: 'experience', label: 'Experience' },
    { id: 'education', label: 'Education' },
    { id: 'activity', label: 'Activity' },
  ];

  return (
    <div className="space-y-6 animate-fadeIn">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/users">
            <Button variant="ghost" size="sm" className="p-2">
              <ArrowLeft className="w-5 h-5" />
            </Button>
          </Link>
          <div>
            <h1 className="text-2xl font-bold text-gray-900">User Details</h1>
            <p className="text-gray-500">View and manage user account</p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          <Button 
            variant="outline" 
            onClick={() => navigate(`/users/${id}/edit`)}
            leftIcon={<Edit2 className="w-4 h-4" />}
          >
            Edit
          </Button>
          <Button 
            variant={user.isActive ? 'outline' : 'primary'} 
            onClick={handleStatusToggle}
          >
            {user.isActive ? 'Deactivate' : 'Activate'}
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
        {/* Left Column - Profile Card */}
        <div className="space-y-6">
          <Card>
            <div className="text-center pb-6 border-b border-gray-100">
              <Avatar name={user.name} src={user.profilePic} size="xl" className="mx-auto mb-4" />
              <h2 className="text-xl font-bold text-gray-900">{user.name}</h2>
              <p className="text-gray-500">{user.email}</p>
              <div className="flex items-center justify-center gap-2 mt-3">
                <RoleBadge role={user.role} />
                <ActiveBadge isActive={user.isActive} />
              </div>
            </div>
            
            <div className="py-6 space-y-4">
              <div className="flex items-center gap-3 text-gray-600">
                <Mail className="w-5 h-5 text-gray-400" />
                <span className="text-sm">{user.email}</span>
              </div>
              <div className="flex items-center gap-3 text-gray-600">
                <MapPin className="w-5 h-5 text-gray-400" />
                <span className="text-sm">{user.location || 'Not specified'}</span>
              </div>
              <div className="flex items-center gap-3 text-gray-600">
                <Calendar className="w-5 h-5 text-gray-400" />
                <span className="text-sm">Joined {formatDate(user.createdAt)}</span>
              </div>
            </div>

            <div className="pt-6 border-t border-gray-100">
              <div className="grid grid-cols-2 gap-4 text-center">
                <div>
                  <p className="text-2xl font-bold text-gray-900">{user.savedJobsIds.length}</p>
                  <p className="text-sm text-gray-500">Saved Jobs</p>
                </div>
                <div>
                  <p className="text-2xl font-bold text-gray-900">5</p>
                  <p className="text-sm text-gray-500">Applications</p>
                </div>
              </div>
            </div>
          </Card>

          {/* Skills Card */}
          <Card>
            <SectionHeader title="Skills" />
            <div className="flex flex-wrap gap-2">
              {user.skills.map((skill) => (
                <Badge key={skill} variant="default">{skill}</Badge>
              ))}
            </div>
          </Card>

          {/* Languages Card */}
          <Card>
            <SectionHeader title="Languages" />
            <div className="flex flex-wrap gap-2">
              {user.languages.map((lang) => (
                <Badge key={lang} variant="gray">{lang}</Badge>
              ))}
            </div>
          </Card>
        </div>

        {/* Right Column - Tabs Content */}
        <div className="lg:col-span-2">
          <Card padding="none">
            {/* Tabs Header */}
            <div className="border-b border-gray-200">
              <nav className="flex gap-8 px-6">
                {tabs.map((tab) => (
                  <button
                    key={tab.id}
                    onClick={() => setActiveTab(tab.id)}
                    className={`py-4 text-sm font-medium border-b-2 transition-colors ${
                      activeTab === tab.id
                        ? 'border-primary-500 text-primary-600'
                        : 'border-transparent text-gray-500 hover:text-gray-700'
                    }`}
                  >
                    {tab.label}
                  </button>
                ))}
              </nav>
            </div>

            {/* Tab Content */}
            <div className="p-6">
              {activeTab === 'overview' && (
                <div className="space-y-6">
                  {/* Experience Preview */}
                  <div>
                    <SectionHeader 
                      title="Experience" 
                      action={
                        <Link to={`/users/${id}?tab=experience`}>
                          <Button variant="ghost" size="sm">View All</Button>
                        </Link>
                      }
                    />
                    <div className="space-y-4">
                      {user.experiences.map((exp, index) => (
                        <div key={index} className="flex gap-4">
                          <div className="w-12 h-12 rounded-lg bg-gray-100 flex items-center justify-center flex-shrink-0">
                            <Briefcase className="w-6 h-6 text-gray-400" />
                          </div>
                          <div>
                            <p className="font-medium text-gray-900">{exp.title}</p>
                            <p className="text-sm text-gray-500">{exp.company}</p>
                            <p className="text-xs text-gray-400 mt-1">{exp.date}</p>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>

                  {/* Education Preview */}
                  <div>
                    <SectionHeader 
                      title="Education" 
                      action={
                        <Link to={`/users/${id}?tab=education`}>
                          <Button variant="ghost" size="sm">View All</Button>
                        </Link>
                      }
                    />
                    <div className="space-y-4">
                      {user.education.map((edu, index) => (
                        <div key={index} className="flex gap-4">
                          <div className="w-12 h-12 rounded-lg bg-orange-50 flex items-center justify-center flex-shrink-0">
                            <GraduationCap className="w-6 h-6 text-orange-500" />
                          </div>
                          <div>
                            <p className="font-medium text-gray-900">{edu.degree}</p>
                            <p className="text-sm text-gray-500">{edu.university}</p>
                            <p className="text-xs text-gray-400 mt-1">{edu.level} • {edu.date}</p>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              )}

              {activeTab === 'experience' && (
                <div className="space-y-6">
                  {user.experiences.map((exp, index) => (
                    <div key={index} className="p-4 border border-gray-200 rounded-lg">
                      <div className="flex items-start justify-between">
                        <div className="flex gap-4">
                          <div className="w-12 h-12 rounded-lg bg-gray-100 flex items-center justify-center">
                            <Briefcase className="w-6 h-6 text-gray-400" />
                          </div>
                          <div>
                            <p className="font-semibold text-gray-900">{exp.title}</p>
                            <p className="text-gray-600">{exp.company}</p>
                            <p className="text-sm text-gray-400 mt-1">{exp.date}</p>
                          </div>
                        </div>
                        <Button variant="ghost" size="sm">
                          <Edit2 className="w-4 h-4" />
                        </Button>
                      </div>
                    </div>
                  ))}
                  <Button variant="outline" className="w-full">
                    Add Experience
                  </Button>
                </div>
              )}

              {activeTab === 'education' && (
                <div className="space-y-6">
                  {user.education.map((edu, index) => (
                    <div key={index} className="p-4 border border-gray-200 rounded-lg">
                      <div className="flex items-start justify-between">
                        <div className="flex gap-4">
                          <div className="w-12 h-12 rounded-lg bg-orange-50 flex items-center justify-center">
                            <GraduationCap className="w-6 h-6 text-orange-500" />
                          </div>
                          <div>
                            <p className="font-semibold text-gray-900">{edu.degree}</p>
                            <p className="text-gray-600">{edu.university}</p>
                            <p className="text-sm text-gray-400 mt-1">{edu.level}</p>
                            <p className="text-xs text-gray-400">{edu.date}</p>
                          </div>
                        </div>
                        <Button variant="ghost" size="sm">
                          <Edit2 className="w-4 h-4" />
                        </Button>
                      </div>
                    </div>
                  ))}
                  <Button variant="outline" className="w-full">
                    Add Education
                  </Button>
                </div>
              )}

              {activeTab === 'activity' && (
                <div className="text-center py-12">
                  <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                    <FileText className="w-8 h-8 text-gray-400" />
                  </div>
                  <p className="text-gray-500">Activity log coming soon</p>
                </div>
              )}
            </div>
          </Card>
        </div>
      </div>

      {/* Delete Confirmation */}
      <ConfirmDialog
        isOpen={showDeleteDialog}
        onClose={() => setShowDeleteDialog(false)}
        onConfirm={handleDelete}
        title="Delete User"
        message={`Are you sure you want to delete "${user.name}"? This action cannot be undone.`}
        confirmText="Delete"
        variant="danger"
      />
    </div>
  );
}
