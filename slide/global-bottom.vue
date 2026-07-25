<script setup lang="ts">
import { computed } from 'vue';
import { useNav } from '@slidev/client';

const { currentSlideNo } = useNav();

const isKorean = computed(() => {
  if (typeof window === 'undefined') return false;
  return /(^|\/)ko(?:\/|$)/.test(window.location.pathname);
});

const localeHref = computed(() => {
  const targetLocale = isKorean.value ? 'en' : 'ko';
  return `../${targetLocale}/#${currentSlideNo.value}`;
});

const localeLabel = computed(() => (isKorean.value ? 'English' : '한국어'));
</script>

<template>
  <a class="locale-switch" :href="localeHref" :lang="isKorean ? 'en' : 'ko'">
    {{ localeLabel }}
  </a>
</template>
