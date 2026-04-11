import React from 'react';
import { clsx } from 'clsx';
import { Plus } from 'lucide-react';
import { Button } from '@/components/common';

interface PageHeaderProps {
  title: string;
  subtitle?: string;
  actions?: React.ReactNode;
  showAddButton?: boolean;
  onAddClick?: () => void;
  addButtonText?: string;
  breadcrumbs?: { label: string; path?: string }[];
  className?: string;
}

export function PageHeader({
  title,
  subtitle,
  actions,
  showAddButton,
  onAddClick,
  addButtonText = 'Add New',
  breadcrumbs,
  className,
}: PageHeaderProps) {
  return (
    <div className={clsx('mb-6', className)}>
      {/* Breadcrumbs */}
      {breadcrumbs && breadcrumbs.length > 0 && (
        <div className="flex items-center gap-2 text-sm mb-3">
          {breadcrumbs.map((crumb, index) => (
            <React.Fragment key={index}>
              {index > 0 && <span className="text-gray-400">/</span>}
              {crumb.path ? (
                <a href={crumb.path} className="text-gray-500 hover:text-gray-700">
                  {crumb.label}
                </a>
              ) : (
                <span className="text-gray-900 font-medium">{crumb.label}</span>
              )}
            </React.Fragment>
          ))}
        </div>
      )}

      {/* Title Row */}
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">{title}</h1>
          {subtitle && (
            <p className="text-gray-500 mt-1">{subtitle}</p>
          )}
        </div>

        {/* Actions */}
        <div className="flex items-center gap-3">
          {actions}
          {showAddButton && (
            <Button 
              onClick={onAddClick}
              leftIcon={<Plus className="w-4 h-4" />}
            >
              {addButtonText}
            </Button>
          )}
        </div>
      </div>
    </div>
  );
}

// Section Header Component
interface SectionHeaderProps {
  title: string;
  description?: string;
  action?: React.ReactNode;
  className?: string;
}

export function SectionHeader({
  title,
  description,
  action,
  className,
}: SectionHeaderProps) {
  return (
    <div className={clsx('flex items-center justify-between mb-4', className)}>
      <div>
        <h3 className="text-lg font-semibold text-gray-900">{title}</h3>
        {description && (
          <p className="text-sm text-gray-500 mt-0.5">{description}</p>
        )}
      </div>
      {action && <div>{action}</div>}
    </div>
  );
}
