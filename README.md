# Projeto Warehouse Control

O projeto Warehouse Control é um aplicativo Rails estilizado com Bootstrap, que permite o controle de materiais em um almoxarifado. Permitindo que usuários sejam criados para que possam adicionar ou remover materiais, incrementar ou diminuir a quantidade desses materiais, e implementa também logs que registram as alterações efetuadas nos materiais.

Obs: Operações de adição e remoção da quantidade de materiais só podem ser executadas em dias úteis das 9h às 18h.

## Requisitos Técnicos

- Ruby: 2.7.4
- Framework: Ruby on Rails 5.2.8
- Banco de Dados: PostgreSQL

## Configuração e Execução Local

1. Certifique-se de ter as dependências básicas instaladas, incluindo o Ruby on Rails, docker e docker-compose.
2. Navegue até o diretório do projeto e execute os comandos:

  `$ docker-compose build`

  `$ docker-compose run --rm web rails db:create`

  `$ docker-compose run --rm web rails db:migrate`

  `$ docker-compose up`

  Obs: Você pode rodar o comando a seguir se quiser gerar automaticamente materiais exemplos no banco de dados.

  `$ docker-compose run --rm web rails db:seed`

7. Agora você pode acessar o projeto localmente em seu navegador: [localhost:3000](http://localhost:3000).
