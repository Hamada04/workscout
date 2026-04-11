import React, { useState, useEffect, useMemo } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Plus, Eye, Edit2, Trash2, MoreHorizontal, Ban, CheckCircle } from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  DataTable, 
  SearchFilterBar, 
  Badge,
  RoleBadge,
  ActiveBadge,
  Button,
  Modal,
  ConfirmDialog,
  Select,
  Avatar,
  EmptyState
} from '@/components/common';
import { formatDate, roleToColor, formatRole } from '@/utils/helpers';
import { useAuth } from '@/contexts/AuthContext';
import { User } from '@/types';

// Mock data
const mockUsers: User[] = [
  {
    _id: '1',
    name: 'Sarah Johnson',
    email: 'sarah.j@example.com',
    role: 'user',
    location: 'California, USA',
    profilePic: '',
    skills: ['UI Design', 'Figma', 'User Research'],
    languages: ['English', 'Spanish'],
    education: [],
    experiences: [],
    savedJobsIds: ['1', '2'],
    createdAt: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString(),
    updatedAt: new Date().toISOString(),
    isActive: true,
  },
  {
    _id: '2',
    name: 'Michael Chen',
    email: 'michael.c@example.com',
    role: 'admin',
    location: 'New York, USA',
    profilePic: '',
    skills: ['React', 'TypeScript', 'Node.js'],
    languages: ['English', 'Mandarin'],
    education: [],
    experiences: [],
    savedJobsIds: [],
    createdAt: new Date(Date.now() - 60 * 24 * 60 * 60 * 1000).toISOString(),
    updatedAt: new Date().toISOString(),
    isActive: true,
  },
  {
    _id: '3',
    name: 'Emma Wilson',
    email: 'emma.w@example.com',
    role: 'user',
    location: 'London, UK',
    profilePic: '',
    skills: ['Marketing', 'SEO', 'Content Strategy'],
    languages: ['English'],
    education: [],
    experiences: [],
    savedJobsIds: ['1'],
    createdAt: new Date(Date.now() - 15 * 24 * 60 * 60 * 1000).toISOString(),
    updatedAt: new Date().toISOString(),
    isActive: false,
  },
];

const roleOptions = [
  { value: '', label: 'All Roles' },
  { value: 'user', label: 'User' },
  { value: 'admin', label: 'Admin' },
  { value: 'super_admin', label: 'Super Admin' },
  { value: 'hr_admin', label: 'HR Admin' },
  { value: 'support_admin', label: 'Support Admin' },
];

const statusOptions = [
  { value: '', label: 'All Status' },
  { value: 'active', label: 'Active' },
  { value: 'inactive', label: 'Inactive' },
];

