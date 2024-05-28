# List App - Aplicativo Flutter

Este é um aplicativo simples de listas desenvolvido em Flutter como parte de um teste de . O aplicativo permite aos usuários criar, editar e remover listas e itens, ajudando na organização de suas rotinas diárias.

## Funcionalidades

- Criar listas
- Editar listas
- Remover listas
- Adicionar item à listas
- Editar item da listas
- Remover item da listas
- Armazenamento de data de criação/alteração para cada item da lista
- Utilização do Firestore (Firebase) como banco de dados

## Arquitetura e Design Pattern

O aplicativo foi desenvolvido utilizando a arquitetura Bloc para gerenciamento de estado. Além disso, foram aplicados princípios de design de software SOLID e padrões de programação orientada a objetos.

## Estrutura do Projeto

- `lib/cubits`: Contém a lógica de negócios da aplicação, utilizando a arquitetura Bloc.
- `lib/models`: Define os modelos de dados utilizados na aplicação.
- `lib/repositories`: Contém as classes responsáveis pela comunicação com o banco de dados Firestore.
- `lib/screens`: Contém as telas da aplicação.
- `lib/widgets`: Contém os widgets reutilizáveis utilizados na interface.

## Como Executar o Projeto

1. Certifique-se de ter o ambiente de desenvolvimento Flutter configurado em sua máquina. Consulte a [documentação oficial do Flutter](https://flutter.dev/docs/get-started/install) para instruções detalhadas.

2. Clone este repositório:
    CMD:
    > git clone https://github.com/seu-usuario/seu-repositorio.git

3. Navegue até o diretório do projeto:
    CMD:
    > cd <seu-repositorio>

4. Instale as dependências do projeto:
    CMD:
    > flutter pub get

5. Certifique-se de ter configurado o Firebase em seu projeto Flutter. Consulte a [documentação oficial do Firebase para Flutter](https://firebase.flutter.dev/docs/overview) para instruções detalhadas.

6. Execute o aplicativo em um dispositivo ou emulador:
    CMD:
    > flutter run