# BANCO-DE-DADOS
Atividades de SQL

1) Crie um banco de dados, insira informações nele e responda: quantas disciplinas estão cadastradas,
quantos alunos estão registrados e quais cursos são oferecidos.

2) CREATE DATABASE e USE
Crie um banco de dados chamado EmpresaX e
selecione-o para uso.

CREATE TABLE
Crie uma tabela chamada Funcionarios com as
colunas:
ID (int, chave primária):
Identificação única dos funcionários.
Nome (varchar): Nome completo do
funcionário.
Cargo (varchar): Posição ou título do
funcionário dentro da empresa.
Salario (decimal): Remuneração do
funcionário.
DataContratacao (date): Data de início na
empresa.

Já a segunda tabela pode ser Departamentos, com
essas colunas:
ID: Identificação única dos departamentos.
Nome: Nome do departamento.
Localizacao: Local onde o departamento está
situado.

Essas tabelas podem ser conectadas, por exemplo,
com uma chave estrangeira que relacione os
funcionários aos seus respectivos departamentos.

INSERT INTO
Insira registros na tabela Funcionarios com dados
fictícios de três funcionários. Inclua informações
como nome, cargo, salário e data de contratação. E
Inserir dados na tabela departamentos.

SHOW DATABASES
Liste todos os bancos de dados no servidor para
verificar se o EmpresaX foi criado corretamente.

SHOW TABLES
Liste todas as tabelas no banco de dados EmpresaX
para confirmar a criação da tabela Funcionarios.

DESC
Mostre a estrutura da tabela Funcionarios, incluindo
as colunas e seus tipos de dados.

BETWEEN
Faça uma consulta que liste todos os funcionários
cujo salário esteja entre R$3.000 e R$6.000.

ALTER TABLE
Adicione uma nova coluna chamada Departamento
(varchar) à tabela Funcionarios, para especificar em
qual departamento cada funcionário trabalha.
