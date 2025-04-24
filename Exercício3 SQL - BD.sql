create database gestao_de_vendas;
use gestao_de_vendas;

CREATE TABLE Cliente (
cliente_id INT PRIMARY KEY,
nome VARCHAR(100),
cpf CHAR(11),
email VARCHAR(100),
telefone VARCHAR(15)
);

CREATE TABLE Vendedor (
vendedor_id INT PRIMARY KEY,
nome VARCHAR(100),
email VARCHAR(100),
salario DECIMAL(10,2)
);

CREATE TABLE Produto (
produto_id INT PRIMARY KEY,
nome VARCHAR(100),
preco DECIMAL(10,2),
estoque INT
);

CREATE TABLE Venda (
venda_id INT PRIMARY KEY,
cliente_id INT,
vendedor_id INT,
data_venda DATE,
total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
FOREIGN KEY (vendedor_id) REFERENCES Vendedor(vendedor_id)
);

CREATE TABLE ItemVenda (
item_id INT PRIMARY KEY,
venda_id INT,
produto_id INT,
quantidade INT,
preco_unitario DECIMAL(10,2),
FOREIGN KEY (venda_id) REFERENCES Venda(venda_id),
FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);

select*from Cliente;

insert into Cliente VALUES
('001', 'Marcos', '11223344556', 'marcos021@gmail.com', '199890654987'),
('002', 'João', '98765432100', 'joao@gmail.com', '11888888888'),
('003', 'Ana', '45612378900', 'ana@gmail.com', '11777777777'),
('004', 'Pedro', '32178965400', 'pedro@gmail.com', '11666666666'),
('005', 'Clara', '12332145600', 'clara@gmail.com', '11555555555');

insert into Vendedor VALUES
('01', 'Alberto', 'albertoalves@gmail.com', '2000.00'),
('02', 'Rodolfo', 'rodolfreitas@gmail.com', '3000.00'),
('03', 'Mayara', 'Coimbramayara@gmail.com', '2500.00'),
('04', 'Kauã', 'kauarodrigues@gmail.com', '4500.00'),
('05', 'Jorge', 'jorgeslv@gmail.com', '3000.00');

insert into Produto VALUES 
('12', 'Boné Lacoste', '300.00', 50),
('21', 'Tenis Nike', '1000.00', 25),
('13', 'Smartphone', '2500.00', 15),
('31', 'Mesa de escritório', '700.00', 30),
('14', 'VideoGame', '3000.00', 10);

insert into Venda VALUES
('1', '001', '05', '2024-06-02', '3000.00'), -- 1 VideoGame
('2', '002', ' 01', '2024-02-20', '900.00'), -- 3 Boné Lacoste
('3', '003', '02', '2024-08-15', '2000.00'), -- 2 Tenis Nike
('4', '004', '04', '2024-10-16', '1400.00'), -- 2 Mesa de escritório
('5', '005', '03', '2024-05-25', 7500.00), -- 3 Smartphone
('6', '001', '04', '2024-11-04', 3000.00); -- 3 Tenis Nike

insert into ItemVenda VALUES
('11', '1', '14', '1', '3000.00'),
('22', '2', '12', '3', '300.00'),
('33', '3', '21', '2', '1000.00'),
('44', '4', '31', '2', '700.00'),
('55', '5', '13', '3', '2500.00'),
('66', '6', '21', '3', '1000.00');


-- Lista dos clientes cadastrados
select*from Cliente;

-- Nome dos produtos existentes 
select nome from Produto;

-- Lista dos produtos com valor superior a R$100 
select*from Produto where preco > 100.00;

-- Clientes cadastrados dentro do sistema
select Nome from Cliente;

-- Exibição dos cliente e produtos cadastrados
SELECT Cliente.nome AS cliente_nome, Produto.nome AS produto_nome FROM Cliente CROSS JOIN Produto;

-- Quantidade de clientes existentes na empresa
select count(*) from Cliente;

-- Quantidade de produtos existentes no sistema
select count(*) as Qdt_ProdutosTotal from Produto;

-- Vendas realizadas em 2024
select count(*) as VendasRealizadas_2024 from Venda where year(data_venda) = 2024 ;

-- Valor total das vendas
select count(*) as Valor_total from Venda;

-- Vendas feitas pelo funcianário de ID 5 
select count(*) as Funcionario_id5 from Venda where vendedor_id = 5;

-- Quantidade de pedidos feitos pelo cliente João
select count(*) as pedidos_João_Silva from Venda join Cliente on Venda.cliente_id = Cliente.cliente_id where Cliente.nome = 'João Silva' ;

-- Soma dos pedidos da  'Vendas' 
select sum(total) as SomaTotal_Vendas from venda;

-- Clientes que ganham mais de  R$3.000;
select nome as salario_maior_que_3000,salario from Vendedor where salario > 3000.00;

-- Produtos que custam mais de R$100;
select nome,preco from  Produto where preco > 100.00;

-- Valor total dos pedidos do cliente de ID 2
select sum(total) as SomaCliente_id2 from Venda join Cliente on Venda.cliente_id = Cliente.cliente_id where Cliente.cliente_id = 2;