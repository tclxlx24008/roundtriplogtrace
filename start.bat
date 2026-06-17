@echo off
chcp 65001 >nul
echo ===================================
echo 往返辅助排查系统 - 启动脚本
echo ===================================
echo.

REM 检查Node.js是否安装
node --version >nul 2>&1
if %errorlevel% == 0 (
    echo 检测到Node.js已安装
    echo.
    
    REM 检查依赖是否安装
    if not exist "node_modules\" (
        echo 正在安装依赖...
        call npm install
        echo.
    )
    
    echo 正在启动服务器...
    echo.
    echo 服务器地址: http://localhost:3000
    echo 请在浏览器中打开上述地址
    echo.
    echo 按Ctrl+C停止服务器
    echo.
    node server.js
    goto :end
)

echo.
echo 错误: 未检测到Node.js
echo 请安装Node.js: https://nodejs.org/
echo.
pause

:end
