# <Project Name>

## Overview

<!-- One to three paragraphs describing the project's purpose, target domain, and distinguishing characteristics. If detailed specs live under docs/, reference them with @docs/<file>.md. -->

## Project Structure

<!-- Directory layout with the role of each. Make explicit the boundary between source code, documentation, and generated artifacts. -->

```
src/         # ...
docs/        # ...
tests/       # ...
```

## Development Setup

<!-- Required toolchain pins, bootstrap commands, external dependencies (DB, MCP servers). Skip if ~/.claude/CLAUDE.md alone suffices. -->

```bash
# example
cargo install ...
```

## Build & Test

<!-- Canonical verification commands. Must be runnable without prior setup so Claude can self-verify. -->

```bash
cargo build --workspace
cargo test  --workspace
```

## Development Principles

<!-- Project-specific additions only. Do not restate ~/.claude/CLAUDE.md (TDD, etc.). Examples:
- "All features touching target-adjacent columns must be registered in LEAK_FEATURES."
- "Public API changes require an ADR in docs/decisions/." -->

## Architectural Boundaries

<!-- Structural invariants that, if violated, break the design. Examples:
- "core crate stays domain-agnostic."
- "Generated code under gen/ is never hand-edited."
- "Layer X must not depend on layer Y." -->

## Prohibitions

<!-- Numbered list of "do not" rules, written so each is verifiable. Do not duplicate the common prohibitions in ~/.claude/CLAUDE.md. -->

1. ...
2. ...

## Git Conventions

<!-- Differences from ~/.claude/CLAUDE.md only. Examples: scoped Conventional Commits like `feat(phase1d):`, mandatory issue links in PR bodies. -->

## Session Handoff

Long-running workstreams use GitHub issues for cross-session continuity. See [`templates/docs/handoff-protocol.md`](https://github.com/penta2himajin/templates/blob/main/docs/handoff-protocol.md) for the full protocol.

- Label: `session-handoff`
- One issue per workstream (not per session)
- On session start, read the relevant handoff issue and confirm the **Next action** with the user before executing.
