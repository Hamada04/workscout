import React, { useState, useEffect } from 'react';
import { Plus, Bell, Mail, CheckCircle, Trash2, Eye, Send } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';
import { notificationService } from '@/services/notificationService';
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
import { timeAgo } from '@/utils/helpers';
import { Notification } from '@/types';

const typeOptions = [
  { value: '', label: 'All Types' },
  { value: 'offer', label: 'Offer' },
  { value: 'application', label: 'Application' },
  { value: 'system', label: 'System' },
];

export default function NotificationsPage() {
  const { token } = useAuth();
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [typeFilter, setTypeFilter] = useState('');
  const [searchQuery, setSearchQuery] = useState('');
  
  const [formData, setFormData] = useState({
    userId: '',
    type: 'system',
    title: '',
    message: '',
  });

  useEffect(() => {
    if (!token) return;
    setIsLoading(true);
    notificationService.getAll(token)
      .then((res) => {
        const items = (res as unknown as Record<string, unknown>)['notifications'] as Notification[] ?? [];
        setNotifications(items);
      })
      .catch(() => {})
      .finally(() => setIsLoading(false));
  }, [token]);

  const filteredNotifications = notifications.filter(n => {
    const matchesType = typeFilter === '' || n.type === typeFilter;
    const matchesSearch = searchQuery === '' || 
      n.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      (n.message ?? n.description ?? '').toLowerCase().includes(searchQuery.toLowerCase());
    return matchesType && matchesSearch;
  });

  const handleCreate = async () => {
    if (!token) return;
    try {
      if (formData.userId) {
        await notificationService.send(token, {
          userId: formData.userId,
          title: formData.title,
          message: formData.message || formData.title,
          type: formData.type,
        });
      } else {
        await notificationService.sendAll(token, {
          title: formData.title,
          message: formData.message || formData.title,
          type: formData.type,
        });
      }
      const res = await notificationService.getAll(token);
      const items = (res as unknown as Record<string, unknown>)['notifications'] as Notification[] ?? [];
      setNotifications(items);
      setShowCreateModal(false);
      setFormData({ userId: '', type: 'system', title: '', message: '' });
    } catch {
      // Handled by interceptor
    }
  };

  const handleMarkAsRead = async (id: string) => {
    if (!token) return;
    try {
      await notificationService.markAsRead(token, id);
      setNotifications(notifications.map(n => 
        n._id === id ? { ...n, isRead: true } : n
      ));
    } catch {
      // Handled by interceptor
    }
  };

  const handleDelete = async (id: string) => {
    if (!token) return;
    try {
      await notificationService.delete(token, id);
      setNotifications(notifications.filter(n => n._id !== id));
    } catch {
      // Handled by interceptor
    }
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
          <p className="text-sm text-gray-500 mt-0.5">{n.message ?? n.description}</p>
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
        <span className="text-gray-500 text-sm">{timeAgo(n.createdAt ?? '')}</span>
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

      <Card padding="none">
        <DataTable
          columns={columns}
          data={filteredNotifications}
          keyField="_id"
          isLoading={isLoading}
          emptyMessage="No notifications found"
        />
      </Card>

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
          <Input
            label="User ID (leave empty to send to all)"
            value={formData.userId}
            onChange={(e) => setFormData({ ...formData, userId: e.target.value })}
            placeholder="User ID or empty for all users"
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
            label="Message"
            value={formData.message}
            onChange={(e) => setFormData({ ...formData, message: e.target.value })}
            placeholder="Notification message..."
            rows={4}
          />
        </div>
      </Modal>
    </div>
  );
}
