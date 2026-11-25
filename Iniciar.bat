@echo off
chcp 65001 >nul
title Website Downloader
cd /d "%~dp0"
set PORT=3010

where node >nul 2>nul
if errorlevel 1 (
  echo Node.js nao encontrado. Instale em https://nodejs.org e tente de novo.
  pause & exit /b 1
)

rem wget real: o instalador do winget as vezes nao atualiza o PATH desta janela
where wget.exe >nul 2>nul
if errorlevel 1 (
  for /d %%D in ("%LOCALAPPDATA%\Microsoft\WinGet\Packages\JernejSimoncic.Wget*") do set "PATH=%%D;%PATH%"
)
where wget.exe >nul 2>nul
if errorlevel 1 (
  echo wget nao encontrado. Instale com: winget install JernejSimoncic.Wget
  pause & exit /b 1
)

if not exist node_modules (
  echo Instalando dependencias, so na primeira vez...
  call npm install
)

rem Se ja estiver rodando, so abre o navegador
netstat -ano | findstr /r /c:":%PORT% .*LISTENING" >nul
if not errorlevel 1 (
  echo Ja esta rodando. Abrindo o navegador...
  start "" http://localhost:%PORT%
  exit /b 0
)

echo.
echo  Website Downloader em http://localhost:%PORT%
echo  Feche esta janela para parar o servidor.
echo.
start "" http://localhost:%PORT%
call npm start
pause
