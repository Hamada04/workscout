// User Types
export interface User {
  _id: string;
  name: string;
  email: string;
  role: 'user' | 'admin' | 'super_admin';
  location: string;
  profilePic: string;
  skills: string[];
  languages: string[];
  education: Education[];
  experiences: Experience[];
  savedJobsIds: string[];
  createdAt: string;
  updatedAt: string;
  isActive: boolean;
}

export interface Education {
  degree: string;
  university: string;
  level: string;
  date: string;
}

export interface Experience {
  title: string;
  company: string;
  date: string;
  logo: string;
}

// Job Types
export interface Job {
  _id: string;
  companyName: string;
  jobTitle: string;
  location: string;
  jobType: 'Remote' | 'Fulltime' | 'Parttime' | 'Contract';
  contractType: string;
  experienceLevel: 'Entry level' | 'Junior' | 'Senior' | 'Mid';
  postedDate: string;
  salary: string;
  companyLogo: string;
  category: string;
  description: string;
  officeAddress: string;
  skills: string[];
  responsibilities: string[];
  requirements: string[];
  benefits: string[];
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}

// Application Types
export interface Application {
  _id: string;
  userId: string | User;
  jobId: string | Job;
  resumeUrl: string;
  coverLetter: string;
  status: ApplicationStatus;
  adminMessage: string;
  appliedDate: string;
  createdAt: string;
  updatedAt: string;
}

export type ApplicationStatus = 'Submitted' | 'Under Review' | 'Interview' | 'Accepted' | 'Rejected';

// Notification Types
export interface Notification {
  _id: string;
  userId: string | User;
  type: 'offer' | 'application' | 'system';
  title: string;
  description: string;
  actionLabel: string;
  relatedJobId?: string;
  relatedApplicationId?: string;
  isRead: boolean;
  createdAt: string;
}

// Offer Letter Types
export interface OfferLetter {
  _id: string;
  applicationId: string | Application;
  userId: string | User;
  jobId: string | Job;
  position: string;
  startDate: string;
  salary: string;
  location: string;
  reportingTo: string;
  responsibilities: string;
  benefits: string;
  termsAndConditions: string;
  status: 'pending' | 'accepted' | 'declined';
  createdAt: string;
  respondedAt?: string;
}

// API Response Types
export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  message?: string;
  error?: string;
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  limit: number;
  totalPages: number;
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

export interface AdminStats {
  totalUsers: number;
  totalJobs: number;
  totalApplications: number;
  pendingApplications: number;
  acceptedApplications: number;
  rejectedApplications: number;
  newUsersThisWeek: number;
  newJobsThisWeek: number;
  newApplicationsThisWeek: number;
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
  companyLogo: string;
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
  location: string;
  profilePic: string;
  skills: string[];
  languages: string[];
}
