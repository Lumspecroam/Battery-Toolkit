#!/bin/bash
#
# Battery Toolkit (中文汉化版) 安装脚本
# 用法: bash install.sh
#
# 此脚本会:
# 1. 将 Battery Toolkit.app 复制到 /Applications/
# 2. 将 daemon 安装为系统级 launchd 服务
# 3. 加载 daemon
#
# 需要管理员密码 (sudo)

set -e

APP_NAME="Battery Toolkit"
APP_BUNDLE="Battery Toolkit.app"
DAEMON_ID="me.mhaeuser.batterytoolkitd"
DAEMON_MACH="EMH49F8A2Y.me.mhaeuser.batterytoolkitd"
INSTALL_DIR="/Applications"
LAUNCHD_PLIST="/Library/LaunchDaemons/${DAEMON_ID}.plist"

# 确定脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 查找 app bundle
if [ -d "${SCRIPT_DIR}/${APP_BUNDLE}" ]; then
    APP_SRC="${SCRIPT_DIR}/${APP_BUNDLE}"
elif [ -d "${SCRIPT_DIR}/dist/${APP_BUNDLE}" ]; then
    APP_SRC="${SCRIPT_DIR}/dist/${APP_BUNDLE}"
else
    echo "错误: 未找到 ${APP_BUNDLE}"
    echo "请确保 app 与此脚本在同一目录"
    exit 1
fi

echo "=== Battery Toolkit 汉化版安装 ==="
echo "App 路径: ${APP_SRC}"
echo ""

# 检查 sudo 权限
if [ "$EUID" -ne 0 ]; then
    echo "需要管理员权限，将提示输入密码..."
    sudo -v
fi

# 停止现有 app 和 daemon
echo ">>> 停止现有进程..."
pkill -f "Battery Toolkit" 2>/dev/null || true
sleep 1

# 注销旧的 SMAppService daemon
echo ">>> 注销旧 daemon 注册..."
sudo launchctl bootout system/${DAEMON_ID} 2>/dev/null || true
sleep 1

# 复制 app 到 /Applications
echo ">>> 复制 app 到 ${INSTALL_DIR}/..."
sudo rm -rf "${INSTALL_DIR}/${APP_BUNDLE}"
cp -R "${APP_SRC}" "${INSTALL_DIR}/${APP_BUNDLE}"
echo "    已复制"

# 创建 launchd plist
echo ">>> 创建 launchd 配置..."
cat > /tmp/${DAEMON_ID}.plist << PLISTEOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>${DAEMON_ID}</string>
	<key>ProgramArguments</key>
	<array>
		<string>${INSTALL_DIR}/${APP_BUNDLE}/Contents/Library/LaunchServices/${DAEMON_ID}</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>KeepAlive</key>
	<dict>
		<key>SuccessfulExit</key>
		<false/>
	</dict>
	<key>EnableTransactions</key>
	<false/>
	<key>MachServices</key>
	<dict>
		<key>${DAEMON_MACH}</key>
		<true/>
	</dict>
</dict>
</plist>
PLISTEOF

sudo cp /tmp/${DAEMON_ID}.plist "${LAUNCHD_PLIST}"
sudo chown root:wheel "${LAUNCHD_PLIST}"
sudo chmod 644 "${LAUNCHD_PLIST}"
rm -f /tmp/${DAEMON_ID}.plist
echo "    已创建: ${LAUNCHD_PLIST}"

# 加载 daemon
echo ">>> 加载 daemon..."
sudo launchctl load "${LAUNCHD_PLIST}" 2>/dev/null || true
sleep 2

# 检查 daemon 状态
echo ">>> 检查 daemon 状态..."
if pgrep -f "${DAEMON_ID}" > /dev/null; then
    echo "    daemon 已启动 ✓"
else
    echo "    警告: daemon 未启动，请检查日志"
fi

# 启动 app
echo ">>> 启动 Battery Toolkit..."
open "${INSTALL_DIR}/${APP_BUNDLE}"
sleep 3

# 检查 app 状态
if pgrep -f "Battery Toolkit" > /dev/null; then
    echo "    app 已启动 ✓"
else
    echo "    警告: app 未启动"
fi

echo ""
echo "=== 安装完成 ==="
echo "Battery Toolkit 已安装到 ${INSTALL_DIR}/"
echo "daemon 已注册为系统服务 (开机自动启动)"
echo ""
echo "如需卸载:"
echo "  sudo launchctl unload ${LAUNCHD_PLIST}"
echo "  sudo rm ${LAUNCHD_PLIST}"
echo "  sudo rm -rf \"${INSTALL_DIR}/${APP_BUNDLE}\""
