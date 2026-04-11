import React, { useState } from 'react';
import { Plus, Bell, Mail, CheckCircle, Trash2, Eye, Send } from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  Button,
  Modal,
  Input,
  Select,
  Textarea,
  DataTable,
  Badge,
  EmptyState,
  FormActions
} from '@/components/common';
import { formatDate, timeAgo } from '@/utils/helpers';
import { Notification } from '@/types';

// Mock data
const mockNotifications: Notification[] = [
  {
    _id: '1',
    userId: 'u1',
    type: 'offer',
    title: 'Congratulations! Job Offer',
    description: 'Netflix has sent you an offer letter for the UI/UX Designer position',
    actionLabel: 'Review Offer',
    isRead: false,
    createdAt: new Date(Date.now() - 2 * 60 * 60 * 1000).toISOString(),
  },
  {
    _id: '2',
    userId: 'u2',
    type: 'application',
    title: 'Application Sent',
    description: 'Your application for Telegram has been submitted successfully',
    actionLabel: 'View Application',
    isRead: false,
    createdAt: new Date(Date.now() - 5 * 60 * 60 * 1000).toISOString(),
  },
  {
    _id: '3',
    userId: 'u3',
    type: 'system',
    title: 'Profile Updated',
    description: 'Your profile information has been updated successfully',
    actionLabel: '',
    isRead: true,
    createdAt: new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString(),
  },
];

const typeOptions = [
  { value: '', label: 'All Types' },
  { value: 'offer', label: 'Offer' },
  { value: 'application', label: 'Application' },
  { value: 'system', label: 'System' },
];

const userOptions = [
  { value: '', label: 'All Users' },
  { value: 'u1', label: 'Sarah Johnson' },
  { value: 'u2', label: 'Michael Chen' },
  { value: 'u3', label: 'Emma Wilson' },
];

