import assert from 'node:assert/strict'
import { createRequire } from 'node:module'

const require = createRequire(import.meta.url)
const { sprintf } = require('sprintf-js')

assert.equal(sprintf('%.101f', 1), `1.${'0'.repeat(100)}`)
assert.equal(sprintf('%.101e', 1), sprintf('%.100e', 1))
assert.equal(sprintf('%.101g', 1), sprintf('%.100g', 1))
assert.equal(sprintf('%.0g', 1), '1')
assert.equal(sprintf('%.999999999999999999999999999999f', 1), `1.${'0'.repeat(100)}`)
assert.equal(sprintf('%.999999999999999999999999999999g', 1), sprintf('%.100g', 1))
assert.equal(sprintf('%.2f', 1.25), '1.25')

console.log('sprintf-js precision bounds passed')
