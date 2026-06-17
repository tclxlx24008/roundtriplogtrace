# 往返辅助排查系统 - PowerShell启动脚本

Write-Host "===================================" -ForegroundColor Cyan
Write-Host "往返辅助排查系统 - 启动脚本" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# 检查Node.js是否安装
try {
    $nodeVersion = node --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "检测到Node.js已安装: $nodeVersion" -ForegroundColor Green
        Write-Host ""
        
        # 检查依赖是否安装
        if (-not (Test-Path "node_modules\")) {
            Write-Host "正在安装依赖..." -ForegroundColor Yellow
            npm install
            Write-Host ""
        }
        
        Write-Host "正在启动服务器..." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "服务器地址: http://localhost:3000" -ForegroundColor Cyan
        Write-Host "请在浏览器中打开上述地址" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "按Ctrl+C停止服务器" -ForegroundColor Gray
        Write-Host ""
        node server.js
        exit
    }
} catch {}

# 如果没有安装Node.js
Write-Host "错误: 未检测到Node.js" -ForegroundColor Red
Write-Host "请安装Node.js: https://nodejs.org/" -ForegroundColor Yellow
Write-Host ""
pause
