<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{
  en: string;
  ko: string;
}>();

const locale = computed(() => {
  if (typeof window === 'undefined') return 'en';
  return /(^|\/)ko(?:\/|$)/.test(window.location.pathname) ? 'ko' : 'en';
});

const text = computed(() => (locale.value === 'ko' ? props.ko : props.en));
</script>

<template>
  <span>{{ text }}</span>
</template>
