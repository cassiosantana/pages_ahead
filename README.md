# Pages Ahead

O Pages Ahead é um projeto com o objetivo é criar uma aplicação Rails simples, mas completa, que funcione como uma plataforma de publicação de livros, fornecendo um ambiente para gerenciar autores, livros, peças, montagens, fornecedores e contas. O desenvolvimento não é linear e simula diferentes releases, onde cada "batalha" representa uma fase de desenvolvimento com tarefas específicas a serem concluídas.

## Batalha 1: CRUD - Cadastro e Gerenciamento de Recursos

Nesta batalha, o foco é na criação e gerenciamento básico dos principais recursos da aplicação:

- Cadastrar Autores
- Cadastrar Livros os vinculando com Autor
- Cadastrar Peças as vinculando com Fornecedor
- Cadastrar Montagens com várias Peças e as vinculando com Livro

## Batalha 2: API - Desenvolvimento da API

Nesta batalha, o projeto é expandido para incluir uma API que permitirá a interação externa com os recursos da aplicação:

- Cadastrar Autores via API
- Cadastrar Livros via API, os vinculando com Autor
- Cadastrar Peças via API, as vinculando com Fornecedor
- Cadastrar Montagens via API, com várias Peças e as vinculando com Livro

## Batalha 3: Regras de Negócio

Nesta batalha, as regras de negócio começam a ser aplicadas ao sistema. Alterações e validações são introduzidas:

### Alterar

- Adicionar campo CNPJ em Fornecedor
- Adicionar campo Dígito Verificador em Conta
- Adicionar campo ISBN em Livro
- Adicionar campo CPF em Autor

### Calcular

- Calcular Dígito Verificador em Conta

### Validar

- Validar CNPJ em Fornecedor
- Validar ISBN em Livro
- Validar CPF em Autor

## Batalha 4: Filtros e Consultas

Nesta batalha, a funcionalidade de filtragem e consultas é implementada para facilitar a busca e visualização dos recursos:

### Adicionar

- Adicionar Campo Título em Livro
- Adicionar Campo Nome em Peça

### Filtrar

- Filtrar Fornecedor por Nome
- Filtrar Fornecedor por Número da Conta em Conta
- Filtrar Livros por Título
- Filtrar Livros por Nome em Autor
- Filtrar Montagem por Nome em Peça
- Filtrar Fornecedor por Nome do Autor

## Batalha 5: Relatórios e Análises

Nesta batalha, a funcionalidade de relatórios e análises para extrair informações significativas dos dados da aplicação:

### Adicionar

- Adicionar Campo Valor em Peça

### Relatórios

- Gerar Relatório de Autor (com todas as informações), seus Livros (com todas as informações) e o Total de Livros Publicados
- Gerar Relatório de Fornecedor (com todas as informações), com todos os Autores (com todas as informações) e Livros (com todas as informações)
- Gerar Relatório de Livro com Montagem (com todas as informações), suas Peças (com todas as informações), o Total de Peças e o Custo Total da Montagem

## Contribuição

Este projeto está em constante evolução e novas batalhas serão adicionadas à medida que o desenvolvimento progride. Sinta-se à vontade para contribuir, fornecer feedback e colaborar para tornar o PagesAhead uma aplicação robusta.