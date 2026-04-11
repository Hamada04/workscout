import React from 'react';
import { clsx } from 'clsx';
import { ApplicationStatus } from '@/types';
import { getStatusColor, formatRole } from '@/utils/helpers';

type BadgeVariant = 'default' | 'success' | 'warning' | 'danger' | 'info' | 'purple' | 'gray';

interface BadgeProps {
  children: React.ReactNode;
  variant?: BadgeVariant;
  size?: 'sm' | 'md';
  dot?: boolean;
  className?: string;
}

const variantStyles: Record<BadgeVariant, string> = {
  default: 'bg-gray-100 text-gray-700',
  success: 'bg-green-100 text-green-700',
  warning: 'bg-yellow-100 text-yellow-700',
  danger: 'bg-red-100 text-red-700',
  info: 'bg-blue-100 text-blue-700',
  purple: 'bg-purple-100 text-purple-700',
  gray: 'bg-gray-100 text-gray-600',
};

export function Badge({ 
  children, 
  variant = 'default', 
  size = 'md',
  dot = false,
  className 
}: BadgeProps) {
  return (
    <span
      className={clsx(
        'inline-flex items-center gap-1.5 font-medium rounded-full',
        variantStyles[variant],
        size === 'sm' ? 'px-2 py-0.5 text-xs' : 'px-2.5 py-1 text-xs',
        className
      )}
    >
      {dot && (
        <span className={clsx('w-1.5 h-1.5 rounded-full', variantStyles[variant].split(' ')[0].replace('bg-', 'bg-').replace('-100', '-500'))} />
      )}
      {children}
    </span>
  );
}

// Status-specific badge component
interface StatusBadgeProps {
  status: ApplicationStatus | string;
  className?: string;
}

export function StatusBadge({ status, className }: StatusBadgeProps) {
  const colors = getStatusColor(status as ApplicationStatus);
  
  return (
    <span
      className={clsx(
        'inline-flex items-center gap-1.5 px-2.5 py-1 text-xs font-medium rounded-full',
        colors.bg,
        colors.text,
        className
      )}
    >
      <span className={clsx('w-1.5 h-1.5 rounded-full', colors.dot)} />
      {status}
    </span>
  );
}

// Role badge component
interface RoleBadgeProps {
  role: string;
  className?: string;
}

export function RoleBadge({ role, className }: RoleBadgeProps) {
  const roleColors: Record<string, BadgeVariant> = {
    'super_admin': 'danger',
    'admin': 'purple',
    'hr_admin': 'info',
    'support_admin': 'gray',
    'user': 'default',
  };

  return (
    <Badge variant={roleColors[role] || 'default'} className={className}>
      {formatRole(role)}
    </Badge>
  );
}

// Active/Inactive badge
interface ActiveBadgeProps {
  isActive: boolean;
  className?: string;
}

export function ActiveBadge({ isActive, className }: ActiveBadgeProps) {
  return (
    <Badge variant={isActive ? 'success' : 'gray'} dot className={className}>
      {isActive ? 'Active' : 'Inactive'}
    </Badge>
  );
}
