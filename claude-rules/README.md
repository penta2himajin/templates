# `.claude/rules/`

`.claude/rules/` holds **path-scoped rules**: instructions injected into Claude's context only when files matching their `globs` are read.

## When to use which mechanism

| Mechanism | Contains | Loaded |
|---|---|---|
| `CLAUDE.md` | project-wide invariants | every session start |
| `.claude/skills/` | occasional workflows | when Claude judges relevant |
| `.claude/rules/` | path-bound constraints | when matching paths are touched |

When `CLAUDE.md` grows large, carve path-specific rules out into `.claude/rules/*.md`. Rules consume context only when the relevant code is read, keeping the always-loaded surface small.

## File format

Each rule starts with frontmatter declaring scope:

```markdown
---
description: <short summary, single line>
globs:
  - "**/<path-glob>/**"
---

(body)
```

## Examples

See `examples/`.
