# WorkScout Admin Panel

A professional admin dashboard for managing the WorkScout job portal platform.

## Tech Stack

- **React 18** - UI library
- **TypeScript** - Type safety
- **Vite** - Build tool
- **Tailwind CSS** - Styling
- **React Router v6** - Routing
- **Lucide React** - Icons

## Project Structure

```
admin-panel/
├── src/
│   ├── components/
│   │   ├── common/           # Reusable UI components
│   │   │   ├── Avatar.tsx
│   │   │   ├── Badge.tsx
│   │   │   ├── Button.tsx
│   │   │   ├── Card.tsx
│   │   │   ├── DataTable.tsx
│   │   │   ├── FormFields.tsx
│   │   │   ├── Input.tsx
│   │   │   ├── Modal.tsx
│   │   │   ├── SearchFilter.tsx
│   │   │   ├── Select.tsx
│   │   │   └── index.ts
│   │   └── layout/          # Layout components
│   │       ├── AdminLayout.tsx
│   │       ├── PageHeader.tsx
│   │       ├── Sidebar.tsx
│   │       └── Topbar.tsx
│   ├── contexts/
│   │   └── AuthContext.tsx   # Authentication context
│   ├── hooks/
│   │   ├── useApi.ts         # API hook
│   │   └── usePermission.ts  # Permission hook
│   ├── pages/
│   │   ├── auth/
│   │   │   └── LoginPage.tsx
│   │   ├── dashboard/
│   │   │   └── DashboardPage.tsx
│   │   ├── users/
│   │   │   ├── UsersListPage.tsx
│   │   │   └── UserDetailPage.tsx
│   │   ├── jobs/
│   │   │   ├── JobsListPage.tsx
│   │   │   ├── JobDetailPage.tsx
│   │   │   └── JobFormPage.tsx
│   │   ├── applications/
│   │   │   ├── ApplicationsListPage.tsx
│   │   │   └── ApplicationDetailPage.tsx
│   │   ├── notifications/
│   │   │   └── NotificationsPage.tsx
│   │   ├── offers/
│   │   │   ├── OffersListPage.tsx
│   │   │   └── OfferFormPage.tsx
│   │   └── settings/
│   │       └── SettingsPage.tsx
│   ├── services/             # API services
│   │   ├── api.ts
│   │   ├── authService.ts
│   │   ├── userService.ts
│   │   ├── jobService.ts
│   │   ├── applicationService.ts
│   │   ├── notificationService.ts
│   │   └── offerService.ts
│   ├── types/                # TypeScript types
│   │   └── index.ts
│   ├── utils/
│   │   ├── constants.ts      # App constants
│   │   └── helpers.ts        # Utility functions
│   ├── routes/
│   │   └── index.tsx         # Route definitions
│   ├── styles/
│   │   └── globals.css       # Global styles
│   ├── App.tsx
│   └── main.tsx
├── package.json
├── tailwind.config.js
├── tsconfig.json
├── vite.config.ts
└── index.html
```

## Getting Started

### Prerequisites

- Node.js 18+
- npm or yarn

### Installation

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build
```

### Configuration

Create a `.env` file:

```env
VITE_API_URL=http://localhost:3000/api
```

## Features

### Dashboard
- Overview statistics (users, jobs, applications)
- Recent activity
- Quick actions

### User Management
- User list with search/filter
- User detail view
- Role management
- Account status toggle

### Job Management
- Job list with search/filter
- Job CRUD operations
- Category management
- Job status toggle

### Application Management
- Application list with status filters
- Application detail view
- Status updates
- Message to applicants
- Send offer letters

### Notification Management
- View all notifications
- Send custom notifications
- Notification templates

### Offer Letters
- Create offer letters
- Track response status
- Send reminders

### Settings
- General settings
- Notification preferences
- Category management
- System information

## Design System

### Colors
- Primary: `#4361ee` (Indigo)
- Success: `#10b981` (Green)
- Warning: `#f59e0b` (Yellow)
- Danger: `#ef4444` (Red)
- Sidebar: `#1e293b` (Dark Slate)

### Typography
- Font: Inter
- Headings: Bold (700)
- Body: Regular (400)

### Spacing
- Base unit: 4px
- Common spacings: 4, 8, 12, 16, 24, 32, 48px

### Components
- Cards: White background, rounded-xl, subtle shadow
- Buttons: Rounded-lg, clear variants
- Tables: Clean header, hover states
- Forms: Consistent spacing, clear labels

## API Integration

The admin panel is designed to work with the WorkScout backend API:

```
POST /api/auth/login
GET  /api/admin/users
GET  /api/admin/jobs
GET  /api/admin/applications
POST /api/admin/notifications
POST /api/admin/offers
```

## Role-Based Access

| Role | Permissions |
|------|-------------|
| Super Admin | Full access |
| Admin | All except settings |
| HR Admin | Applications & Offers |
| Support Admin | Read-only |

## License

MIT License - See LICENSE file for details.
