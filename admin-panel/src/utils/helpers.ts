import { ApplicationStatus } from '@/types';

// Date Formatting
export function formatDate(date: string | Date, format: 'short' | 'long' | 'time' = 'short'): string {
  const d = new Date(date);
  
  if (format === 'short') {
    return d.toLocaleDateString('en-US', { 
      month: 'short', 
      day: 'numeric', 
      year: 'numeric' 
    });
  }
  
  if (format === 'long') {
    return d.toLocaleDateString('en-US', { 
      weekday: 'long',
      month: 'long', 
      day: 'numeric', 
      year: 'numeric' 
    });
  }
  
  return d.toLocaleDateString('en-US', { 
    month: 'short', 
    day: 'numeric', 
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  });
}

// Relative Time
export function timeAgo(date: string | Date): string {
  const d = new Date(date);
  const now = new Date();
  const diff = now.getTime() - d.getTime();
  
  const seconds = Math.floor(diff / 1000);
  const minutes = Math.floor(seconds / 60);
  const hours = Math.floor(minutes / 60);
  const days = Math.floor(hours / 24);
  const weeks = Math.floor(days / 7);
  const months = Math.floor(days / 30);
  
  if (months > 0) return `${months}mo ago`;
  if (weeks > 0) return `${weeks}w ago`;
  if (days > 0) return `${days}d ago`;
  if (hours > 0) return `${hours}h ago`;
  if (minutes > 0) return `${minutes}m ago`;
  return 'Just now';
}

// String Utilities
export function capitalize(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
}

export function truncate(str: string, length: number): string {
  if (str.length <= length) return str;
  return str.slice(0, length) + '...';
}

export function slugify(str: string): string {
  return str
    .toLowerCase()
    .replace(/[^\w\s-]/g, '')
    .replace(/[\s_-]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

// Status Color Mapping
export function getStatusColor(status: ApplicationStatus): {
  bg: string;
  text: string;
  dot: string;
} {
  const colors: Record<string, { bg: string; text: string; dot: string }> = {
    'pending': { bg: 'bg-blue-100', text: 'text-blue-700', dot: 'bg-blue-500' },
    'reviewed': { bg: 'bg-yellow-100', text: 'text-yellow-700', dot: 'bg-yellow-500' },
    'interview': { bg: 'bg-purple-100', text: 'text-purple-700', dot: 'bg-purple-500' },
    'offered': { bg: 'bg-teal-100', text: 'text-teal-700', dot: 'bg-teal-500' },
    'accepted': { bg: 'bg-green-100', text: 'text-green-700', dot: 'bg-green-500' },
    'rejected': { bg: 'bg-red-100', text: 'text-red-700', dot: 'bg-red-500' },
  };
  
  return colors[status] || colors['pending'];
}

// Boolean to Status
export function booleanToStatus(isActive: boolean): { label: string; color: string } {
  return isActive 
    ? { label: 'Active', color: 'text-green-600 bg-green-50' }
    : { label: 'Inactive', color: 'text-gray-600 bg-gray-50' };
}

// Role to Color
export function roleToColor(role: string): string {
  const colors: Record<string, string> = {
    'super_admin': 'bg-red-100 text-red-700',
    'admin': 'bg-purple-100 text-purple-700',
    'hr_admin': 'bg-blue-100 text-blue-700',
    'support_admin': 'bg-gray-100 text-gray-700',
    'user': 'bg-gray-100 text-gray-700',
  };
  
  return colors[role] || colors['user'];
}

// Format Role Label
export function formatRole(role: string): string {
  const labels: Record<string, string> = {
    'super_admin': 'Super Admin',
    'admin': 'Admin',
    'hr_admin': 'HR Admin',
    'support_admin': 'Support Admin',
    'user': 'User',
  };
  
  return labels[role] || role;
}

// Generate Initials
export function getInitials(name: string): string {
  if (!name) return '?';
  return name
    .split(' ')
    .map(part => part[0])
    .join('')
    .toUpperCase()
    .slice(0, 2);
}

// Array Utilities
export function groupBy<T>(array: T[], key: keyof T): Record<string, T[]> {
  return array.reduce((groups, item) => {
    const group = String(item[key]);
    groups[group] = groups[group] || [];
    groups[group].push(item);
    return groups;
  }, {} as Record<string, T[]>);
}

// Debounce
export function debounce<T extends (...args: Parameters<T>) => ReturnType<T>>(
  func: T,
  wait: number
): (...args: Parameters<T>) => void {
  let timeout: ReturnType<typeof setTimeout>;
  
  return (...args: Parameters<T>) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => func(...args), wait);
  };
}

// Copy to Clipboard
export async function copyToClipboard(text: string): Promise<boolean> {
  try {
    await navigator.clipboard.writeText(text);
    return true;
  } catch {
    return false;
  }
}

// Validate Email
export function isValidEmail(email: string): boolean {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

// Format Phone Number
export function formatPhone(phone: string): string {
  const cleaned = phone.replace(/\D/g, '');
  const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
  if (match) {
    return `(${match[1]}) ${match[2]}-${match[3]}`;
  }
  return phone;
}

// Currency Formatting
export function formatCurrency(amount: string | number): string {
  const num = typeof amount === 'string' ? parseFloat(amount) : amount;
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  }).format(num);
}

// Search/Filter Helpers
export function filterBySearch<T>(items: T[], search: string, keys: (keyof T)[]): T[] {
  if (!search.trim()) return items;
  
  const lowerSearch = search.toLowerCase();
  return items.filter(item => 
    keys.some(key => {
      const value = item[key];
      return typeof value === 'string' && value.toLowerCase().includes(lowerSearch);
    })
  );
}
