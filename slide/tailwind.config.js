/** @type {import('tailwindcss').Config} */
export default {
  darkMode: 'class',
  content: ['./index.html', './slides/*.md', './components/**/*.vue'],
  theme: {
    extend: {
      colors: {
        upstage: {
          bg: '#050510',
          surface: '#0a0a1a',
          surfaceLight: '#111128',
          primary: '#5b9cf5',
          primaryLight: '#7fb4ff',
          secondary: '#34d399',
          accent: '#f59e0b',
          text: '#e5e7eb',
          muted: '#9ca3af',
        },
      },
      fontFamily: {
        heading: ['Inter', 'sans-serif'],
        body: ['Inter', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
      boxShadow: {
        'upstage-card':
          '0 4px 24px rgba(0, 0, 0, 0.4), 0 1px 4px rgba(0, 0, 0, 0.2)',
        'upstage-glow':
          '0 0 20px rgba(91, 156, 245, 0.15), 0 0 60px rgba(91, 156, 245, 0.05)',
      },
    },
  },
  plugins: [],
};
