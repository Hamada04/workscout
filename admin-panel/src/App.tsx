import React, { Suspense } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { routes, ProtectedRoute, AuthRoute, AdminLayoutRoute } from '@/routes';
import { FullPageLoading } from '@/components/common';

// Loading fallback component
function PageLoader() {
  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center">
      <div className="text-center">
        <div className="w-12 h-12 border-4 border-primary-200 border-t-primary-600 rounded-full animate-spin mx-auto mb-4" />
        <p className="text-gray-500">Loading...</p>
      </div>
    </div>
  );
}

// Route renderer with lazy loading
function RouteRenderer({ route }: { route: typeof routes[0] }) {
  const PageComponent = route.element;
  
  if (route.layout === 'auth') {
    return (
      <AuthRoute>
        <PageComponent />
      </AuthRoute>
    );
  }

  if (route.layout === 'admin') {
    return (
      <AdminLayoutRoute />
    );
  }

  return <PageComponent />;
}

function App() {
  return (
    <Suspense fallback={<PageLoader />}>
      <Routes>
        {/* Public/Login Route */}
        <Route
          path="/login"
          element={
            <AuthRoute>
              <routes.find(r => r.path === '/login')!.element />
            </AuthRoute>
          }
        />

        {/* Protected Admin Routes */}
        <Route
          path="/"
          element={<AdminLayoutRoute />}
        >
          <Route index element={<routes.find(r => r.path === '/')!.element />} />
          <Route path="users" element={<routes.find(r => r.path === '/users')!.element />} />
          <Route path="users/:id" element={<routes.find(r => r.path === '/users/:id')!.element />} />
          <Route path="jobs" element={<routes.find(r => r.path === '/jobs')!.element />} />
          <Route path="jobs/new" element={<routes.find(r => r.path === '/jobs/new')!.element />} />
          <Route path="jobs/:id" element={<routes.find(r => r.path === '/jobs/:id')!.element />} />
          <Route path="jobs/:id/edit" element={<routes.find(r => r.path === '/jobs/:id/edit')!.element />} />
          <Route path="applications" element={<routes.find(r => r.path === '/applications')!.element />} />
          <Route path="applications/:id" element={<routes.find(r => r.path === '/applications/:id')!.element />} />
          <Route path="notifications" element={<routes.find(r => r.path === '/notifications')!.element />} />
          <Route path="offers" element={<routes.find(r => r.path === '/offers')!.element />} />
          <Route path="offers/new" element={<routes.find(r => r.path === '/offers/new')!.element />} />
          <Route path="offers/:id" element={<routes.find(r => r.path === '/offers/:id')!.element />} />
          <Route path="settings" element={<routes.find(r => r.path === '/settings')!.element />} />
        </Route>

        {/* Catch all - redirect to dashboard */}
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Suspense>
  );
}

export default App;
