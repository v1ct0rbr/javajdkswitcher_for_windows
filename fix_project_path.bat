@echo off
setlocal enabledelayedexpansion

Set-ExecutionPolicy RemoteSigned -Scope LocalMachine 
:: Configurações
set "arquivo=run_as_admin.bat"
set "diretorioAtual=%~dp0"
set "tmpfile=%arquivo%.tmp"


:: Remove barra final do diretório
if "%diretorioAtual:~-1%"=="\" set "diretorioAtual=%diretorioAtual:~0,-1%"

echo "diretórioAtual" = %diretorioAtual%
pause

echo Processando arquivo: %arquivo%
echo.

:: Verifica se o arquivo existe
if not exist "%arquivo%" (
    echo ERRO: Arquivo não encontrado
    pause
    exit /b 1
)
echo Arquivo encontrado: %arquivo%


:: Cria arquivo temporário vazio
break > "%tmpfile%"

:: Processa cada linha do arquivo
:: Processa cada linha do arquivo
for /f "tokens=*" %%A in ('type "%arquivo%"') do (
    set "linha=%%A"
    
    :: Verificação SEM FINDSTR (abordagem alternativa)
    set "linha_mod=!linha:set "localScriptDir=!"
    if "!linha_mod!" neq "!linha!" (
        echo set "localScriptDir=%diretorioAtual%" >> "%tmpfile%"
    ) else (
        echo %%A >> "%tmpfile%"
    )
)

echo Arquivo temporário criado: %tmpfile%
pause

:: Verifica se a substituição ocorreu
findstr /c:"set \"localScriptDir=%diretorioAtual%"" "%tmpfile%" >nul
if errorlevel 1 (
    echo ERRO: A substituicao não foi realizada
    pause
    exit /b 1
)

:: Substitui o arquivo original somente se o temporário estiver OK
move /Y "%tmpfile%" "%arquivo%" >nul
if errorlevel 1 (
    echo ERRO: Falha ao substituir o arquivo
    pause
    exit /b 1
)

echo ✅ Linha atualizada com sucesso:
echo set "localScriptDir=%diretorioAtual%"
echo.
echo Operacao concluida com sucesso!
pause