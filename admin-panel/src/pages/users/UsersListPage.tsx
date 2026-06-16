import React, { useState, useEffect, useMemo, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { Eye, Edit2, Trash2, Ban, CheckCircle } from 'lucide-react';
import { PageHeader } from '@/components/layout/PageHeader';
import { 
  Card, 
  DataTable, 
  SearchFilterBar, 
  RoleBadge,
  Button,
  ConfirmDialog,
  Avatar,
  Pagination
} from '@/components/common';
import { formatDate } from '@/utils/helpers';
import { useAuth } from '@/contexts/AuthContext';
import { User } from '@/types';
import { userService } from '@/services/userService';

const roleOptions = [
  { value: '', label: 'All Roles' },
  { value: 'user', label: 'User' },
  { value: 'admin', label: 'Admin' },
];

export default function UsersListPage() {
  const navigate = useNavigate();
  const { token } = useAuth();
  
  const [users, setUsers] = useState<User[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [roleFilter, setRoleFilter] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [showBlockDialog, setShowBlockDialog] = useState(false);

  const loadUsers = useCallback(async () => {
    if (!token) return;
    
    try {
      setIsLoading(true);
      const response = await userService.getAll(token, {
        page: currentPage,
        limit: 10,
        search: searchQuery,
        role: roleFilter,
      });
      
      setUsers(response.users);
      setTotalPages(response.pages);
      setTotal(response.total);
    } catch (error) {
      console.error('Failed to load users:', error);
    } finally {
      setIsLoading(false);
    }
  }, [token, currentPage, searchQuery, roleFilter]);

  useEffect(() => {
    loadUsers();
  }, [loadUsers]);

  const filteredUsers = useMemo(() => {
    if (searchQuery === '' && roleFilter === '') return users;
    return users.filter(user => {
      const matchesSearch = 
        user.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        user.email.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesRole = roleFilter === '' || user.role === roleFilter;
      return matchesSearch && matchesRole;
    });
  }, [users, searchQuery, roleFilter]);

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
              setShowBlockDialog(true);
            }}
            className="p-1.5 text-gray-500 hover:text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
            title={(user as User & { isBlocked?: boolean })?.isBlocked ? 'Unblock' : 'Block'}
          >
            {(user as User & { isBlocked?: boolean })?.isBlocked ? <CheckCircle className="w-4 h-4" /> : <Ban className="w-4 h-4" />}
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

  const handleDelete = async () => {
    if (!token || !selectedUser) return;
    
    try {
      await userService.delete(token, selectedUser._id);
      setUsers(users.filter(u => u._id !== selectedUser._id));
      setShowDeleteDialog(false);
      setSelectedUser(null);
    } catch (error) {
      console.error('Failed to delete user:', error);
    }
  };

  const handleToggleBlock = async () => {
    if (!token || !selectedUser) return;
    
    try {
      const response = await userService.toggleBlock(token, selectedUser._id);
      setUsers(users.map(u => 
        u._id === selectedUser._id ? { ...u, isBlocked: response.user.isBlocked } : u
      ));
      setShowBlockDialog(false);
      setSelectedUser(null);
    } catch (error) {
      console.error('Failed to toggle block:', error);
    }
  };

  const handleResetFilters = () => {
    setSearchQuery('');
    setRoleFilter('');
    setCurrentPage(1);
  };

  const handleSearchChange = (value: string) => {
    setSearchQuery(value);
    setCurrentPage(1);
  };

  const handleRoleChange = (value: string) => {
    setRoleFilter(value);
    setCurrentPage(1);
  };

  return (
    <div className="space-y-6 animate-fadeIn">
      <PageHeader
        title="Users"
        subtitle="Manage all registered users and their accounts"
      />

      <Card>
        <SearchFilterBar
          searchValue={searchQuery}
          onSearchChange={handleSearchChange}
          searchPlaceholder="Search by name or email..."
          filters={[
            { key: 'role', label: 'Role', options: roleOptions, value: roleFilter, onChange: handleRoleChange },
          ]}
          onReset={handleResetFilters}
        />
      </Card>

      <Card padding="none">
        <DataTable
          columns={columns}
          data={filteredUsers}
          keyField="_id"
          isLoading={isLoading}
          onRowClick={(user) => navigate(`/users/${user._id}`)}
          emptyMessage="No users found matching your criteria"
        />
        {totalPages > 1 && (
          <div className="border-t">
            <Pagination
              currentPage={currentPage}
              totalPages={totalPages}
              onPageChange={setCurrentPage}
              totalItems={total}
              itemsPerPage={10}
            />
          </div>
        )}
      </Card>

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

      <ConfirmDialog
        isOpen={showBlockDialog}
        onClose={() => {
          setShowBlockDialog(false);
          setSelectedUser(null);
        }}
        onConfirm={handleToggleBlock}
        title={(selectedUser as User & { isBlocked?: boolean })?.isBlocked ? 'Unblock User' : 'Block User'}
        message={`Are you sure you want to ${(selectedUser as User & { isBlocked?: boolean })?.isBlocked ? 'unblock' : 'block'} "${selectedUser?.name}"?`}
        confirmText={(selectedUser as User & { isBlocked?: boolean })?.isBlocked ? 'Unblock' : 'Block'}
        variant={(selectedUser as User & { isBlocked?: boolean })?.isBlocked ? 'primary' : 'warning'}
      />
    </div>
  );
}
