#!/bin/bash

# Finder 启动时可能没有 Homebrew 的路径。
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

cd "$(dirname "$0")" || {
  echo "无法进入项目目录，请检查文件位置。"
  read -r -p "按回车键关闭窗口..." _
  exit 1
}

if ! command -v node >/dev/null 2>&1; then
  echo "未找到 Node.js。请自行安装 Node.js，安装后重新运行此脚本。"
elif ! command -v pnpm >/dev/null 2>&1; then
  echo "未找到 pnpm。请自行安装或启用 pnpm，安装后重新运行此脚本。"
elif [ ! -x node_modules/.bin/vite ]; then
  echo "未找到项目依赖。请在项目目录中运行 pnpm install，然后重新运行此脚本。"
else
  echo "正在启动开发服务器。关闭此窗口可停止服务。"
  pnpm run dev
  status=$?
  if [ "$status" -eq 0 ]; then
    exit 0
  fi
  echo "开发服务器已退出，退出码：$status"
fi

read -r -p "按回车键关闭窗口..." _
exit 1
