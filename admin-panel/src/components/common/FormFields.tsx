import React from 'react';
import { clsx } from 'clsx';
import { Input } from './Input';
import { Select } from './Select';
import { Button } from './Button';
import { Search } from 'lucide-react';

interface FilterOption {
  value: string;
  label: string;
}

interface FormFieldProps {
  label?: string;
  error?: string;
  hint?: string;
  children: React.ReactNode;
  className?: string;
}

export function FormField({ label, error, hint, children, className }: FormFieldProps) {
  return (
    <div className={clsx('space-y-1.5', className)}>
      {label && (
        <label className="block text-sm font-medium text-gray-700">{label}</label>
      )}
      {children}
      {error && <p className="text-sm text-red-600">{error}</p>}
      {hint && !error && <p className="text-sm text-gray-500">{hint}</p>}
    </div>
  );
}

// Textarea Component
interface TextareaProps extends React.TextareaHTMLAttributes<HTMLTextAreaElement> {
  label?: string;
  error?: string;
  hint?: string;
}

export const Textarea = React.forwardRef<HTMLTextAreaElement, TextareaProps>(
  ({ label, error, hint, className, ...props }, ref) => {
    return (
      <FormField label={label} error={error} hint={hint}>
        <textarea
          ref={ref}
          className={clsx(
            'block w-full rounded-lg border bg-white px-4 py-2.5 text-sm transition-all duration-200',
            'placeholder:text-gray-400 resize-none',
            'focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent',
            error 
              ? 'border-red-500 focus:ring-red-500' 
              : 'border-gray-200 hover:border-gray-300',
            props.disabled && 'bg-gray-50 cursor-not-allowed',
            className
          )}
          {...props}
        />
      </FormField>
    );
  }
);

Textarea.displayName = 'Textarea';

// Checkbox Component
interface CheckboxProps extends Omit<React.InputHTMLAttributes<HTMLInputElement>, 'type'> {
  label?: string;
}

export const Checkbox = React.forwardRef<HTMLInputElement, CheckboxProps>(
  ({ label, className, ...props }, ref) => {
    return (
      <label className="inline-flex items-center gap-2 cursor-pointer">
        <input
          ref={ref}
          type="checkbox"
          className={clsx(
            'rounded border-gray-300 text-primary-600 focus:ring-primary-500',
            className
          )}
          {...props}
        />
        {label && <span className="text-sm text-gray-700">{label}</span>}
      </label>
    );
  }
);

Checkbox.displayName = 'Checkbox';

// Multi-Select/Chips Input
interface ChipsInputProps {
  label?: string;
  value: string[];
  onChange: (value: string[]) => void;
  placeholder?: string;
  error?: string;
}

export function ChipsInput({ label, value, onChange, placeholder, error }: ChipsInputProps) {
  const [inputValue, setInputValue] = React.useState('');

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && inputValue.trim()) {
      e.preventDefault();
      if (!value.includes(inputValue.trim())) {
        onChange([...value, inputValue.trim()]);
      }
      setInputValue('');
    }
  };

  const removeChip = (chip: string) => {
    onChange(value.filter(v => v !== chip));
  };

  return (
    <FormField label={label} error={error}>
      <div className="space-y-2">
        <Input
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
          onKeyDown={handleKeyDown}
          placeholder={placeholder || 'Type and press Enter to add'}
        />
        {value.length > 0 && (
          <div className="flex flex-wrap gap-2">
            {value.map((chip) => (
              <span
                key={chip}
                className="inline-flex items-center gap-1 px-2.5 py-1 bg-primary-50 text-primary-700 text-sm rounded-full"
              >
                {chip}
                <button
                  type="button"
                  onClick={() => removeChip(chip)}
                  className="hover:text-primary-900"
                >
                  ×
                </button>
              </span>
            ))}
          </div>
        )}
      </div>
    </FormField>
  );
}

// Search Select (Combobox)
interface SearchSelectProps {
  label?: string;
  value: string;
  onChange: (value: string) => void;
  options: FilterOption[];
  placeholder?: string;
  searchPlaceholder?: string;
  error?: string;
}

export function SearchSelect({
  label,
  value,
  onChange,
  options,
  placeholder,
  searchPlaceholder,
  error,
}: SearchSelectProps) {
  const [search, setSearch] = React.useState('');
  const filteredOptions = options.filter(o => 
    o.label.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <FormField label={label} error={error}>
      <Select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        options={filteredOptions}
        placeholder={placeholder}
      />
    </FormField>
  );
}

// Form Actions (Submit/Cancel buttons)
interface FormActionsProps {
  onCancel?: () => void;
  cancelText?: string;
  submitText?: string;
  isLoading?: boolean;
  onSubmit?: () => void;
}

export function FormActions({
  onCancel,
  cancelText = 'Cancel',
  submitText = 'Save',
  isLoading = false,
  onSubmit,
}: FormActionsProps) {
  return (
    <div className="flex items-center justify-end gap-3 pt-4 border-t border-gray-200">
      {onCancel && (
        <Button variant="outline" onClick={onCancel}>
          {cancelText}
        </Button>
      )}
      {onSubmit && (
        <Button type="button" onClick={onSubmit} isLoading={isLoading}>
          {submitText}
        </Button>
      )}
    </div>
  );
}
