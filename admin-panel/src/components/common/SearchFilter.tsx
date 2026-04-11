import React from 'react';
import { clsx } from 'clsx';
import { Search, Filter, X } from 'lucide-react';
import { Button } from './Button';
import { Input } from './Input';
import { Select } from './Select';

interface SearchFilterBarProps {
  searchValue: string;
  onSearchChange: (value: string) => void;
  searchPlaceholder?: string;
  filters?: {
    key: string;
    label: string;
    options: { value: string; label: string }[];
    value: string;
    onChange: (value: string) => void;
  }[];
  onReset?: () => void;
  className?: string;
}

export function SearchFilterBar({
  searchValue,
  onSearchChange,
  searchPlaceholder = 'Search...',
  filters = [],
  onReset,
  className,
}: SearchFilterBarProps) {
  const hasActiveFilters = filters.some(f => f.value);
  const hasSearch = searchValue.trim() !== '';

  return (
    <div className={clsx('flex flex-col gap-4 md:flex-row md:items-end', className)}>
      {/* Search Input */}
      <div className="flex-1">
        <Input
          value={searchValue}
          onChange={(e) => onSearchChange(e.target.value)}
          placeholder={searchPlaceholder}
          leftIcon={<Search className="w-4 h-4" />}
          rightIcon={
            hasSearch ? (
              <button 
                onClick={() => onSearchChange('')}
                className="hover:text-gray-600"
              >
                <X className="w-4 h-4" />
              </button>
            ) : undefined
          }
        />
      </div>

      {/* Filters */}
      {filters.length > 0 && (
        <div className="flex items-center gap-3 flex-wrap">
          <div className="flex items-center gap-2 text-sm text-gray-500">
            <Filter className="w-4 h-4" />
            <span>Filters:</span>
          </div>
          {filters.map((filter) => (
            <Select
              key={filter.key}
              value={filter.value}
              onChange={(e) => filter.onChange(e.target.value)}
              options={filter.options}
              placeholder={filter.label}
              fullWidth={false}
              className="w-40"
            />
          ))}
        </div>
      )}

      {/* Reset Button */}
      {(hasSearch || hasActiveFilters) && onReset && (
        <Button 
          variant="ghost" 
          size="sm"
          onClick={onReset}
          leftIcon={<X className="w-4 h-4" />}
        >
          Reset
        </Button>
      )}
    </div>
  );
}

// Empty State Component
interface EmptyStateProps {
  icon: React.ReactNode;
  title: string;
  description?: string;
  action?: {
    label: string;
    onClick: () => void;
  };
  className?: string;
}

export function EmptyState({
  icon,
  title,
  description,
  action,
  className,
}: EmptyStateProps) {
  return (
    <div className={clsx('flex flex-col items-center justify-center py-12 px-4', className)}>
      <div className="w-16 h-16 rounded-full bg-gray-100 flex items-center justify-center text-gray-400 mb-4">
        {icon}
      </div>
      <h3 className="text-lg font-medium text-gray-900 mb-1">{title}</h3>
      {description && (
        <p className="text-sm text-gray-500 text-center max-w-sm mb-4">{description}</p>
      )}
      {action && (
        <Button onClick={action.onClick} size="sm">
          {action.label}
        </Button>
      )}
    </div>
  );
}

// Loading Spinner
interface LoadingSpinnerProps {
  size?: 'sm' | 'md' | 'lg';
  className?: string;
}

export function LoadingSpinner({ size = 'md', className }: LoadingSpinnerProps) {
  const sizeStyles = {
    sm: 'w-4 h-4',
    md: 'w-8 h-8',
    lg: 'w-12 h-12',
  };

  return (
    <div className={clsx('flex items-center justify-center', className)}>
      <div className={clsx(
        'border-2 border-primary-200 border-t-primary-600 rounded-full animate-spin',
        sizeStyles[size]
      )} />
    </div>
  );
}

// Full Page Loading
interface FullPageLoadingProps {
  message?: string;
}

export function FullPageLoading({ message = 'Loading...' }: FullPageLoadingProps) {
  return (
    <div className="flex flex-col items-center justify-center h-64 gap-4">
      <LoadingSpinner size="lg" />
      <p className="text-gray-500">{message}</p>
    </div>
  );
}
