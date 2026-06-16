import React from 'react';
import { Card, Button, Input, Select, Checkbox, SectionHeader, PageHeader } from '@/components/common';
import { APP_NAME, JOB_CATEGORIES } from '@/utils/constants';

const generalSettings = [
  { key: 'appName', label: 'Application Name', type: 'input', value: APP_NAME },
  { key: 'supportEmail', label: 'Support Email', type: 'input', value: 'support@workscout.com' },
  { key: 'timezone', label: 'Timezone', type: 'select', value: 'UTC' },
];

const notificationSettings = [
  { key: 'emailNotifications', label: 'Email Notifications', description: 'Receive email alerts for important events', enabled: true },
  { key: 'applicationAlerts', label: 'Application Alerts', description: 'Get notified when new applications are submitted', enabled: true },
  { key: 'weeklyReports', label: 'Weekly Reports', description: 'Receive weekly summary reports', enabled: false },
];

const categoryOptions = JOB_CATEGORIES.map(c => ({ value: c, label: c }));

export default function SettingsPage() {
  return (
    <div className="space-y-6 animate-fadeIn">
      <PageHeader
        title="Settings"
        subtitle="Manage application settings and configuration"
      />

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Main Settings */}
        <div className="lg:col-span-2 space-y-6">
          {/* General Settings */}
          <Card>
            <SectionHeader 
              title="General Settings" 
              description="Basic application configuration"
            />
            <div className="space-y-4">
              <Input
                label="Application Name"
                value={APP_NAME}
                onChange={() => {}}
              />
              <Input
                label="Support Email"
                value="support@workscout.com"
                onChange={() => {}}
              />
              <Select
                label="Default Timezone"
                value="UTC"
                onChange={() => {}}
                options={[
                  { value: 'UTC', label: 'UTC' },
                  { value: 'EST', label: 'Eastern Time (EST)' },
                  { value: 'PST', label: 'Pacific Time (PST)' },
                ]}
              />
            </div>
          </Card>

          {/* Notification Settings */}
          <Card>
            <SectionHeader 
              title="Notification Settings" 
              description="Configure system notifications and alerts"
            />
            <div className="space-y-4">
              {notificationSettings.map((setting) => (
                <div key={setting.key} className="flex items-start justify-between py-3 border-b border-gray-100 last:border-0">
                  <div className="flex items-start gap-3">
                    <Checkbox 
                      defaultChecked={setting.enabled}
                      className="mt-1"
                    />
                    <div>
                      <p className="font-medium text-gray-900">{setting.label}</p>
                      <p className="text-sm text-gray-500">{setting.description}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </Card>

          {/* Job Categories */}
          <Card>
            <SectionHeader 
              title="Job Categories" 
              description="Manage job posting categories"
            />
            <div className="flex flex-wrap gap-2">
              {JOB_CATEGORIES.map((category) => (
                <div 
                  key={category}
                  className="flex items-center gap-2 px-3 py-1.5 bg-gray-100 rounded-lg"
                >
                  <span className="text-sm text-gray-700">{category}</span>
                  <button className="text-gray-400 hover:text-red-500">
                    ×
                  </button>
                </div>
              ))}
              <button className="px-3 py-1.5 border border-dashed border-gray-300 rounded-lg text-sm text-gray-500 hover:border-primary-500 hover:text-primary-600">
                + Add Category
              </button>
            </div>
          </Card>

          {/* Save Button */}
          <div className="flex justify-end">
            <Button>Save Changes</Button>
          </div>
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Quick Settings */}
          <Card>
            <SectionHeader title="Quick Settings" />
            <div className="space-y-4">
              <div className="flex items-center justify-between py-2">
                <span className="text-gray-700">Maintenance Mode</span>
                <button className="relative w-11 h-6 bg-gray-200 rounded-full transition-colors">
                  <span className="absolute left-1 top-1 w-4 h-4 bg-white rounded-full shadow" />
                </button>
              </div>
              <div className="flex items-center justify-between py-2">
                <span className="text-gray-700">User Registration</span>
                <button className="relative w-11 h-6 bg-primary-500 rounded-full transition-colors">
                  <span className="absolute right-1 top-1 w-4 h-4 bg-white rounded-full shadow" />
                </button>
              </div>
              <div className="flex items-center justify-between py-2">
                <span className="text-gray-700">Email Verification</span>
                <button className="relative w-11 h-6 bg-primary-500 rounded-full transition-colors">
                  <span className="absolute right-1 top-1 w-4 h-4 bg-white rounded-full shadow" />
                </button>
              </div>
            </div>
          </Card>

          {/* System Info */}
          <Card>
            <SectionHeader title="System Information" />
            <div className="space-y-3 text-sm">
              <div className="flex justify-between">
                <span className="text-gray-500">Version</span>
                <span className="font-medium">1.0.0</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-500">Environment</span>
                <span className="font-medium">Production</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-500">Last Updated</span>
                <span className="font-medium">Today</span>
              </div>
            </div>
          </Card>

          {/* Danger Zone */}
          <Card className="border-red-200 bg-red-50">
            <SectionHeader title="Danger Zone" />
            <div className="space-y-3">
              <Button variant="danger" className="w-full" size="sm">
                Clear Cache
              </Button>
              <Button variant="danger" className="w-full" size="sm">
                Reset to Defaults
              </Button>
            </div>
          </Card>
        </div>
      </div>
    </div>
  );
}