export default function NotificationsPage() {
  const [notifications, setNotifications] = useState(mockNotifications);
  const [isLoading, setIsLoading] = useState(false);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [typeFilter, setTypeFilter] = useState('');
  const [searchQuery, setSearchQuery] = useState('');
  
  const [formData, setFormData] = useState({
    userId: '',
    type: 'system',
    title: '',
    description: '',
    actionLabel: '',
  });

  const filteredNotifications = notifications.filter(n => {
    const matchesType = typeFilter === '' || n.type === typeFilter;
    const matchesSearch = searchQuery === '' || 
      n.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      n.description.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesType && matchesSearch;
  });

  const handleCreate = () => {
    const newNotification: Notification = {
      _id: String(notifications.length + 1),
      userId: formData.userId,
      type: formData.type as 'offer' | 'application' | 'system',
      title: formData.title,
      description: formData.description,
      actionLabel: formData.actionLabel,
      isRead: false,
      createdAt: new Date().toISOString(),
    };
    setNotifications([newNotification, ...notifications]);
    setShowCreateModal(false);
    setFormData({ userId: '', type: 'system', title: '', description: '', actionLabel: '' });
  };

  const handleMarkAsRead = (id: string) => {
    setNotifications(notifications.map(n => 
      n._id === id ? { ...n, isRead: true } : n
    ));
  };

  const handleDelete = (id: string) => {
    setNotifications(notifications.filter(n => n._id !== id));
  };

  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'offer':
        return <Mail className="w-5 h-5 text-green-500" />;
      case 'application':
        return <Bell className="w-5 h-5 text-blue-500" />;
      case 'system':
        return <CheckCircle className="w-5 h-5 text-purple-500" />;
      default:
        return <Bell className="w-5 h-5 text-gray-500" />;
    }
  };

  const getTypeBadge = (type: string) => {
    switch (type) {
      case 'offer':
        return <Badge variant="success">Offer</Badge>;
      case 'application':
        return <Badge variant="info">Application</Badge>;
      case 'system':
        return <Badge variant="purple">System</Badge>;
      default:
        return <Badge variant="default">Unknown</Badge>;
    }
  };

  const columns = [
    {
      key: 'type',
      label: 'Type',
      render: (n: Notification) => (
        <div className="flex items-center gap-3">
          <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${
            n.type === 'offer' ? 'bg-green-50' : 
            n.type === 'application' ? 'bg-blue-50' : 'bg-purple-50'
          }`}>
            {getTypeIcon(n.type)}
          </div>
        </div>
      ),
    },
    {
      key: 'title',
      label: 'Notification',
      render: (n: Notification) => (
        <div className={n.isRead ? 'opacity-60' : ''}>
          <p className={`font-medium ${n.isRead ? 'text-gray-600' : 'text-gray-900'}`}>
            {n.title}
          </p>
          <p className="text-sm text-gray-500 mt-0.5">{n.description}</p>
        </div>
      ),
    },
    {
      key: 'status',
      label: 'Status',
      render: (n: Notification) => (
        n.isRead ? (
          <Badge variant="gray">Read</Badge>
        ) : (
          <Badge variant="info" dot>New</Badge>
        )
      ),
    },
    {
      key: 'createdAt',
      label: 'Sent',
      render: (n: Notification) => (
        <span className="text-gray-500 text-sm">{timeAgo(n.createdAt)}</span>
      ),
    },
    {
      key: 'actions',
      label: 'Actions',
      render: (n: Notification) => (
        <div className="flex items-center gap-1">
          {!n.isRead && (
            <button
              onClick={(e) => { e.stopPropagation(); handleMarkAsRead(n._id); }}
              className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
              title="Mark as Read"
            >
              <Eye className="w-4 h-4" />
            </button>
          )}
          <button
            onClick={(e) => { e.stopPropagation(); handleDelete(n._id); }}
            className="p-1.5 text-gray-500 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
            title="Delete"
          >
            <Trash2 className="w-4 h-4" />
          </button>
        </div>
      ),
    },
  ];

  return (
    <div className="space-y-6 animate-fadeIn">
      <PageHeader
        title="Notifications"
        subtitle="Manage and send notifications to users"
        showAddButton
        onAddClick={() => setShowCreateModal(true)}
        addButtonText="Send Notification"
      />

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card className="text-center">
          <p className="text-2xl font-bold text-gray-900">{notifications.length}</p>
          <p className="text-sm text-gray-500">Total</p>
        </Card>
        <Card className="text-center">
          <p className="text-2xl font-bold text-blue-600">{notifications.filter(n => n.type === 'application').length}</p>
          <p className="text-sm text-gray-500">Application</p>
        </Card>
        <Card className="text-center">
          <p className="text-2xl font-bold text-green-600">{notifications.filter(n => n.type === 'offer').length}</p>
          <p className="text-sm text-gray-500">Offer</p>
        </Card>
        <Card className="text-center">
          <p className="text-2xl font-bold text-purple-600">{notifications.filter(n => n.type === 'system').length}</p>
          <p className="text-sm text-gray-500">System</p>
        </Card>
      </div>

      {/* Filters */}
      <Card>
        <div className="flex flex-col md:flex-row gap-4">
          <div className="flex-1">
            <Input
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search notifications..."
            />
          </div>
          <Select
            value={typeFilter}
            onChange={(e) => setTypeFilter(e.target.value)}
            options={typeOptions}
            fullWidth={false}
            className="w-48"
          />
        </div>
      </Card>

      {/* Notifications List */}
      <Card padding="none">
        <DataTable
          columns={columns}
          data={filteredNotifications}
          keyField="_id"
          isLoading={isLoading}
          emptyMessage="No notifications found"
        />
      </Card>

      {/* Create Modal */}
      <Modal
        isOpen={showCreateModal}
        onClose={() => setShowCreateModal(false)}
        title="Send Notification"
        size="lg"
        footer={
          <div className="flex justify-end gap-3">
            <Button variant="outline" onClick={() => setShowCreateModal(false)}>Cancel</Button>
            <Button onClick={handleCreate} leftIcon={<Send className="w-4 h-4" />}>
              Send Notification
            </Button>
          </div>
        }
      >
        <div className="space-y-4">
          <Select
            label="User"
            value={formData.userId}
            onChange={(e) => setFormData({ ...formData, userId: e.target.value })}
            options={userOptions}
            placeholder="Select a user"
          />
          <Select
            label="Notification Type"
            value={formData.type}
            onChange={(e) => setFormData({ ...formData, type: e.target.value })}
            options={typeOptions.filter(o => o.value !== '')}
          />
          <Input
            label="Title"
            value={formData.title}
            onChange={(e) => setFormData({ ...formData, title: e.target.value })}
            placeholder="Notification title"
          />
          <Textarea
            label="Description"
            value={formData.description}
            onChange={(e) => setFormData({ ...formData, description: e.target.value })}
            placeholder="Notification message..."
            rows={4}
          />
          <Input
            label="Action Label (Optional)"
            value={formData.actionLabel}
            onChange={(e) => setFormData({ ...formData, actionLabel: e.target.value })}
            placeholder="e.g., View Details"
          />
        </div>
      </Modal>
    </div>
  );
}
