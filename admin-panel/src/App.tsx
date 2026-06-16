import React, { Suspense, lazy } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { ProtectedRoute, AuthRoute, AdminLayoutRoute } from '@/routes';
import { FullPageLoading } from '@/components/common';

const LoginPage = lazy(() => import('@/pages/auth/LoginPage'));
const DashboardPage = lazy(() => import('@/pages/dashboard/DashboardPage'));
const UsersListPage = lazy(() => import('@/pages/users/UsersListPage'));
const UserDetailPage = lazy(() => import('@/pages/users/UserDetailPage'));
const JobsListPage = lazy(() => import('@/pages/jobs/JobsListPage'));
const JobFormPage = lazy(() => import('@/pages/jobs/JobFormPage'));
const JobDetailPage = lazy(() => import('@/pages/jobs/JobDetailPage'));
const ApplicationsListPage = lazy(() => import('@/pages/applications/ApplicationsListPage'));
const ApplicationDetailPage = lazy(() => import('@/pages/applications/ApplicationDetailPage'));
const NotificationsPage = lazy(() => import('@/pages/notifications/NotificationsPage'));
const OffersListPage = lazy(() => import('@/pages/offers/OffersListPage'));
const OfferFormPage = lazy(() => import('@/pages/offers/OfferFormPage'));
const SettingsPage = lazy(() => import('@/pages/settings/SettingsPage'));

function App() {
  return (
    <Suspense fallback={<FullPageLoading />}>
      <Routes>
        <Route
          path="/login"
          element={
            <AuthRoute>
              <LoginPage />
            </AuthRoute>
          }
        />

        <Route
          path="/"
          element={<AdminLayoutRoute />}
        >
          <Route index element={<DashboardPage />} />
          <Route path="users" element={<UsersListPage />} />
          <Route path="users/:id" element={<UserDetailPage />} />
          <Route path="jobs" element={<JobsListPage />} />
          <Route path="jobs/new" element={<JobFormPage />} />
          <Route path="jobs/:id" element={<JobDetailPage />} />
          <Route path="jobs/:id/edit" element={<JobFormPage />} />
          <Route path="applications" element={<ApplicationsListPage />} />
          <Route path="applications/:id" element={<ApplicationDetailPage />} />
          <Route path="notifications" element={<NotificationsPage />} />
          <Route path="offers" element={<OffersListPage />} />
          <Route path="offers/new" element={<OfferFormPage />} />
          <Route path="offers/:id" element={<OfferFormPage />} />
          <Route path="settings" element={<SettingsPage />} />
        </Route>

        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Suspense>
  );
}

export default App;
