# Script para alterar a política de execução do PowerShell para permitir a execução de scripts
# e scripts baixados da internet, mas requerendo assinatura digital.
# Devem ser executados no powershell com privilégios de administrador.
# Para executar o script, abra o PowerShell como administrador e execute o seguinte comando:
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine 

# Desfazer a mudança
#Set-ExecutionPolicy Restricted -Scope LocalMachine


