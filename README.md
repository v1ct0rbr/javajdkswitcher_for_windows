# WinJavaSwitcher

WinJavaSwitcher é um script para alternar rapidamente entre diferentes versões do Java em ambientes Windows. Ele foi projetado para desenvolvedores que precisam trabalhar com múltiplas versões do Java em seus projetos.

## Recursos

- Alternância rápida entre versões do Java.
- Configuração simples e fácil de usar.
- Compatível com Windows.

## Pré-requisitos

- Sistema operacional Windows.
- Instalações prévias das versões do Java que deseja alternar.
- Crie vários arquivos baseados no arquivo winjavaswitcher.ps1
- cada arquivo deve possuir seu caminho para a versão do jdk desejado



## Instalação

1. Clone este repositório:
    ```bash
    git clone https://github.com/seu-usuario/WinJavaSwitcher.git
    ```
2. Navegue até o diretório do script:
    ```bash
    cd WinJavaSwitcher
    ```
3. Certifique-se de que o script está configurado corretamente para as versões do Java instaladas.

## Uso

1. Rode primeiramente o arquivo pre_scripts.bat para dar permissão necessária a execução dos demais scripts.
2. Execute o script no terminal (Deve apontar para a JDK previamente):
    ```bash
    WinJavaSwitcher.bat
    ```
3. Escolha a versão do Java que deseja usar no menu interativo.
4. O script ajustará automaticamente as variáveis de ambiente para a versão selecionada.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Autor

Desenvolvido por [Seu Nome].
