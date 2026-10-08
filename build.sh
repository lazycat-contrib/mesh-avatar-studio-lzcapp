#!/usr/bin/env bash
# Mesh Avatar Studio 静态站构建：克隆上游 → npm ci + vite build → site/
set -euo pipefail

VERSION="${LAZYCAT_VERSION:-${VERSION:-}}"
echo "==> building mesh-avatar-studio version: ${VERSION:-<default branch>}"

rm -rf .upstream dist site
if [ -n "$VERSION" ]; then
  if ! git clone --depth 1 --branch "$VERSION" https://github.com/shinshin86/mesh-avatar-studio.git .upstream 2>/dev/null; then
    echo "==> tag $VERSION not found, falling back to default branch"
    git clone --depth 1 https://github.com/shinshin86/mesh-avatar-studio.git .upstream
  fi
else
  git clone --depth 1 https://github.com/shinshin86/mesh-avatar-studio.git .upstream
fi

cd .upstream
npm ci
npm run build
cd ..
cp -r .upstream/dist site
echo "==> site built: $(du -sh site | cut -f1)"
