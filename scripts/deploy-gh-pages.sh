#!/bin/bash

# 部署到 GitHub Pages 的腳本

set -e  # 遇到錯誤時停止執行

echo "🚀 開始部署到 GitHub Pages..."

# 1. 儲存當前分支
CURRENT_BRANCH=$(git branch --show-current)
echo "💾 當前分支: $CURRENT_BRANCH"

# 2. 建置專案
echo "📦 正在建置專案..."
npm run build

# 3. 將 dist 目錄複製到臨時目錄
echo "📦 備份建置產物..."
TEMP_DIR=$(mktemp -d)
cp -r dist/* "$TEMP_DIR/"

# 4. 切換到 gh-pages 分支
echo "🔀 切換到 gh-pages 分支..."
git checkout gh-pages

# 5. 清空當前內容（保留 .git）
echo "🧹 清理舊的部署檔案..."
git rm -rf . 2>/dev/null || true
git clean -fxd -e .git

# 6. 複製臨時目錄的內容到根目錄
echo "📁 複製建置產物..."
cp -r "$TEMP_DIR"/* .

# 7. 清理臨時目錄
rm -rf "$TEMP_DIR"

# 8. 提交變更
echo "💾 提交變更..."
git add .
git commit -m "deploy: 更新 GitHub Pages $(date '+%Y-%m-%d %H:%M:%S')"

# 9. 推送到遠端
echo "⬆️  推送到 GitHub..."
git push origin gh-pages

# 10. 切換回原本的分支
echo "🔙 切換回 $CURRENT_BRANCH 分支..."
git checkout "$CURRENT_BRANCH"

echo "✅ 部署完成！"
echo "🌐 網站網址: https://jiahongl.github.io/prompt-packs/"
