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
  <div class="global-brand" aria-hidden="true">
    <span class="global-brand-jyje">
      <img src="https://jyje.online/assets/icons/icon-128x128.png" alt="" />
      <span>jyje</span>
    </span>
    <span class="global-brand-x">×</span>
    <span class="global-brand-upstage">
      <img src="https://raw.githubusercontent.com/lobehub/lobe-icons/f07e9be35aef452ce735f95ea8204a14ecc513f7/packages/static-svg/icons/upstage-color.svg" alt="" />
      <img
        class="global-brand-upstage-text"
        src="https://raw.githubusercontent.com/lobehub/lobe-icons/f07e9be35aef452ce735f95ea8204a14ecc513f7/packages/static-svg/icons/upstage-text.svg"
        alt="Upstage"
      />
    </span>
  </div>
  <a class="locale-switch" :href="localeHref" :lang="isKorean ? 'en' : 'ko'">
    {{ localeLabel }}
  </a>
</template>
