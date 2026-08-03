# Case 01 — Solar Open 2 x Claude Code

[English](README.md) / [한국어](README-ko.md)

[← back to repo overview](../README.md) · Want to run this yourself?
See [`REPRODUCE.md`](REPRODUCE.md) for step-by-step local setup.

**Status:** Verified. Claude Code runs on Upstage's Solar Open 2 model in
three independent ways — Case 01A, Case 01B, and Case 01C below. Its
custom-skill system and its subagent/Task calls both work through that
same backend too. All five checks are confirmed end to end, locally and
in CI.

## Goal

Show that a Claude Code harness can run on Upstage's **Solar Open 2**
model instead of Anthropic's own models.

This case verifies three independent, self-contained ways to do that.
Each one gets its own sub-case below, with its own setup steps and its
own verified transcript:

- **[Case 01A](#case-01a--official-claude-code-cli)** — the **official**
  `claude` CLI, configured with plain environment variables. No wrapper,
  no proxy.
- **[Case 01B](#case-01b--claude-upstage-wrapper)** — Upstage's own
  `claude-upstage` convenience wrapper.
- **[Case 01C](#case-01c--jyjeclaude-docker)** — the official `claude`
  CLI again, but run inside
  [`jyje/claude-docker`](https://github.com/jyje/claude-docker), a
  community-maintained Docker image, instead of a bare npm install.

Case 01A's configuration is also what the rest of the harness runs on.
This repo's custom `.claude/skills/` and its subagent/Task-tool support
are both verified against Case 01A specifically, further down in that
section.

You'll need an API key from <https://console.upstage.ai/api-keys> for
any of the three sub-cases.

---

## Case 01A — official Claude Code CLI

### How it works

Upstage exposes an Anthropic Messages API-compatible endpoint at
`https://api.upstage.ai`. The official `claude` CLI already knows how to
talk to any Anthropic-compatible endpoint through environment variables.
So pointing it at Upstage instead of Anthropic is simple:

```bash
export ANTHROPIC_BASE_URL="https://api.upstage.ai"
export ANTHROPIC_AUTH_TOKEN="$UPSTAGE_API_KEY"
export ANTHROPIC_MODEL="solar-open2"
export ANTHROPIC_SMALL_FAST_MODEL="solar-open2"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="solar-open2"
export ANTHROPIC_DEFAULT_SONNET_MODEL="solar-open2"
export ANTHROPIC_DEFAULT_OPUS_MODEL="solar-open2"
export ANTHROPIC_DEFAULT_FABLE_MODEL="solar-open2"
export CLAUDE_CODE_SUBAGENT_MODEL="solar-open2"

claude -p "hello"
```

Every model *slot* Claude Code has needs to point at `solar-open2`.
Upstage only serves that one model, so any slot left unmapped risks a
background or subagent call asking for a model name the backend doesn't
have.

Two of these variables close gaps that Case 01B's `claude-upstage`
wrapper leaves open: `ANTHROPIC_DEFAULT_FABLE_MODEL` and
`CLAUDE_CODE_SUBAGENT_MODEL` (see the
[model configuration docs](https://code.claude.com/docs/en/model-config#environment-variables)).
The wrapper's own `set_claude_env` maps haiku/sonnet/opus/small-fast, but
it predates both the `fable` alias and the dedicated subagent-model
variable. That means a `fable`-aliased or subagent/Task-tool call routed
purely through `claude-upstage` isn't guaranteed to land on Solar Open 2.
That's one reason the skill and subagent checks below run against Case
01A's plain-env-var setup, not Case 01B's wrapper.

No fork, no patch, no proxy. The stock `claude` binary from
`@anthropic-ai/claude-code` just needs to be told where to send requests.
`claude-upstage` (Case 01B, below) is a convenience wrapper that sets
most of these variables for you and then `exec`s `claude`.

### Installation

Requires Node.js 18+:

```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

This repo doesn't pin a version, so `npm install -g @anthropic-ai/claude-code`
always grabs whatever's latest at CI run time. The evidence run below was
verified against Claude Code CLI **v2.1.218**.

### Verified: hello check

Here's real output from one CI run of `verify.sh` — the script's own
preview now shows up to ~700 characters (10+ wrapped lines) instead of a
single 100-char fragment, specifically so you can judge how the model
actually reasons, not just that it responded. Nothing here is
hand-picked or edited. Click through for anything longer than that:

**Evidence run:** [`verify` job, 2026-07-23](https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/30008688179/job/89210972882)
(or browse [every run](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml) for the latest)

```bash
export ANTHROPIC_BASE_URL="https://api.upstage.ai"
export ANTHROPIC_AUTH_TOKEN="$UPSTAGE_API_KEY"
export ANTHROPIC_MODEL="solar-open2"
claude -p "hello"
```
> Hello! 👋 I'm Solar Open2, an AI assistant built by Upstage AI. I'm
> here to help you with coding tasks, research, analysis, and more.
> What can I help you with today?

[Full output →](https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/30008688179/job/89210972882)

This is what `scripts/verify.sh` calls **Method B**. The response reads
this repo's actual `AGENTS.md`/state — not a canned reply. That confirms
Solar Open 2 answers through the full agentic Claude Code harness, tool
access included, not just a raw chat completion.

### Skills through Solar Open 2

This repo ships three small custom skills under `.claude/skills/`. One
formats a README's header into a consistent centered layout. One
enforces a gitmoji + conventional-commit style for every commit message.
One runs the lint/type-check/test workflow whenever Python code changes.

Do these skills actually get honored when Solar Open 2 is the model, not
just when a Claude model is? We tested with `git-commit-helper`, since
its output format is strict enough to check mechanically:
`<gitmoji> <type>(<domain>): <title>`.

**Finding: autonomous skill-selection is unreliable. Explicit invocation
is not.**

First, we asked — without naming any skill — "write the commit message"
for a new file. This was a one-off manual check, not part of the
automated suite. Solar Open 2 produced a plausible-looking message, but it
silently dropped the required format:

```bash
claude -p "Using this repo's git-commit-helper skill conventions, write \
  the commit message for a new file docs/hello.txt. Output only the \
  commit message."
```
> docs: add hello.txt greeting

No gitmoji, no `(domain)`. The skill's required format wasn't applied,
even though "git-commit-helper" appeared right there in the prompt's
wording.

Then we asked the same thing again, but this time told the model outright
to *use* the skill. This is what `scripts/verify.sh` calls **Method C**,
and it runs in CI every time (still on Case 01A's plain-env-var setup):

```bash
claude -p "Use the git-commit-helper skill. A new file docs/hello.txt \
  with a greeting was just added to this repo as a new doc. Write the \
  commit message per that skill's exact format (gitmoji + type(domain): \
  title). Output only the commit message."
```
> 📄 docs(docs): add hello greeting

[Full output →](https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/30008688179/job/89210972882)

Correct, once the skill is explicitly invoked: gitmoji, type, and
`(domain):` are all present.

The gap between these two prompts is small in wording but large in
outcome. Solar Open 2 can follow a skill's contract precisely once it's
told to load it. But it doesn't reliably decide *on its own* that a skill
applies just because the topic matches the skill's `description` trigger
phrases — the way Claude models tend to.

**Practical takeaway:** when running Claude Code on Solar Open 2, name the
skill explicitly in any prompt that needs it. Don't rely on automatic
trigger-phrase matching.

### Subagents stay on Solar Open 2 too

`CLAUDE_CODE_SUBAGENT_MODEL="solar-open2"` is what keeps subagent/Task-tool
calls — like the Explore agent — on Solar Open 2, instead of falling back
to whatever the SDK's default subagent model would otherwise be.

We verified this directly: asked the harness to hand a file-listing task
to the Explore subagent. This is what `scripts/verify.sh` calls
**Method D**, also run on Case 01A's setup:

```bash
claude -p "Use the Explore agent (a subagent) to list every file \
  directly inside the current directory. Report just the file list."
```
> Here are the files directly inside the current directory:
>
> 1. `.env.sample`
> 2. `README-ko.md`
> 3. `README.md`
> 4. `REPRODUCE-ko.md`
> 5. `REPRODUCE.md`

[Full output →](https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/30008688179/job/89210972882)

That file list matches this directory's real contents exactly — the
verification script itself checks for `README.md` specifically, but the
subagent's full listing lines up with every file actually here. That
confirms the subagent call really executed against the real filesystem,
routed through `solar-open2` the whole way down.

---

## Case 01B — `claude-upstage` wrapper

### How it works

`claude-upstage` is Upstage's own convenience wrapper, published at
`console.upstage.ai`. It sets most of Case 01A's `ANTHROPIC_*` variables
for you, through its own `set_claude_env`, and then `exec`s the same
stock `claude` binary.

No fork, no patch of `claude` itself. The wrapper is just a thinner way
to reach the same endpoint Case 01A talks to directly.

### Installation

```bash
# run once, no install:
curl -fsSL https://console.upstage.ai/claude-upstage.sh | sh

# review first, then run:
curl -fsSL https://console.upstage.ai/claude-upstage.sh -o claude-upstage.sh
less claude-upstage.sh && sh claude-upstage.sh

# install to ~/.local/bin so future runs are just `claude-upstage`:
curl -fsSL https://console.upstage.ai/claude-upstage.sh | sh -s install
```

`claude-upstage login` saves the API key to the OS keychain. Or just
export `UPSTAGE_API_KEY` for the current shell instead.

`claude-upstage` doesn't carry its own version number — it's a rolling
script that Upstage updates in place at `console.upstage.ai`, not a
pinned release. It also doesn't install or bundle Claude Code itself: it
just checks that `claude` is already on `PATH` and `exec`s that exact
binary. So it always runs on the exact same local Claude Code install as
Case 01A — same file, same version, not just a matching one. For the
evidence run below, that was Claude Code CLI **v2.1.218**.

### Finding: `claude-upstage` doesn't pass `-p` through

The literal form the harness was expected to support —
`claude-upstage -p "hello"` — **fails**: `claude-upstage: unknown command
'-p'`.

We checked both the locally installed copy and the current canonical
script fetched fresh from `console.upstage.ai` (byte-identical apart from
one unrelated line). So this isn't a stale-install issue — it's how the
wrapper's argument parser is currently written. `claude-upstage` only
forwards `--model`, `-c`/`--continue`, and `-r`/`--resume` to `claude`.
Anything else gets rejected before `claude` is ever invoked.

The workaround that does work non-interactively: pipe input to
`claude-upstage` instead of passing `-p`. With stdin not a tty, the
underlying `claude` process treats it as a single-shot prompt, just like
`-p` would:

```bash
echo "hello" | claude-upstage
```

### Verified: piped-stdin hello check

Here's real output from that same CI run of `verify.sh` — up to ~700
characters now, not a single 100-char fragment. Nothing here is
hand-picked or edited:

**Evidence run:** [`verify` job, 2026-07-23](https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/30008688179/job/89210972882)
(or browse [every run](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml) for the latest)

```bash
echo "hello" | claude-upstage
```
> Hello! 👋 I'm Solar Open2, an AI assistant trained by Upstage AI, a
> Korean startup. How can I help you today?

[Full output →](https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/30008688179/job/89210972882)

This is what `scripts/verify.sh` calls **Method A**. The response reads
this repo's actual `AGENTS.md`/state too, just like Case 01A's. The
wrapper reaches the same full agentic Claude Code harness — not a raw
chat completion.

---

## Case 01C — `jyje/claude-docker`

### How it works

[`jyje/claude-docker`](https://github.com/jyje/claude-docker) is a
community-maintained Docker image (`ghcr.io/jyje/claude-docker`) that
packages the official `@anthropic-ai/claude-code` npm release on top of
Node.js, with no Anthropic affiliation and no changes to the `claude`
binary itself. Its entrypoint just runs `claude` (or whatever command you
pass after the image name), so any environment variable passed through
`docker run -e` reaches the same stock CLI Case 01A talks to directly —
including the full `ANTHROPIC_*` model-slot recipe.

That means Case 01C needs the exact same env var list as Case 01A, just
supplied to `docker run` instead of the host shell:

```bash
docker run --rm \
  -e ANTHROPIC_BASE_URL="https://api.upstage.ai" \
  -e ANTHROPIC_AUTH_TOKEN="$UPSTAGE_API_KEY" \
  -e ANTHROPIC_MODEL="solar-open2" \
  -e ANTHROPIC_SMALL_FAST_MODEL="solar-open2" \
  -e ANTHROPIC_DEFAULT_HAIKU_MODEL="solar-open2" \
  -e ANTHROPIC_DEFAULT_SONNET_MODEL="solar-open2" \
  -e ANTHROPIC_DEFAULT_OPUS_MODEL="solar-open2" \
  -e ANTHROPIC_DEFAULT_FABLE_MODEL="solar-open2" \
  -e CLAUDE_CODE_SUBAGENT_MODEL="solar-open2" \
  ghcr.io/jyje/claude-docker claude -p "hello"
```

No fork, no patch, no image customization. `ghcr.io/jyje/claude-docker`
is used exactly as published — the same image anyone can `docker pull`
from its GitHub Container Registry listing.

### Installation

Requires Docker:

```bash
docker pull ghcr.io/jyje/claude-docker
```

This repo doesn't pin a tag, so `docker pull` always grabs whatever
`ghcr.io/jyje/claude-docker:latest` resolves to at verification time —
same policy as Case 01A/01B's unpinned CLI installs.

### Verified: containerized hello check

**Evidence run:** [browse every run](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml)
for the latest.

```bash
docker run --rm \
  -e ANTHROPIC_BASE_URL="https://api.upstage.ai" \
  -e ANTHROPIC_AUTH_TOKEN="$UPSTAGE_API_KEY" \
  -e ANTHROPIC_MODEL="solar-open2" \
  ghcr.io/jyje/claude-docker claude -p "hello"
```
> Hello! 👋 I'm Solar Open2, an AI assistant built by Upstage AI. I'm
> here to help you with coding tasks, research, analysis, and more.
> What can I help you with today?

This is what `scripts/verify.sh` calls **Method E**. Same backend, same
model, same `claude` binary as Case 01A — the only variable being
exercised here is the install path: a container instead of a bare
`npm install -g`. Confirms Case 01A's env var recipe isn't relying on
anything specific to a host npm install (a local config file, a cached
credential, etc.) — it survives an isolated, disposable container
unchanged.

---

## Verification

[`scripts/verify.sh`](scripts/verify.sh) runs all three sub-cases and the
skill/subagent checks in one pass: `claude-upstage doctor`, Case 01B's
piped-stdin check (Method A), Case 01A's hello check (Method B), the
explicit `git-commit-helper` skill invocation (Method C), a subagent
call gated on `CLAUDE_CODE_SUBAGENT_MODEL` (Method D), and Case 01C's
containerized hello check (Method E). It fails loudly if any of them
don't hold up.

The skill check doesn't pin exact wording, since the title text isn't
deterministic. Instead it checks the two structural things the skill's
format contract requires: a gitmoji (a non-ASCII byte) and a `(domain):`
segment.

The subagent check looks for `README.md` — a file that's always present
in this directory — in the subagent's report. That's a deterministic
proxy for "it actually ran against the real filesystem."

Run it locally with `UPSTAGE_API_KEY` set:

```bash
UPSTAGE_API_KEY="..." ./scripts/verify.sh
```

It also runs as a step in CI (manual dispatch, solar-open2 only):
[`.github/workflows/verify-all-sequential.yml`](../.github/workflows/verify-all-sequential.yml),
using the `UPSTAGE_API_KEY` repository secret.

## Solar Pro4

Upstage's Anthropic-compatible endpoint — the one Case 01A/B/C all talk
to directly — has no model mapping for `solar-pro4`: pointed there
directly, a client gets no response. [`docker/`](../docker/)'s
litellm-proxy bridges this by speaking Anthropic Messages on the
client-facing side and Chat Completions to Upstage underneath.

Locally re-verified 2026-08-03 (full log:
[`logs/local-verification/2026-08-03/case-01-solar-pro4.log`](../logs/local-verification/2026-08-03/case-01-solar-pro4.log)):
a raw `/v1/messages` request through the proxy, with the exact headers
Claude Code sends, returned a real `solar-pro4` response — confirming
the bridge works for this case's own protocol. (A direct `claude -p`
CLI invocation from inside a nested Claude Code dev session hit an
unrelated local credential-precedence artifact, not a proxy or model
issue — see the log for details; the Claude Agent SDK path in Case 03
isn't affected.)

See the repo-level [`PLAN.md`](../PLAN.md) for full context.
