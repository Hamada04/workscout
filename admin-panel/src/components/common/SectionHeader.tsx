import React from 'react';
import { clsx } from 'clsx';

interface SectionHeaderProps {
  title: string;
  subtitle?: string;
  description?: string;
  action?: React.ReactNode;
  className?: string;
}

export function SectionHeader({ title, subtitle, description, action, className }: SectionHeaderProps) {
  return (
    <div className={clsx('flex items-center justify-between mb-4', className)}>
      <div>
        <h3 className="text-lg font-semibold text-gray-900">{title}</h3>
        {(subtitle || description) && <p className="text-sm text-gray-500 mt-0.5">{subtitle || description}</p>}
      </div>
      {action && <div>{action}</div>}
    </div>
  );
}