export default function UsersListPage() {
  const navigate = useNavigate();
  const { token } = useAuth();
  
  const [users, setUsers] = useState<User[]>(mockUsers);
  const [isLoading, setIsLoading] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [roleFilter, setRoleFilter] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [showStatusDialog, setShowStatusDialog] = useState(false);

  // Filter users
  const filteredUsers = useMemo(() => {
    return users.filter(user => {
      const matchesSearch = searchQuery === '' || 
        user.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        user.email.toLowerCase().includes(searchQuery.toLowerCase());
      
      const matchesRole = roleFilter === '' || user.role === roleFilter;
      const matchesStatus = statusFilter === '' || 
        (statusFilter === 'active' && user.isActive) ||
        (statusFilter === 'inactive' && !user.isActive);
      
      return matchesSearch && matchesRole && matchesStatus;
    });
  }, [users, searchQuery, roleFilter, statusFilter]);

  const columns = [
    {
      key: 'name',
      label: 'User',
      sortable: true,
      render: (user: User) => (
        <div className="flex items-center gap-3">
          <Avatar src={user.profilePic} name={user.name} size="md" />
          <div>
            <p className="font-medium text-gray-900">{user.name}</p>
            <p className="text-sm text-gray-500">{user.email}</p>
          </div>
        </div>
      ),
    },
    {
      key: 'role',
      label: 'Role',
      sortable: true,
      render: (user: User) => <RoleBadge role={user.role} />,
    },
    {
      key: 'location',
      label: 'Location',
      render: (user: User) => (
        <span className="text-gray-600">{user.location || 'Not set'}</span>
      ),
    },
    {
      key: 'createdAt',
      label: 'Joined',
      sortable: true,
      render: (user: User) => (
        <span className="text-gray-500 text-sm">{formatDate(user.createdAt)}</span>
      ),
    },
    {
      key: 'isActive',
      label: 'Status',
      sortable: true,
      render: (user: User) => <ActiveBadge isActive={user.isActive} />,
    },
    {
      key: 'actions',
      label: 'Actions',
      render: (user: User) => (
        <div className="flex items-center gap-2">
          <button
            onClick={(e) => {
              e.stopPropagation();
              navigate(`/users/${user._id}`);
            }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="View Details"
          >
            <Eye className="w-4 h-4" />
          </button>
          <button
            onClick={(e) => {
              e.stopPropagation();
              navigate(`/users/${user._id}?edit=true`);
            }}
            className="p-1.5 text-gray-500 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
            title="Edit User"
          >
            <Edit2 className="w-4 h-4" />
          </button>
          <button
            onClick={(e) => {
              e.stopPropagation();
              setSelectedUser(user);
              setShowStatusDialog(true);
            }}
            className="p-1.5 text-gray-500 hover:text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
            title={user.isActive ? 'Deactivate' : 'Activate'}
          >
            {user.isActive ? <Ban className="w-4 h-4" /> : <CheckCircle className="w-4 h-4" />}
          </button>
          <button
            onClick={(e) => {
              e.stopPropagation();
              setSelectedUser(user);
              setShowDeleteDialog(true);
            }}
            className="p-1.5 text-gray-500 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
            title="Delete User"
          >
            <Trash2 className="w-4 h-4" />
          </button>
        </div>
      ),
    },
  ];

  const handleDelete = () => {
    if (selectedUser) {
      setUsers(users.filter(u => u._id !== selectedUser._id));
      setShowDeleteDialog(false);
      setSelectedUser(null);
    }
  };

  const handleToggleStatus = () => {
    if (selectedUser) {
      setUsers(users.map(u => 
        u._id === selectedUser._id ? { ...u, isActive: !u.isActive } : u
      ));
      setShowStatusDialog(false);
      setSelectedUser(null);
    }
  };

  const handleResetFilters = () => {
    setSearchQuery('');
    setRoleFilter('');
    setStatusFilter('');
  };

  return (
    <div className="space-y-6 animate-fadeIn">
      <PageHeader
        title="Users"
        subtitle="Manage all registered users and their accounts"
        showAddButton
        onAddClick={() => navigate('/users/new')}
        addButtonText="Add User"
      />

      {/* Filters */}
      <Card>
        <SearchFilterBar
          searchValue={searchQuery}
          onSearchChange={setSearchQuery}
          searchPlaceholder="Search by name or email..."
          filters={[
            { key: 'role', label: 'Role', options: roleOptions, value: roleFilter, onChange: setRoleFilter },
            { key: 'status', label: 'Status', options: statusOptions, value: statusFilter, onChange: setStatusFilter },
          ]}
          onReset={handleResetFilters}
        />
      </Card>

      {/* Users Table */}
      <Card padding="none">
        <DataTable
          columns={columns}
          data={filteredUsers}
          keyField="_id"
          isLoading={isLoading}
          onRowClick={(user) => navigate(`/users/${user._id}`)}
          emptyMessage="No users found matching your criteria"
        />
      </Card>

      {/* Delete Confirmation */}
      <ConfirmDialog
        isOpen={showDeleteDialog}
        onClose={() => {
          setShowDeleteDialog(false);
          setSelectedUser(null);
        }}
        onConfirm={handleDelete}
        title="Delete User"
        message={`Are you sure you want to delete "${selectedUser?.name}"? This action cannot be undone.`}
        confirmText="Delete"
        variant="danger"
      />

      {/* Status Toggle Confirmation */}
      <ConfirmDialog
        isOpen={showStatusDialog}
        onClose={() => {
          setShowStatusDialog(false);
          setSelectedUser(null);
        }}
        onConfirm={handleToggleStatus}
        title={selectedUser?.isActive ? 'Deactivate User' : 'Activate User'}
        message={`Are you sure you want to ${selectedUser?.isActive ? 'deactivate' : 'activate'} "${selectedUser?.name}"?`}
        confirmText={selectedUser?.isActive ? 'Deactivate' : 'Activate'}
        variant={selectedUser?.isActive ? 'warning' : 'primary'}
      />
    </div>
  );
}
