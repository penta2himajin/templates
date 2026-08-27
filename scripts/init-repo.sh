#!/usr/bin/env bash
# Create a sibling git repo from this templates tree (copy mode B).
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: init-repo.sh <repo-name>

Creates ../<repo-name>/ from this templates repository:
  - copies tree excluding .git/ and scripts/
  - installs AGENTS-project-skeleton.md as AGENTS.md
  - writes a minimal README.md for the new project
  - ensures CLAUDE.md / .claude/rules / claude-rules symlinks
  - runs git init -b main, sets core.hooksPath, creates Initial commit

Example:
  ./scripts/init-repo.sh my-app
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -ne 1 ]]; then
  usage >&2
  exit 2
fi

REPO_NAME="$1"

if [[ ! "$REPO_NAME" =~ ^[A-Za-z0-9._-]+$ ]]; then
  echo "error: invalid repo name '$REPO_NAME' (use letters, digits, . _ - only)" >&2
  exit 2
fi
if [[ "$REPO_NAME" == "." || "$REPO_NAME" == ".." ]]; then
  echo "error: repo name must not be '.' or '..'" >&2
  exit 2
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PARENT_DIR="$(cd "$TEMPLATES_ROOT/.." && pwd)"
TARGET="$PARENT_DIR/$REPO_NAME"

if [[ -e "$TARGET" ]]; then
  echo "error: target already exists: $TARGET" >&2
  exit 1
fi

if ! command -v rsync >/dev/null 2>&1; then
  echo "error: rsync is required" >&2
  exit 1
fi
if ! command -v git >/dev/null 2>&1; then
  echo "error: git is required" >&2
  exit 1
fi

mkdir -p "$TARGET"

rsync -a \
  --exclude '.git/' \
  --exclude 'scripts/' \
  "$TEMPLATES_ROOT/" "$TARGET/"

# Mode B: project AGENTS from skeleton (drop the skeleton file itself).
if [[ ! -f "$TARGET/AGENTS-project-skeleton.md" ]]; then
  echo "error: AGENTS-project-skeleton.md missing after copy" >&2
  exit 1
fi
mv "$TARGET/AGENTS-project-skeleton.md" "$TARGET/AGENTS.md"

# Replace templates README with a minimal project README.
cat >"$TARGET/README.md" <<EOF
# ${REPO_NAME}

<!-- One-paragraph description of this project. -->

## Setup

\`\`\`bash
git config core.hooksPath git-hooks
\`\`\`

Fill in \`AGENTS.md\` placeholders, then start building.

## License

MIT. See \`LICENSE\`.
EOF

# templates-specific Japanese README should not ship to consumers.
rm -f "$TARGET/README.ja.md"

# Compatibility symlinks (recreate so they always point correctly).
ln -sfn AGENTS.md "$TARGET/CLAUDE.md"
mkdir -p "$TARGET/.claude"
ln -sfn ../.rules "$TARGET/.claude/rules"
ln -sfn .rules "$TARGET/claude-rules"

cd "$TARGET"
git init -b main >/dev/null
git config core.hooksPath git-hooks
git add -A
git commit -m "$(cat <<EOF
chore: initial commit from templates

Scaffolded from penta2himajin/templates via scripts/init-repo.sh.
EOF
)" >/dev/null

echo "created: $TARGET"
echo "branch:  $(git -C "$TARGET" branch --show-current)"
echo "hooks:   core.hooksPath=$(git -C "$TARGET" config --get core.hooksPath)"
echo "commit:  $(git -C "$TARGET" rev-parse --short HEAD)"
