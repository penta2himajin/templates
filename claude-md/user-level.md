# Common Development Rules

## Scope

This file is intended to be placed at `~/.claude/CLAUDE.md`. It applies to every project. Project-specific rules in each repo's `CLAUDE.md` may override or extend.

## TDD (Red → Green → Refactor)

All implementation work proceeds in this cycle:

1. **Red**: write a failing test that captures the intended behaviour.
2. **Green**: write the minimum code that makes the test pass.
3. **Refactor**: tidy up while keeping tests green.

When a test fails, fix the production code — do not delete, skip, or weaken the test.

## Git Conventions

- **Conventional Commits**: `feat:` `fix:` `docs:` `refactor:` `test:` `ci:` `chore:`. Project-specific prefixes (e.g. `data:`, `experiments:`) live in the project's `CLAUDE.md`.
- **Branch naming**: `claude/<topic>` for Claude-driven work.
- **Trailer**: append the standard form to commits Claude authors:

  ```
  Co-Authored-By: Claude <noreply@anthropic.com>
  ```

  Do not embed model name or session info in the trailer; put those in the commit body if needed.
- **Pre-push hook**: each consumer repo installs the hook from `templates/git-hooks/pre-push` (or its own equivalent) via `git config core.hooksPath git-hooks`. The hook runs format / lint / clippy before every push. Tests are intentionally omitted — TDD keeps them green at commit time.

## Pull Requests

- **Always ready for review.** Open PRs in the "ready" state, never as drafts. Draft PRs do not fire review-requested events and slow the loop.
- **Auto-subscribe after creating a PR.** Immediately after `create_pull_request` succeeds, call `subscribe_pr_activity` on the new PR without asking the user. Rationale: the user explicitly opted into the "Claude opens and watches its own PRs" workflow at the template level, so the per-PR confirmation is noise. Unsubscribe only when the user says to stop, when the PR merges, or when it is closed unmerged.
- **One PR per workstream**, matching the handoff issue. Reference the issue with `Closes #N` per `.github/PULL_REQUEST_TEMPLATE.md`.

## Stream Idle Timeout Mitigation

Claude Code cloud sessions occasionally fail with `Stream idle timeout - partial response received` on long output. To reduce risk:

1. **Stage long writes.** For long documents or source files, write the skeleton (headings, function signatures, trait stubs) first, then fill each section in follow-up edits. Avoid single blocks larger than ~200 lines.
2. **Watch out after large reads.** Reading a big file (e.g. `Cargo.lock`, large generated modules) and then immediately producing long output is a common trigger. Split into separate turns or excerpt only the relevant portion.
3. **Recover carefully.** A timeout can still leave the file write completed. Run `git status` before retrying so the same content is not written twice.

## Common Prohibitions

1. Do not delete, skip, or comment out existing tests.
2. Do not modify CI configuration without explicit instruction.
3. Do not weaken production code merely to make tests pass.
4. Do not commit credentials, API keys, signed URLs, or anything in `.env*`.
