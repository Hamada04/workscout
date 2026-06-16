import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { AdminLayout } from '@/components/layout/AdminLayout';
import { FullPageLoading } from '@/components/common';

// Public routes (no auth required)
const publicRoutes = ['/login'];

// Lazy loaded pages
const LoginPage = React.lazy(() => import('@/pages/auth/LoginPage'));
const DashboardPage = React.lazy(() => import('@/pages/dashboard/DashboardPage'));
const UsersListPage = React.lazy(() => import('@/pages/users/UsersListPage'));
const UserDetailPage = React.lazy(() => import('@/pages/users/UserDetailPage'));
const JobsListPage = React.lazy(() => import('@/pages/jobs/JobsListPage'));
const JobFormPage = React.lazy(() => import('@/pages/jobs/JobFormPage'));
const JobDetailPage = React.lazy(() => import('@/pages/jobs/JobDetailPage'));
const ApplicationsListPage = React.lazy(() => import('@/pages/applications/ApplicationsListPage'));
const ApplicationDetailPage = React.lazy(() => import('@/pages/applications/ApplicationDetailPage'));
const NotificationsPage = React.lazy(() => import('@/pages/notifications/NotificationsPage'));
const OffersListPage = React.lazy(() => import('@/pages/offers/OffersListPage'));
const OfferFormPage = React.lazy(() => import('@/pages/offers/OfferFormPage'));
const SettingsPage = React.lazy(() => import('@/pages/settings/SettingsPage'));

// Protected Route Wrapper
export function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { isAuthenticated, isLoading } = useAuth();
  const location = useLocation();

  if (isLoading) {
    return <FullPageLoading />;
  }

  if (!isAuthenticated) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  return <>{children}</>;
}

// Auth Route Wrapper (redirect if already logged in)
export function AuthRoute({ children }: { children: React.ReactNode }) {
  const { isAuthenticated, isLoading } = useAuth();
  const location = useLocation();

  if (isLoading) {
    return <FullPageLoading />;
  }

  if (isAuthenticated) {
    return <Navigate to="/" state={{ from: location }} replace />;
  }

  return <>{children}</>;
}

// Layout wrapper for admin pages
export function AdminLayoutRoute() {
  return (
    <ProtectedRoute>
      <AdminLayout />
    </ProtectedRoute>
  );
}

// Route definitions
export interface RouteDefinition {
  path: string;
  element: React.ComponentType;
  layout?: 'admin' | 'auth' | 'public';
  children?: RouteDefinition[];
}

export const routes: RouteDefinition[] = [
  {
    path: '/login',
    element: LoginPage,
    layout: 'auth',
  },
  {
    path: '/',
    element: DashboardPage,
    layout: 'admin',
  },
  {
    path: '/users',
    element: UsersListPage,
    layout: 'admin',
  },
  {
    path: '/users/:id',
    element: UserDetailPage,
    layout: 'admin',
  },
  {
    path: '/jobs',
    element: JobsListPage,
    layout: 'admin',
  },
  {
    path: '/jobs/new',
    element: JobFormPage,
    layout: 'admin',
  },
  {
    path: '/jobs/:id',
    element: JobDetailPage,
    layout: 'admin',
  },
  {
    path: '/jobs/:id/edit',
    element: JobFormPage,
    layout: 'admin',
  },
  {
    path: '/applications',
    element: ApplicationsListPage,
    layout: 'admin',
  },
  {
    path: '/applications/:id',
    element: ApplicationDetailPage,
    layout: 'admin',
  },
  {
    path: '/notifications',
    element: NotificationsPage,
    layout: 'admin',
  },
  {
    path: '/offers',
    element: OffersListPage,
    layout: 'admin',
  },
  {
    path: '/offers/new',
    element: OfferFormPage,
    layout: 'admin',
  },
  {
    path: '/offers/:id',
    element: OfferFormPage,
    layout: 'admin',
  },
  {
    path: '/settings',
    element: SettingsPage,
    layout: 'admin',
  },
];

// Export individual page components for direct imports
export {
  LoginPage,
  DashboardPage,
  UsersListPage,
  UserDetailPage,
  JobsListPage,
  JobFormPage,
  JobDetailPage,
  ApplicationsListPage,
  ApplicationDetailPage,
  NotificationsPage,
  OffersListPage,
  OfferFormPage,
  SettingsPage,
};
