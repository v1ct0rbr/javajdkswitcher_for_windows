# WinJavaSwitcher

WinJavaSwitcher é um script para alternar rapidamente entre diferentes versões do Java em ambientes Windows. Ele foi projetado para desenvolvedores que precisam trabalhar com múltiplas versões do Java em seus projetos.

## Recursos

- Alternância rápida entre versões do Java como um menu interativo.
- Configuração simples e fácil de usar.
- Compatível com Windows.

## Pré-requisitos

- Sistema operacional Windows.
- Instalações prévias das versões do Java que deseja alternar.



## Instalação

1. Clone este repositório:
    ```bash
    git clone https://github.com/v1ct0rbr/WinJavaSwitcher.git
    ```
2. Navegue até o diretório do script:
    ```bash
    cd WinJavaSwitcher
    ```
3. Renomeie ou copie o arquivo jdk.example.properties para jdk.properties
4. Insira todos os caminhos das jdk's que você tiver disponível em sua máquina (siga o padrao do arquivo)

## Uso

1. Rode primeiramente o script para encontrar a localização do projeto.
    ```base
    fix_project_path.bat
    ```
2. Execute o script como administrador:
    ```bash
    run_as_admin.bat
    ```
3. Escolha a versão do Java que deseja usar no menu interativo.
4. O script ajustará automaticamente as variáveis de ambiente para a versão selecionada.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Autor

Desenvolvido por Victor Queiroga.
