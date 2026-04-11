import { useAuth } from '@/contexts/AuthContext';

type Permission = 
  | 'view_users'
  | 'edit_users'
  | 'delete_users'
  | 'view_jobs'
  | 'create_jobs'
  | 'edit_jobs'
  | 'delete_jobs'
  | 'view_applications'
  | 'manage_applications'
  | 'view_offers'
  | 'create_offers'
  | 'manage_offers'
  | 'view_notifications'
  | 'manage_notifications'
  | 'view_reports'
  | 'manage_settings';

const rolePermissions: Record<string, Permission[]> = {
  super_admin: [
    'view_users', 'edit_users', 'delete_users',
    'view_jobs', 'create_jobs', 'edit_jobs', 'delete_jobs',
    'view_applications', 'manage_applications',
    'view_offers', 'create_offers', 'manage_offers',
    'view_notifications', 'manage_notifications',
    'view_reports', 'manage_settings',
  ],
  admin: [
    'view_users', 'edit_users',
    'view_jobs', 'create_jobs', 'edit_jobs', 'delete_jobs',
    'view_applications', 'manage_applications',
    'view_offers', 'create_offers', 'manage_offers',
    'view_notifications', 'manage_notifications',
    'view_reports',
  ],
  hr_admin: [
    'view_users',
    'view_jobs',
    'view_applications', 'manage_applications',
    'view_offers', 'create_offers', 'manage_offers',
    'view_notifications', 'manage_notifications',
  ],
  support_admin: [
    'view_users',
    'view_jobs',
    'view_applications',
    'view_offers',
    'view_notifications',
    'view_reports',
  ],
};

export function usePermission() {
  const { user } = useAuth();

  const hasPermission = (permission: Permission): boolean => {
    if (!user?.role) return false;
    const permissions = rolePermissions[user.role] || [];
    return permissions.includes(permission);
  };

  const hasAnyPermission = (permissions: Permission[]): boolean => {
    return permissions.some(permission => hasPermission(permission));
  };

  const hasAllPermissions = (permissions: Permission[]): boolean => {
    return permissions.every(permission => hasPermission(permission));
  };

  return {
    hasPermission,
    hasAnyPermission,
    hasAllPermissions,
  };
}
