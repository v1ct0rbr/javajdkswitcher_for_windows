@echo off       
:: set /p localScriptDir="D:\programas\WinJavaSwitcher"       
set "localScriptDir=D:\programas\javajdkswitcher_for_windows" 
powershell -ExecutionPolicy Bypass -File "%localScriptDir%\winjavaswitcher.ps1" "%localScriptDir%" -NoExit        
:: Não fechar o console       
pause       
