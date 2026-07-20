---
name: writing-skills
description: Create, revise, and validate concise Codex skills with reliable triggering and proportional behavioral tests. Use when adding or updating a SKILL.md or its reusable scripts, references, assets, and interface metadata.
---

# Writing Skills

## Purpose

Create a small, discoverable skill that teaches Codex only the non-obvious workflow or domain knowledge needed for repeated tasks.

## 1. Define concrete use

Identify:

- example user requests that should trigger the skill;
- similar requests that should not trigger it;
- the recurring failure, uncertainty, or repeated implementation work the skill should solve;
- whether scripts, references, or assets would be reused.

Do not create a skill for one repository convention that belongs in `AGENTS.md`.

## 2. Design for progressive disclosure

Use:

```text
skill-name/
├── SKILL.md
├── agents/openai.yaml        # recommended UI metadata
├── scripts/                  # deterministic reusable operations
├── references/               # detailed knowledge loaded when needed
└── assets/                   # templates or output resources
```

Create only directories that add value. Keep `SKILL.md` under 500 lines and move detailed material to directly linked references.

## 3. Write reliable metadata

Frontmatter contains only:

```yaml
---
name: lower-case-hyphen-name
description: What the skill does. Use when Codex needs it for specific triggers and contexts.
---
```

Requirements:

- match the folder name;
- use lowercase letters, digits, and hyphens;
- include both capability and triggering context in the description;
- include all important triggers in the description because the body loads only after selection.

## 4. Write the workflow

- Use imperative instructions.
- Assume Codex already knows general software engineering.
- Match specificity to risk: flexible guidance for judgment, scripts for fragile repeatable operations.
- State entry conditions, stop conditions, verification, and safe fallbacks.
- Reference bundled resources with the exact condition for reading or running them.
- Avoid duplicated explanations, slogans, invented metrics, and unrelated deployment instructions.

## 5. Validate proportionally

Always run structural validation:

```bash
python <skill-creator>/scripts/quick_validate.py <skill-folder>
```

Test bundled scripts by executing representative cases.

For behavior-shaping skills, use realistic forward tests when the change is consequential:

- compare representative requests with and without the revised guidance when a baseline is available;
- use fresh context and raw artifacts;
- test positive triggers, negative triggers, and at least one failure boundary;
- do not disclose the expected answer to the evaluator;
- record observed behavior rather than self-awarded scores.

Do not require expensive multi-agent evaluation for a typo, metadata correction, or other low-risk edit. Increase evaluation depth with behavioral risk.

## 6. Review before delivery

Check:

- frontmatter and folder names are valid;
- the description selects the skill at the right times;
- `SKILL.md` is concise and references are discoverable;
- scripts are deterministic and tested;
- no placeholders or unused resources remain;
- interface metadata still matches the skill;
- no installation, commit, push, or external-service action occurs without user intent.

Report files changed, validation commands, results, and remaining behavioral risk.
