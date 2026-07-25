<!-- slidev:enable-auto-animate -->
# Future Directions

## What's next for Solar Open 2 × agent harnesses

<v-click>

### Immediate

- **Python 3.14 support** — track `tokenizers` `cp314` wheel availability;
  move Cases 03 and 04 back to 3.14 once it ships
- **OpenWiki streaming fix upstream** — `OPENWIKI_DISABLE_STREAMING` is
  currently in a `jyje/openwiki` fork; getting it merged into `langchain-ai/openwiki`
  would unblock the public npm release
- **Upstage streaming bug resolution** — the `function.name = ""` bug affects
  Cases 05 and 06; getting it fixed upstream unblocks tool-calling for the
  entire ecosystem

</v-click>

<v-click>

### Near-term

- **Case 08+** — new harness integrations (more Kubernetes operators, more
  LangChain ecosystem tools, more IDE integrations)
- **Telegram/Discord for Case 07** — messenger integration on top of the
  verified Helm deployment (currently documented but not gated)
- **Rate-limit-aware verification** — Case 05's Finding 3 (50K tokens/min
  ceiling) could be addressed with batched/parallel verification strategies

</v-click>

<v-click>

### Ecosystem growth

- **More agent frameworks** — AutoGen, CrewAI, LlamaIndex, SWE-agent
- **More deployment targets** — EKS, GKE, cloud-managed Kubernetes
- **More model variants** — `solar-pro3`, future Solar Open releases
- **Community contributions** — every case is designed to be independently
  reproducible, extendable, and verifiable by anyone with an Upstage API key

</v-click>

<v-click>

### The bigger picture

This pilot started with a single question:

> *Can Upstage's Solar Open 2 model run through real, production-grade agent
> harnesses — not just a raw API call?*

Seven cases later, the answer is **yes** — across Claude Code, Hermes Agent,
Claude Agent SDK, LangChain, OpenWiki, Grok Build, and Kubernetes/Helm.
The remaining work is scaling that answer to more harnesses, more models,
and more operators.

</v-click>

<!--
The future directions slide is intentionally forward-looking but grounded in
the specific blockers and next steps identified during the pilot. Each item
ties back to a finding or gap from an existing case, not a vague roadmap.
-->
