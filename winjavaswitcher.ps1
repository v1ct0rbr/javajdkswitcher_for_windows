# Script para alternar entre diferentes JDKs no Windows
# Autor: Victor Queiroga
# Data: 2025-04-15
# Licença: MIT
$currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
$admin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $admin) {
    Write-Host "Atencao: Este script precisa ser executado como Administrador. Fechando..."
    Write-Host "Para executar como Administrador, clique com o botao direito no arquivo e selecione 'Executar como administrador'."
    exit
}

$PSScriptRoot = $args[0]
# Caminho do arquivo de propriedades
$arquivoPropriedades = "$PSScriptRoot\jdk.properties"

if (-Not (Test-Path $arquivoPropriedades)) {
    Write-Error "Erro - Arquivo de propriedades nao encontrado: $arquivoPropriedades"
    exit 1
}

# Lê o arquivo e cria um mapa dos JDKs
function Carregar-JDKs {
    $mapa = @{}
    Get-Content $arquivoPropriedades | ForEach-Object {
        if ($_ -match "^\s*([^#][^=]+?)\s*=\s*(.+)$") {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim() -replace '[`"\uFEFF\u200B]', ''
            $mapa[$key] = $value
        }
    }
    return $mapa
}

# Atualiza JAVA_HOME e PATH
function Atualizar-Java($javaPath) {
    $javaBin = Join-Path $javaPath "bin"

    if (-Not (Test-Path $javaBin)) {
        Write-Error "Erro: Caminho invalido: $javaBin"
        return
    }

    try {
        [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaPath, "Machine")

        $pathAtual = [Environment]::GetEnvironmentVariable("Path", "Machine")
        $pathNovo = $pathAtual -split ";" | Where-Object { $_ -notmatch "jdk" -and $_.Trim() -ne "" }
        $novoPath = "$javaBin;" + ($pathNovo -join ";")
        [Environment]::SetEnvironmentVariable("Path", $novoPath, "Machine")

        Write-Host "`nSucesso JAVA_HOME e PATH atualizados para: $javaPath"
        & "$javaBin\java.exe" -version
    }
    catch {
        Write-Error "Erro: Execute este script como Administrador."
    }
}

# Loop de menu
do {
    $jdks = Carregar-JDKs

    if ($jdks.Count -eq 0) {
        Write-Error "Nenhuma JDK encontrada no arquivo de propriedades."
        break
    }
    Write-Host "`n==============================================`n"

    Write-Host "`nSelecione a versao do Java para ativar:`n"
    $opcoes = @()
    $index = 1

    $jdks.GetEnumerator() | Sort-Object Key | ForEach-Object {
        Write-Host "$index - $($_.Key) => $($_.Value)"
        $opcoes += @{ Key = $_.Key; Caminho = $_.Value }
        $index++
    }

    Write-Host "0 - Sair"

    $escolha = Read-Host "`nDigite o numero da versao desejada"

    Write-Host "`n==============================================`n"
    if ($escolha -eq '0') {
        Write-Host "`nSaindo..."
        break
    }

    if ($escolha -notmatch '^\d+$' -or [int]$escolha -lt 1 -or [int]$escolha -gt $opcoes.Count) {
        Write-Error "Erro: Escolha invalida."
        continue
    }

    $selecionado = $opcoes[[int]$escolha - 1]
    Atualizar-Java $selecionado.Caminho

    Write-Host "`nVoltando ao menu..."
} while ($true)
