#!/bin/bash

# 部署到 GitHub Pages 的腳本

set -e  # 遇到錯誤時停止執行

echo "🚀 開始部署到 GitHub Pages..."

# 1. 建置專案
echo "📦 正在建置專案..."
npm run build

# 2. 儲存當前分支
CURRENT_BRANCH=$(git branch --show-current)
echo "💾 當前分支: $CURRENT_BRANCH"

# 3. 切換到 gh-pages 分支
echo "🔀 切換到 gh-pages 分支..."
git checkout gh-pages

# 4. 清空當前內容（保留 .git）
echo "🧹 清理舊的部署檔案..."
git rm -rf . 2>/dev/null || true
git clean -fxd -e .git

# 5. 複製 dist 目錄的內容到根目錄
echo "📁 複製建置產物..."
cp -r dist/* .

# 6. 提交變更
echo "💾 提交變更..."
git add .
git commit -m "deploy: 更新 GitHub Pages $(date '+%Y-%m-%d %H:%M:%S')"

# 7. 推送到遠端
echo "⬆️  推送到 GitHub..."
git push origin gh-pages

# 8. 切換回原本的分支
echo "🔙 切換回 $CURRENT_BRANCH 分支..."
git checkout "$CURRENT_BRANCH"

echo "✅ 部署完成！"
echo "🌐 網站網址: https://jiahongl.github.io/prompt-packs/"
