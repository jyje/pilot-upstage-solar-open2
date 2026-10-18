# Local sprintf-js security patch

This directory vendors the BSD-3-Clause `sprintf-js` 1.0.3 source, with a local
security fix for unbounded floating-point precision specifiers. The package is
versioned `1.1.4-pilot.0` to distinguish this patched copy from upstream releases.

Floating-point precision is clamped to the ECMAScript-supported range before
formatting: 0-100 for `%e` and `%f`, and 1-100 for `%g`. This prevents oversized
or zero `%g` precision values from escaping as `RangeError` exceptions.

The package is retained under its original license in `LICENSE`. The regression
test is `slide/scripts/test-sprintf-js-security.mjs`, run with `npm run test:security`.
