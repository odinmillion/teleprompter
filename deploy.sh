#!/usr/bin/env bash
# Публикует проект в новый публичный репозиторий GitHub и включает GitHub Pages.
# Требует установленный и авторизованный gh (brew install gh && gh auth login).
set -euo pipefail

REPO="${1:-teleprompter}"

if ! command -v gh >/dev/null; then
  echo "Нужен GitHub CLI: brew install gh && gh auth login" >&2
  exit 1
fi

if [ ! -d .git ]; then
  git init -b main
  git add .
  git commit -m "Телесуфлер: первая версия"
fi

gh repo create "$REPO" --public --source=. --remote=origin --push

OWNER="$(gh api user -q .login)"
gh api -X POST "repos/$OWNER/$REPO/pages" \
  -f build_type=legacy \
  -f "source[branch]=main" \
  -f "source[path]=/" >/dev/null

echo
echo "Готово. Через минуту страница будет доступна по адресу:"
echo "https://$OWNER.github.io/$REPO/"
