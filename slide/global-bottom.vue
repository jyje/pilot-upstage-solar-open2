<script setup lang="ts">
import { computed, onBeforeUnmount, ref } from 'vue';
import { useNav } from '@slidev/client';

const { currentSlideNo } = useNav();

const isKorean = computed(() => {
  if (typeof window === 'undefined') return false;
  return /(^|\/)ko(?:\/|$)/.test(window.location.pathname);
});

const localeHref = (targetLocale: 'en' | 'ko') => `../${targetLocale}/#${currentSlideNo.value}`;

const menuOpen = ref(false);
const toggleMenu = () => {
  menuOpen.value = !menuOpen.value;
};
const closeMenu = () => {
  menuOpen.value = false;
};

onBeforeUnmount(closeMenu);
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
  <div class="locale-menu-wrap">
    <button
      type="button"
      class="locale-switch locale-switch-btn"
      aria-label="Change language"
      :aria-expanded="menuOpen"
      @click="toggleMenu"
    >
      🌐
    </button>
    <div v-if="menuOpen" class="locale-menu" @mouseleave="closeMenu">
      <a
        class="locale-menu-item"
        :class="{ 'is-active': !isKorean }"
        :href="localeHref('en')"
        lang="en"
        @click="closeMenu"
      >
        English
      </a>
      <a
        class="locale-menu-item"
        :class="{ 'is-active': isKorean }"
        :href="localeHref('ko')"
        lang="ko"
        @click="closeMenu"
      >
        한국어
      </a>
    </div>
  </div>
  <div class="global-footer" aria-hidden="true">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2" target="_blank" rel="noreferrer">github.com/jyje/pilot-upstage-solar-open2</a>
    <span class="global-footer-dot">&middot;</span>
    <span>Built with Claude and Upstage's Solar Open 2 model.</span>
  </div>
</template>
