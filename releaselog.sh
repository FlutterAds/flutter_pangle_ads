#!/bin/bash

# 确定要提取的版本号
VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

echo "Extracting release notes for version $VERSION"

# 调试输出：显示 CHANGELOG.md 的内容
echo "=== CHANGELOG.md content ==="
cat CHANGELOG.md
echo "=== End of CHANGELOG.md content ==="

# 从 CHANGELOG.md 中提取对应版本的变更日志
CHANGELOG=$(sed -n "/## $VERSION/,/^## /p" CHANGELOG.md | sed '$d' | tail -n +2)

if [ -z "$CHANGELOG" ]; then
  echo "Version $VERSION not found in CHANGELOG.md"
  exit 1
fi

echo "Release notes for version $VERSION:"
echo "$CHANGELOG"
