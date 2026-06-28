export const APP_NAME = 'WorkScout';
export const APP_VERSION = '1.0.0';

// Sidebar Navigation Items
export interface NavItem {
  label: string;
  path: string;
  icon: string;
  badge?: number;
}

export const navItems: NavItem[] = [
  { label: 'Dashboard', path: '/', icon: 'LayoutDashboard' },
  { label: 'Users', path: '/users', icon: 'Users' },
  { label: 'Jobs', path: '/jobs', icon: 'Briefcase' },
  { label: 'Applications', path: '/applications', icon: 'FileText' },
  { label: 'Notifications', path: '/notifications', icon: 'Bell' },
  { label: 'Offer Letters', path: '/offers', icon: 'Mail' },
  { label: 'Settings', path: '/settings', icon: 'Settings' },
];

// Job Categories
export const JOB_CATEGORIES = [
  'Design',
  'Technology',
  'Marketing',
  // 'Finance',
  'Business',
  // 'Human Resources',
  // 'Engineering',
  // 'Sales',
  // 'Customer Service',
  // 'Operations',
];

// Job Types
export const JOB_TYPES = [
  'Remote',
  'Fulltime',
  'Parttime',
  'Contract',
  'Freelance',
];

// Experience Levels
export const EXPERIENCE_LEVELS = [
  'Entry level',
  'Junior',
  'Mid',
  'Senior',
  'Lead',
  'Manager',
];

// Application Statuses (must match backend schema)
export const APPLICATION_STATUSES = [
  'pending',
  'reviewed',
  'interview',
  'offered',
  'accepted',
  'rejected',
] as const;

// User Roles
export const USER_ROLES = [
  { value: 'user', label: 'User' },
  { value: 'admin', label: 'Admin' },
  { value: 'super_admin', label: 'Super Admin' },
  { value: 'hr_admin', label: 'HR Admin' },
  { value: 'support_admin', label: 'Support Admin' },
];

// Pagination Defaults
export const PAGINATION = {
  DEFAULT_PAGE: 1,
  DEFAULT_LIMIT: 10,
  PAGE_SIZE_OPTIONS: [10, 25, 50, 100],
};

// Table Column Configurations
export const USERS_TABLE_COLUMNS = [
  { key: 'name', label: 'Name', sortable: true },
  { key: 'email', label: 'Email', sortable: true },
  { key: 'role', label: 'Role', sortable: true },
  { key: 'location', label: 'Location', sortable: false },
  { key: 'createdAt', label: 'Joined', sortable: true },
  { key: 'isActive', label: 'Status', sortable: true },
  { key: 'actions', label: 'Actions', sortable: false },
];

export const JOBS_TABLE_COLUMNS = [
  { key: 'jobTitle', label: 'Title', sortable: true },
  { key: 'companyName', label: 'Company', sortable: true },
  { key: 'location', label: 'Location', sortable: true },
  { key: 'category', label: 'Category', sortable: true },
  { key: 'jobType', label: 'Type', sortable: true },
  { key: 'postedDate', label: 'Posted', sortable: true },
  { key: 'isActive', label: 'Status', sortable: true },
  { key: 'actions', label: 'Actions', sortable: false },
];

export const APPLICATIONS_TABLE_COLUMNS = [
  { key: 'user', label: 'Applicant', sortable: true },
  { key: 'job', label: 'Job', sortable: true },
  { key: 'appliedDate', label: 'Applied', sortable: true },
  { key: 'status', label: 'Status', sortable: true },
  { key: 'actions', label: 'Actions', sortable: false },
];
