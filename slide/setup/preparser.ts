import { definePreparserSetup } from '@slidev/types';

export default definePreparserSetup(() => [
  {
    name: 'normalize-slide-structure',
    transformSlide(content) {
      const withoutClickWrappers = content.replace(/<\/?v-click(?:\s[^>]*)?>\n?/g, '');
      const transformed = withoutClickWrappers.replace(
        /^# Case (0[1-7]) — (.+)$/gm,
        '<div class="case-pill">CASE $1</div>\n\n# $2',
      );
      return transformed === content ? undefined : transformed;
    },
  },
]);
