# templates

## Purpose

Central repository for working conventions used across penta2himajin's projects. See `README.md` for layout and usage.

## Working rules for this repo

- Templates here are **descriptive**, not prescriptive. Consumers customise.
- When updating a template, consider impact on downstream repos (spurer / tsumugi / euhadra / mellonella). Note the impact in the commit message or related handoff issue.
- Use this repo's own `.github/ISSUE_TEMPLATE/handoff.md` for any multi-session work on the templates themselves (dogfood).
- No code in this repo. All files are text/markdown.

## Conventions inherited

This repo follows the conventions defined in its own `claude-md/user-level.md`:

- Conventional Commits (`docs:` and `chore:` are the most common prefixes here).
- Branch naming: `claude/<topic>` for Claude-driven edits.
- `Co-Authored-By: Claude <noreply@anthropic.com>` trailer on Claude-authored commits.
