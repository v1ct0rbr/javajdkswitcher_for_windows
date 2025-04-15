@echo off

:: set /p localScriptDir="D:\programas\WinJavaSwitcher"
set "localScriptDir=D:\programas\WinJavaSwitcher"

powershell -ExecutionPolicy Bypass -File "%localScriptDir%\winjavaswitcher.ps1" "%localScriptDir%" -NoExit 

:: Não fechar o console

pause