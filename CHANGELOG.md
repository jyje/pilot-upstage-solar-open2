# Changelog

All notable changes to this repo are documented here.
## [1.1] - 2026-07-23

### Features

- ✨ feat(grok-build): add Case 06 — Grok Build against Solar Open 2 ([`799aef2`](https://github.com/jyje/pilot-upstage-solar-open2/commit/799aef2c3ef157b55228a4c599c33c4eae11da2a)) — @jyje
- ✨ feat(ci): wire Case 06 into CI and add per-case manual workflows ([`9cf1466`](https://github.com/jyje/pilot-upstage-solar-open2/commit/9cf1466936b2c18654a4c024f039ce7affa4584e)) — @jyje
- ✨ feat(hermes-helm): add Case 07 — Hermes Agent Helm against Solar Open 2 on kind ([`963a297`](https://github.com/jyje/pilot-upstage-solar-open2/commit/963a2970e5f60bf12366a880d65f2e4ad7237ead)) — @jyje
- ✨ feat(ci): wire Case 07 into CI and add its per-case manual workflow ([`bec70a9`](https://github.com/jyje/pilot-upstage-solar-open2/commit/bec70a9d63c5a2047ae8fb4b8474deaa8c44dbe2)) — @jyje


### Bug Fixes

- 🐛 bug(readme): fix broken Hugging Face model URLs ([`46dca2d`](https://github.com/jyje/pilot-upstage-solar-open2/commit/46dca2d611380f897652fab03ffb692866f964ac)) — @jyje
- 🛠️ fix(case-03): pin Python 3.13 to match Case 04 ([`8372e27`](https://github.com/jyje/pilot-upstage-solar-open2/commit/8372e270b289a8ff769becd4900f95417ee8a06c)) — @jyje
- 🐛 bug(openwiki): fix broken cross-file heading anchor links ([`fd1b9a3`](https://github.com/jyje/pilot-upstage-solar-open2/commit/fd1b9a3750c6002cd0954c9c40da5165c6c9bc2b)) — @jyje


### Refactor

- ♻️ refactor(verify): show ~700-char, 10+ line evidence previews ([`acd4439`](https://github.com/jyje/pilot-upstage-solar-open2/commit/acd4439a6ee4d5cf6aa52d69c9b5e1ffa568b469)) — @jyje


<details>
<summary>Documentation (35)</summary>

- Docs: add a per-case Use Case Guide for local verification (#1) ([`6686aff`](https://github.com/jyje/pilot-upstage-solar-open2/commit/6686affecb05dbe0c0821321af96d824b884b214)) — @jyje
- 📄 docs(case-01): split into Case 01A / Case 01B, official CLI first (#2) ([`94e2d15`](https://github.com/jyje/pilot-upstage-solar-open2/commit/94e2d15122732b32091308cad12cff3810980819)) — @jyje
- 📄 docs(readme): add a Solar Open2 model card and Hugging Face/launch badges ([`912aed4`](https://github.com/jyje/pilot-upstage-solar-open2/commit/912aed44cadca8129f4843d71e53804e2c99d72e)) — @jyje
- 📄 docs(readme): switch Hugging Face badge to shields.io style ([`6068778`](https://github.com/jyje/pilot-upstage-solar-open2/commit/60687784b7b3238f0a80a70fafc2d60cb8065524)) — @jyje
- 📄 docs(readme): rewrite Case 01 for readability, unify evidence-run label ([`1f9388b`](https://github.com/jyje/pilot-upstage-solar-open2/commit/1f9388b9365eb06f3ffefb277bd00a4e599bfa27)) — @jyje
- 📄 docs(case-01): document the Claude Code CLI version behind the evidence run ([`cf25238`](https://github.com/jyje/pilot-upstage-solar-open2/commit/cf252388c4e7cdf5ee7e116111b631b999d74960)) — @jyje
- 📄 docs(case-02): break up long sentences for readability ([`bc1a58b`](https://github.com/jyje/pilot-upstage-solar-open2/commit/bc1a58b16ca06fa19ee39d935d926e3dfff4145f)) — @jyje
- 📄 docs(case-03): break up long sentences for readability ([`50b213e`](https://github.com/jyje/pilot-upstage-solar-open2/commit/50b213e6be0efb923f23416f2612bf2d5c3a4d63)) — @jyje
- 📄 docs(case-04): break up long sentences for readability ([`a3dd05a`](https://github.com/jyje/pilot-upstage-solar-open2/commit/a3dd05a47306a8692f090d16c823cad4cb285483)) — @jyje
- 📄 docs(case-05): tighten one dense sentence for readability ([`b43107b`](https://github.com/jyje/pilot-upstage-solar-open2/commit/b43107b38c59158d68e62938d7a44542c6097dcb)) — @jyje
- 📄 docs(readme): break up long sentences for readability ([`56e7e40`](https://github.com/jyje/pilot-upstage-solar-open2/commit/56e7e4014d22a3cb9e70855feba4884ef6d4a4f9)) — @jyje
- 📄 docs(agents): break up a dense paragraph for readability ([`f769b72`](https://github.com/jyje/pilot-upstage-solar-open2/commit/f769b724b873f9b30c15bfd42b2d3ef0747991fe)) — @jyje
- 📄 docs(contributing): tighten one dense sentence for readability ([`728abb3`](https://github.com/jyje/pilot-upstage-solar-open2/commit/728abb3601ccec6be07d2009f38f724ef7452a08)) — @jyje
- 📄 docs(plan): break up long sentences in Result/Finding bullets ([`2b6d6bf`](https://github.com/jyje/pilot-upstage-solar-open2/commit/2b6d6bf68c37d3ea664e50bad6b9102813324ee3)) — @jyje
- 📄 docs(draft): break up long sentences and fix an awkward translation ([`d54280b`](https://github.com/jyje/pilot-upstage-solar-open2/commit/d54280b595569b64e0b585048021d428475f2bde)) — @jyje
- 📝 docs(ko): Fix all awkward Korean expressions across 6 README files ([`18c9285`](https://github.com/jyje/pilot-upstage-solar-open2/commit/18c9285321506f12e5c642c9c613ddc60d54c3d8)) — @jyje
- 📝 docs(ko): Fix all awkward Korean expressions across 7 README files ([`c0d2caf`](https://github.com/jyje/pilot-upstage-solar-open2/commit/c0d2cafc3f4095aaee16318286d13a1daa895435)) — @jyje
- 📄 docs(cases): reorder cases and add category labels ([`9b7c4cf`](https://github.com/jyje/pilot-upstage-solar-open2/commit/9b7c4cf5acfe5c1907cc89558b9e39e9885a9633)) — @jyje
- 📄 docs(readme): add the Category column missing from 9b7c4cf ([`adf0be1`](https://github.com/jyje/pilot-upstage-solar-open2/commit/adf0be1d11e93cd1b259d4e1099b897d24f78eac)) — @jyje
- 📄 docs(branding): rename "Solar Open2" to "Solar Open 2" throughout ([`607af3a`](https://github.com/jyje/pilot-upstage-solar-open2/commit/607af3a02d0221c89520d955c5bf4c10b7e435d2)) — @jyje
- 📄 docs: refresh every case's evidence with the expanded-preview CI run ([`6b3860c`](https://github.com/jyje/pilot-upstage-solar-open2/commit/6b3860cb2c1297732300339b4578e89786c7c986)) — @jyje
- 📄 docs(readme): update hero tagline to reflect the new case order ([`9546015`](https://github.com/jyje/pilot-upstage-solar-open2/commit/954601577e2b431227e73d4690e18bed0c300f08)) — @jyje
- 📄 docs(readme): refine hero tagline wording ([`440a521`](https://github.com/jyje/pilot-upstage-solar-open2/commit/440a521166d5706feeb60c870355420bb0e2b509)) — @jyje
- 📄 docs(agents): document canonical Solar Open 2 naming conventions ([`1aefcbf`](https://github.com/jyje/pilot-upstage-solar-open2/commit/1aefcbf74f0d69b95ec677e75a26f944a4e01770)) — @jyje
- 📄 docs(readme): update the README header logo background to white ([`1ab333c`](https://github.com/jyje/pilot-upstage-solar-open2/commit/1ab333c21b9d166a288332552e9a26390a413810)) — @jyje
- 📄 docs(draft): drop the Case 02 label and mark this draft as paused ([`e248939`](https://github.com/jyje/pilot-upstage-solar-open2/commit/e24893973447597b8785621d4e2948094eabeb5c)) — @jyje
- 📄 docs(cases): reference Case 06 across repo-level docs ([`61dccf6`](https://github.com/jyje/pilot-upstage-solar-open2/commit/61dccf6e15207bbebb436cddc876c7b0f8434480)) — @jyje
- 📄 docs(grok-build): fill in Case 06's real CI evidence run ([`ba85efa`](https://github.com/jyje/pilot-upstage-solar-open2/commit/ba85efadc6ec1fd9178a6a2ef0c9b68e887e3a52)) — @jyje
- 📄 docs(readme): add Grok Build to the hero tagline ([`3df68df`](https://github.com/jyje/pilot-upstage-solar-open2/commit/3df68df20ab55c16d15dfceaa9e25dc1515ffb57)) — @jyje
- 📄 docs(grok-build): mark Case 06 Verified, tool-calling as a known limitation ([`5f595b7`](https://github.com/jyje/pilot-upstage-solar-open2/commit/5f595b7b8bf5ee331e91e78f8cf7056914f3ddc7)) — @jyje
- 📄 docs(readme): add Grok Build's logo to the header image ([`7b6643c`](https://github.com/jyje/pilot-upstage-solar-open2/commit/7b6643c78b94d90a2fb7897be0b7d2307b3c3639)) — @jyje
- 📄 docs(cases): reference Case 07 across repo-level docs ([`55b928e`](https://github.com/jyje/pilot-upstage-solar-open2/commit/55b928edd658b46cf4e95361ff46c217aed49069)) — @jyje
- 📄 docs(hermes-helm): fill in Case 07's real CI evidence run ([`4736c66`](https://github.com/jyje/pilot-upstage-solar-open2/commit/4736c66f4e072ffdd338261c8f701eeb8549c32e)) — @jyje
- 📄 docs(readme): clarify Case 07's Kubernetes framing across repo docs ([`fbee4cd`](https://github.com/jyje/pilot-upstage-solar-open2/commit/fbee4cdaf07f120fc7dfd43a10115115f749ea4d)) — @jyje
- 📄 docs(readme): describe Case 07 as verifying usability, not reachability ([`d978a30`](https://github.com/jyje/pilot-upstage-solar-open2/commit/d978a3079c0cd67fdd9293d720731a3e8c3f8ae0)) — @jyje

</details>


### Build

- 🔨 build(ci): split the recap into Review/Extend category tables ([`356206a`](https://github.com/jyje/pilot-upstage-solar-open2/commit/356206a47253f8063d9417f89b165bcc65d900a1)) — @jyje
- 🔨 build(ci): move the runner to ubuntu-26.04-arm ([`6e2ed3f`](https://github.com/jyje/pilot-upstage-solar-open2/commit/6e2ed3fd5b925799c2d58082d5213e4d3d25374b)) — @jyje


<details>
<summary>Miscellaneous (2)</summary>

- 🎨 style(readme): add a Python 3.13 badge next to the CI badge ([`851aa90`](https://github.com/jyje/pilot-upstage-solar-open2/commit/851aa90c6f1a7412c49d530ec43daae75bbca3b1)) — @jyje
- 🎨 style(readme): enlarge the hero logo image to 300px ([`bb24901`](https://github.com/jyje/pilot-upstage-solar-open2/commit/bb24901e146453f8cf8fbe176078e5c02ebbeb1a)) — @jyje

</details>


## [1.0] - 2026-07-21

### Features

- ✨ feat(ci): add rate-limit retry and per-model fan-out to every case ([`46f0fa9`](https://github.com/jyje/pilot-upstage-solar-open2/commit/46f0fa938ad76139a85a9261c77ec5299bb40a19)) — @jyje
- ✨ feat(ci): add a sequential, rate-limit-spaced fan-out companion ([`cf94166`](https://github.com/jyje/pilot-upstage-solar-open2/commit/cf94166c1793756556da336a654d20b14cea837e)) — @jyje
- ✨ feat(ci): wait on Upstage's real rate-limit headers, not a guess ([`16bed8f`](https://github.com/jyje/pilot-upstage-solar-open2/commit/16bed8ff8bff44b06d98b44674c51a3b06108961)) — @jyje


### Bug Fixes

- 🛠️ fix(ci): stop verify-all from auto-firing on every workflow push ([`740760b`](https://github.com/jyje/pilot-upstage-solar-open2/commit/740760b850d723c57ca61724ff8183a74e52ff37)) — @jyje
- 🐛 bug(verify): catch exceptions for clean logs instead of raw tracebacks ([`daf5dfd`](https://github.com/jyje/pilot-upstage-solar-open2/commit/daf5dfdb3b2d356bef72cac60119081ed5b232d0)) — @jyje
- 🐛 bug(verify): stop hardcoding "Solar Open2" in per-model log lines ([`7dcc494`](https://github.com/jyje/pilot-upstage-solar-open2/commit/7dcc4949c815c5d5d3d0ca3880abb1fe0998afa4)) — @jyje
- 🛠️ fix(ci): raise the token headroom safety margin for heavy calls ([`5857fc2`](https://github.com/jyje/pilot-upstage-solar-open2/commit/5857fc2403516bc22fa28832f5075eba8a1c22a8)) — @jyje
- 🛠️ fix(verify): check Upstage headroom before every Case 04 question ([`581cd49`](https://github.com/jyje/pilot-upstage-solar-open2/commit/581cd49d3898f4c5018e8efe4c3455e2d446be29)) — @jyje
- 🐛 bug(verify): stop headroom-check output from polluting Case 04 answers ([`f5bd1f6`](https://github.com/jyje/pilot-upstage-solar-open2/commit/f5bd1f6f24bfe50f4d4fd47fde4c00ef595e17c4)) — @jyje
- 🛠️ fix(verify): give Case 04 more buffer and one more retry attempt ([`340633f`](https://github.com/jyje/pilot-upstage-solar-open2/commit/340633fdccf0ed2a78efcfffa88129d8e1b4e92b)) — @jyje
- 🛠️ fix(verify): 5 retry attempts everywhere, flat 30s backoff ([`7dd21f0`](https://github.com/jyje/pilot-upstage-solar-open2/commit/7dd21f010b7b2c0ee4c562214350b27e2f2577a6)) — @jyje
- 🛠️ fix(ci): headroom wait is reset-time + 30s buffer, not a flat 30s ([`95810ad`](https://github.com/jyje/pilot-upstage-solar-open2/commit/95810ad825351418355879c750133284c09b9444)) — @jyje
- 🛠️ fix(ci): serialize all 7 verify workflows on one concurrency group ([`74397c7`](https://github.com/jyje/pilot-upstage-solar-open2/commit/74397c7ad19f9b29166a7047383ee3d2e45078a6)) — @jyje
- 🛠️ fix(ci): skip Case 04's solar-pro3, a known Tier-0 capacity limit ([`3c16d35`](https://github.com/jyje/pilot-upstage-solar-open2/commit/3c16d3512e19a9544cef2dc49b975daf91c6d64c)) — @jyje
- 🐛 fix(ci): wait for a full Upstage budget reset before each case starts ([`09dd228`](https://github.com/jyje/pilot-upstage-solar-open2/commit/09dd2282849f9bc9cec4760075abacc8a4305eb5)) — @jyje
- 🐛 fix(ci): apply the full-reset wait inside Case 04's retries too ([`ba19366`](https://github.com/jyje/pilot-upstage-solar-open2/commit/ba19366fcb0c3425c09d3de92b36279f59c1c7f8)) — @jyje
- 🐛 fix(ci): apply the full-reset wait inside Case 04's retries too ([`07510bd`](https://github.com/jyje/pilot-upstage-solar-open2/commit/07510bd0b0051237e3c68317afd31c1e5151c51a)) — @jyje


### Refactor

- ♻️ refactor(ci): collapse the sequential fan-out to 10 readable steps ([`cc2b727`](https://github.com/jyje/pilot-upstage-solar-open2/commit/cc2b727b6c55314d697e04eed01f60342a8d8989)) — @jyje


<details>
<summary>Documentation (8)</summary>

- 📄 docs(ci): explain the openwiki fork inline, add a recap step ([`c52558d`](https://github.com/jyje/pilot-upstage-solar-open2/commit/c52558d9ce38f21db259cd27bcd34b560407c546)) — @jyje
- 📄 docs(ci): note this pipeline assumes the default Upstage tier ([`decc5ec`](https://github.com/jyje/pilot-upstage-solar-open2/commit/decc5eca82a37fbab408847fd69edd1ba1e897a5)) — @jyje
- 📄 docs(readme): add a multi-model verification history table ([`f182866`](https://github.com/jyje/pilot-upstage-solar-open2/commit/f182866a74680165163c2975dd236f7e03db3821)) — @jyje
- 📄 docs(conventions): document Case 04's solar-pro3 as a Tier-0 limit ([`14f3695`](https://github.com/jyje/pilot-upstage-solar-open2/commit/14f3695fd7da4fb16b450eb53f00b0b5a8c7433e)) — @jyje
- 📄 docs(readme): add the missing logo image referenced by README.md ([`e1402be`](https://github.com/jyje/pilot-upstage-solar-open2/commit/e1402beb560a1fb800499095496fe63a65b17f1f)) — @jyje
- 📄 docs(readme): update the README header logo image ([`0a2000e`](https://github.com/jyje/pilot-upstage-solar-open2/commit/0a2000e6c399405b395f181c2f01e97ff0a378b0)) — @jyje
- 📄 docs(readme): expand root README and drop "portfolio" framing repo-wide ([`9ba210a`](https://github.com/jyje/pilot-upstage-solar-open2/commit/9ba210a47a733bf17d2cd67b6344466ef52826f6)) — @jyje
- 📄 docs(contributing): add CONTRIBUTING.md with conventions and local dev commands ([`29de5ec`](https://github.com/jyje/pilot-upstage-solar-open2/commit/29de5ec4be89afa9a84b4b1acc4fe37a7a84e99f)) — @jyje

</details>


<details>
<summary>Miscellaneous (2)</summary>

- 🔧 chore(ci): archive the other 6 workflows, keep only the sequential one ([`fda25c8`](https://github.com/jyje/pilot-upstage-solar-open2/commit/fda25c88c5d40aa92edef277122ec862950bc8ce)) — @jyje
- 🔧 chore(ci): drop archived workflows and multi-model tracking, solar-open2 only ([`3948aad`](https://github.com/jyje/pilot-upstage-solar-open2/commit/3948aad3aa1c0fa27c4d71e627f7ff8a2ee4287e)) — @jyje

</details>


## [0.1] - 2026-07-20

### Initial Release

- 🎉 init: scaffold pilot-solar-2 portfolio repo ([`c95a0f7`](https://github.com/jyje/pilot-upstage-solar-open2/commit/c95a0f70f78b7bd2fa6e6fdd7ae173ec140c013d)) — @jyje


### Features

- ✨ feat(01-solar-open2-harness): verify Claude Code against Solar Open2 ([`6ac398d`](https://github.com/jyje/pilot-upstage-solar-open2/commit/6ac398d061561ffabf79346e79530d77b3397325)) — @jyje
- ✨ feat(01-solar-open2-harness): verify skill invocation on Solar Open2 ([`172d90c`](https://github.com/jyje/pilot-upstage-solar-open2/commit/172d90c42a44a7fc5829cdbd4d1223e42bdf0cc3)) — @jyje
- ✨ feat(01-solar-open2-harness): cover fable + subagent model slots ([`cb03509`](https://github.com/jyje/pilot-upstage-solar-open2/commit/cb0350978736029a8d579af730ac501b9d110233)) — @jyje
- ✨ feat(01-solar-open2-harness): print truncated response previews ([`0a1530b`](https://github.com/jyje/pilot-upstage-solar-open2/commit/0a1530b34b0ea0abeae582800d53611c385f8ec2)) — @jyje
- ✨ feat(02-claude-agent-sdk-local): verify Claude Agent SDK against Solar Open2 ([`fa48f86`](https://github.com/jyje/pilot-upstage-solar-open2/commit/fa48f863ef37eafed24b2cc361c9e74a448867e8)) — @jyje
- ✨ feat(03-langchain-upstage-deepagents): verify deepagents against Solar Open2 ([`7f5b48e`](https://github.com/jyje/pilot-upstage-solar-open2/commit/7f5b48ece03df10d8e1d41dadeaee7e1a562d16e)) — @jyje
- ✨ feat(04-langchain-openwiki-solar-open2): verify openwiki against Solar Open2 ([`52ea835`](https://github.com/jyje/pilot-upstage-solar-open2/commit/52ea835eb7d4a0b8dc78d44d089eeb858f2ea548)) — @jyje
- ✨ feat(conventions): add AGENTS.md and .agents/skills for Codex CLI support ([`5fd7aad`](https://github.com/jyje/pilot-upstage-solar-open2/commit/5fd7aad81989bfc3f02e86f74ebc38b0222ebe8a)) — @jyje
- ✨ feat(hermes-agent): add verified Solar Open2 case ([`77df96f`](https://github.com/jyje/pilot-upstage-solar-open2/commit/77df96f164dd1ab1ffceac78de895ea411378dd6)) — @jyje


### Bug Fixes

- 🐛 bug(01-solar-open2-harness): fix verify.sh cwd for Method D ([`ca75924`](https://github.com/jyje/pilot-upstage-solar-open2/commit/ca759247c6863874cf39a0857115195ca4784504)) — @jyje
- 🛠️ fix(04-langchain-openwiki-solar-open2): retry questions on rate limit ([`70c743b`](https://github.com/jyje/pilot-upstage-solar-open2/commit/70c743bcf21fcab149eb4d03f9f7d22118b701fe)) — @jyje
- 🐛 bug(04-langchain-openwiki-solar-open2): send warn() to stderr ([`003c1a8`](https://github.com/jyje/pilot-upstage-solar-open2/commit/003c1a8fa20db045eb040271dfaf22f2a5cef677)) — @jyje
- 🐛 fix(ci): stabilize remote verification ([`8e78910`](https://github.com/jyje/pilot-upstage-solar-open2/commit/8e78910d9d26c93ec12c158188b424b6093c2469)) — @jyje
- 🐛 fix(hermes-agent): match bind mount ownership ([`c6a9717`](https://github.com/jyje/pilot-upstage-solar-open2/commit/c6a9717fbb0c4284ff3cf85307b3617ae51cac16)) — @jyje
- 🐛 fix(deepagents): make live gate diagnosable ([`ec9ce32`](https://github.com/jyje/pilot-upstage-solar-open2/commit/ec9ce32971beb36fed16e213101cbf0bcd3171a8)) — @jyje


<details>
<summary>Documentation (10)</summary>

- 📄 docs(01-solar-open2-harness): link evidence to a real CI run ([`6211fb5`](https://github.com/jyje/pilot-upstage-solar-open2/commit/6211fb5d2ffe00ef6a7c2168525eeeb47bbbed4d)) — @jyje
- 📄 docs(conventions): make every topic README bilingual, not just root ([`fcc7e13`](https://github.com/jyje/pilot-upstage-solar-open2/commit/fcc7e13d797d0d2222949a501b78bf70a4171b0a)) — @jyje
- 📄 docs(readme): drop + between hero logos, mark topic 02 verified ([`b90fa0c`](https://github.com/jyje/pilot-upstage-solar-open2/commit/b90fa0c4422428db7d0e17b2e24c76a184c77559)) — @jyje
- 📄 docs(01-solar-open2-harness): add Korean README twin ([`3c925e1`](https://github.com/jyje/pilot-upstage-solar-open2/commit/3c925e1f668a2abb958418b2a2080f708fe6642c)) — @jyje
- 📄 docs(02-claude-agent-sdk-local): link evidence to a real CI run ([`70ccf7a`](https://github.com/jyje/pilot-upstage-solar-open2/commit/70ccf7af0fc36eb7bbcbd0987b555fbaedb59aed)) — @jyje
- 📄 docs(conventions): relabel Topic N as Case 0N across all docs ([`c3c40a9`](https://github.com/jyje/pilot-upstage-solar-open2/commit/c3c40a9cf38ae0d46cd0343c352807851589a5da)) — @jyje
- 📄 docs(03-langchain-upstage-deepagents): link evidence to a real CI run ([`e295b82`](https://github.com/jyje/pilot-upstage-solar-open2/commit/e295b82ed0e0c04e6c481d69264e617d6274718b)) — @jyje
- 📄 docs(conventions): add Special Use Cases section for Case 04+ ([`0f42aa3`](https://github.com/jyje/pilot-upstage-solar-open2/commit/0f42aa322bf9ea294c51c82a6162a8226d259b83)) — @jyje
- 📄 docs(04-langchain-openwiki-solar-open2): link evidence to a real CI run ([`a056c3d`](https://github.com/jyje/pilot-upstage-solar-open2/commit/a056c3da1a5f74dd0f06b7786c4e249cfaec26eb)) — @jyje
- 📄 docs(conventions): flatten Experiments/Special Use Cases into one Case list ([`1f655d0`](https://github.com/jyje/pilot-upstage-solar-open2/commit/1f655d0d4a63f53cbbea4948096b5e3366eea758)) — @jyje

</details>


<details>
<summary>Miscellaneous (3)</summary>

- 🎨 style(readme): add CI status badge per centered-readme skill ([`d0b4ead`](https://github.com/jyje/pilot-upstage-solar-open2/commit/d0b4ead19911c6733026cc8acb32cb14a45869e6)) — @jyje
- 🔧 chore(conventions): rename repo to pilot-upstage-solar-open2 ([`7774edd`](https://github.com/jyje/pilot-upstage-solar-open2/commit/7774edd6c0bb142f0503c88469536019aba47e5a)) — @jyje
- 🔧 chore(conventions): rename remaining pilot-solar-2 references to pilot-upstage-solar-open2 ([`58daf7d`](https://github.com/jyje/pilot-upstage-solar-open2/commit/58daf7de073178944e800404f8cc163938669a33)) — @jyje

</details>


