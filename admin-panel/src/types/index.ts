// User Types
export interface User {
  _id: string;
  name: string;
  email: string;
  role: 'user' | 'admin';
  location?: string;
  profilePic?: string;
  skills?: string[];
  languages?: string[];
  education?: Education[];
  experiences?: Experience[];
  isActive?: boolean;
  isBlocked?: boolean;
  savedJobsIds?: string[];
  createdAt?: string;
  updatedAt?: string;
}

export interface Education {
  degree: string;
  university: string;
  level?: string;
  date: string;
}

export interface Experience {
  title: string;
  company: string;
  date: string;
  logo?: string;
}

// Job Types
export interface Job {
  _id: string;
  companyName: string;
  jobTitle: string;
  location: string;
  jobType: string;
  contractType: string;
  experienceLevel: string;
  postedDate: string;
  salary: string;
  companyLogo?: string;
  category: string;
  description: string;
  officeAddress: string;
  skills: string[];
  responsibilities: string[];
  requirements: string[];
  benefits: string[];
  isActive?: boolean;
  createdAt?: string;
  updatedAt?: string;
}

// Application Types
export interface Application {
  _id: string;
  userId: string | User | Record<string, unknown>;
  jobId: string | Job | Record<string, unknown>;
  status: ApplicationStatus;
  cvUrl?: string;
  resumeUrl?: string;
  coverLetter?: string;
  adminMessage?: string;
  notes?: string;
  appliedAt?: string;
  appliedDate?: string;
  createdAt?: string;
  updatedAt?: string;
}

export type ApplicationStatus = 'pending' | 'reviewed' | 'interview' | 'accepted' | 'rejected' | 'Submitted' | 'Under Review' | 'Interview' | 'Accepted' | 'Rejected';

// Notification Types
export interface Notification {
  _id: string;
  userId: string | User;
  title: string;
  message?: string;
  description?: string;
  actionLabel?: string;
  type: 'application' | 'offer' | 'system' | 'job_update';
  isRead: boolean;
  relatedId?: string;
  createdAt?: string;
}

// Offer Letter Types
export interface OfferLetter {
  _id: string;
  userId: string | User;
  jobId?: string | Job;
  applicationId: string | Application;
  salary: string;
  startDate: string;
  position: string;
  department?: string;
  location?: string;
  reportingTo?: string;
  responsibilities?: string;
  benefits?: string;
  termsAndConditions?: string;
  status: 'sent' | 'viewed' | 'accepted' | 'rejected' | 'expired' | 'pending' | 'declined';
  message?: string;
  expiresAt?: string;
  respondedAt?: string;
  createdAt?: string;
}

// API Response Types
export interface ApiResponse<T> {
  data?: T;
  user?: T;
  message?: string;
  success?: boolean;
}

export interface PaginatedResponse<T> {
  users?: T[];
  jobs?: T[];
  applications?: T[];
  offers?: T[];
  notifications?: T[];
  total: number;
  page: number;
  pages: number;
}

// Auth Types
export interface LoginCredentials {
  email: string;
  password: string;
}

export interface AuthResponse {
  token: string;
  user: User;
}

// Admin Stats
export interface AdminStats {
  totalUsers: number;
  totalJobs: number;
  totalApplications: number;
  pendingApplications: number;
  acceptedApplications: number;
  rejectedApplications: number;
}

// Form Types
export interface JobFormData {
  companyName: string;
  jobTitle: string;
  location: string;
  jobType: string;
  contractType: string;
  experienceLevel: string;
  salary: string;
  companyLogo?: string;
  category: string;
  description: string;
  officeAddress: string;
  skills: string[];
  responsibilities: string[];
  requirements: string[];
  benefits: string[];
}

export interface UserFormData {
  name: string;
  email: string;
  role: string;
  location?: string;
  profilePic?: string;
  skills?: string[];
  languages?: string[];
}
