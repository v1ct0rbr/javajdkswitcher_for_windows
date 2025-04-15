# Caminho do arquivo de propriedades
#Set-Location "D:\programas\WinJavaSwitcher"

$arquivoPropriedades = ".\jdk.properties"

if (-Not (Test-Path $arquivoPropriedades)) {
    Write-Error "Erro: Arquivo de propriedades nao encontrado: $arquivoPropriedades"
   
}

# Lê o arquivo e cria um mapa dos JDKs, limpando os caminhos
$mapaJDKs = @{}
Get-Content $arquivoPropriedades | ForEach-Object {
    if ($_ -match "^\s*([^#][^=]+?)\s*=\s*(.+)$") {
        $key = $matches[1].Trim()
        $value = $matches[2].Trim() -replace '[`"\uFEFF\u200B]', ''
        $mapaJDKs[$key] = $value
    }
}


if ($mapaJDKs.Count -eq 0) {
    Write-Error "Erro: Nenhuma versao encontrada no arquivo de propriedades."
   
}

Write-Host "`nSelecione a versao do Java para ativar:`n"

# Mostra menu corretamente
$opcoes = @()
$index = 1
$mapaJDKs.GetEnumerator() | Sort-Object Key | ForEach-Object {
    Write-Host "$index - $($_.Key) => $($_.Value)"
    $opcoes += @{ Key = $_.Key; Caminho = $_.Value }
    $index++
}

# Coleta entrada
$escolha = Read-Host "`nDigite o numero da versao desejada"
if ($escolha -notmatch '^\d+$' -or [int]$escolha -lt 1 -or [int]$escolha -gt $opcoes.Count) {
    Write-Error "Erro: Escolha invalida."
   
}

$selecionado = $opcoes[[int]$escolha - 1]
$novoJava = $selecionado.Caminho
$novoJavaBin = Join-Path $novoJava "bin"

if (-Not (Test-Path $novoJavaBin)) {
    Write-Error "Erro: Caminho invalido para bin: $novoJavaBin"
    
}

# Verifica se tem permissão para alterar o registro
try {
    [Environment]::SetEnvironmentVariable("JAVA_HOME", $novoJava, "Machine")
    $pathAtual = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $pathNovo = $pathAtual -split ";" | Where-Object { $_ -notmatch "jdk" -and $_.Trim() -ne "" }
    $novoPath = "$novoJavaBin;" + ($pathNovo -join ";")
    [Environment]::SetEnvironmentVariable("Path", $novoPath, "Machine")

    Write-Host "`nSucesso: JAVA_HOME e PATH atualizados para $($selecionado.Key)"
    & "$novoJavaBin\java.exe" -version
}
catch {
    Write-Error "Erro: Falha ao aplicar as alteracoes. Execute este script como **Administrador**."
    
}

Read-Host -Prompt "Press Enter to exit"