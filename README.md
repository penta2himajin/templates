# templates

[日本語](./README.ja.md)

Central repository for working conventions and templates used across penta2himajin's repos.

## What this is

- **Audience**: claude.ai / Claude Code sessions working on penta2himajin's projects, plus the human author.
- **Role**: source of canonical text for `CLAUDE.md`, `.claude/rules/`, `.github/ISSUE_TEMPLATE/`, and PR templates.
- **License**: MIT — reuse freely.

Each template is a starting point. Consumer repos override as needed.

## Layout

| Path | Purpose |
|---|---|
| `.github/ISSUE_TEMPLATE/handoff.md` | Session-handoff issue template. Copy to consumer repos. Also active for this repo (dogfood). |
| `.github/PULL_REQUEST_TEMPLATE.md` | PR template requiring `Closes #N` linkage. |
| `claude-md/user-level.md` | Skeleton for `~/.claude/CLAUDE.md`. Common boilerplate (TDD, stream-timeout mitigation, commit conventions). |
| `claude-md/project-skeleton.md` | Skeleton for project-root `CLAUDE.md`. |
| `claude-rules/README.md` | When to use `.claude/rules/` vs `CLAUDE.md` vs skills. |
| `claude-rules/examples/` | Path-scoped rule examples. |
| `git-hooks/pre-push` | Shareable pre-push hook running format / lint / clippy. Install with `git config core.hooksPath git-hooks`. |
| `docs/handoff-protocol.md` | Detailed protocol for issue-based session handoff. |
| `docs/i18n-policy.md` | Suffix-file translation policy (`README.ja.md` next to `README.md`). |

## How to use

For a new repo:

1. Copy `claude-md/project-skeleton.md` to the repo root as `CLAUDE.md` and fill in the placeholders.
2. Copy `.github/ISSUE_TEMPLATE/handoff.md` and `.github/PULL_REQUEST_TEMPLATE.md` verbatim.
3. Optionally pull `claude-rules/examples/*` into `.claude/rules/` and adjust globs.
4. Copy `git-hooks/pre-push` into a `git-hooks/` directory in the consumer repo and run `git config core.hooksPath git-hooks`.
5. If a Japanese audience is in scope, follow `docs/i18n-policy.md` to add `README.ja.md`.

For an existing repo:

- Adopt incrementally. Diff-merge against the existing `CLAUDE.md` rather than replacing wholesale.

## SSOT precedence

When templates here and consumer-repo files diverge, the consumer wins. Templates are descriptive, not authoritative. See `docs/handoff-protocol.md` for the full precedence rule.

## License

MIT. See `LICENSE`.
