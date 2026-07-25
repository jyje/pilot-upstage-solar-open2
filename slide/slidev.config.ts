import { defineConfig } from 'slidev';

export default defineConfig({
  title: 'jyje/pilot-upstage-solar-open2',
  description: 'Solar Open 2 × Agent Harness Experiments',
  aspectRatio: 9 / 16,
  canvasWidth: 720,
  routerMode: 'hash',
  head: {
    tags: [
      {
        tag: 'link',
        attrs: {
          rel: 'preconnect',
          href: 'https://fonts.googleapis.com',
        },
      },
      {
        tag: 'link',
        attrs: {
          rel: 'preconnect',
          href: 'https://fonts.gstatic.com',
          crossOrigin: true,
        },
      },
      {
        tag: 'link',
        attrs: {
          href: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600&display=swap',
          rel: 'stylesheet',
        },
      },
      {
        tag: 'meta',
        attrs: {
          name: 'color-scheme',
          content: 'dark',
        },
      },
    ],
  },
  navigation: {
    prev: 'auto',
    next: 'auto',
  },
  toast: {
    provider: 'console',
  },
  presenter: {
    showNote: false,
    showMeta: true,
  },
  controls: {
    invert: false,
    showCover: false,
    showArrows: true,
    showPagination: true,
    showStatus: true,
    showSteps: true,
  },
  shuffleQuestions: false,
  monaco: {
    options: {
      theme: 'vs-dark',
    },
  },
  themeConfig: {
    footer: true,
    display: 'bar',
    pagination: {
      number: false,
      skip: true,
      disable: false,
    },
  },
  icon: {
    provider: 'iconify',
    collections: {
      'lucide': 'lucide',
      'material-symbols': 'material-symbols-rounded',
    },
  },
});
