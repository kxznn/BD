create database empresa_sportlife;
use empresa_sportlife;

create table Fornecedores (
	ID int primary key auto_increment,
    Nome varchar(100),
    Contato varchar(100)
    );
    
CREATE TABLE Estoque (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Produto VARCHAR(100),
  Quantidade INT,
  Id_Fornecedor INT,
  FOREIGN KEY (Id_Fornecedor) REFERENCES Fornecedores(ID)
);
    
create table Clientes (
	ID_Cliente int primary key auto_increment,
	Nome varchar(100),
	Email varchar(100)
);
    
create table Pedidos (
	ID int primary key auto_increment,
	Produto varchar (100),
	Quantidade int,
	ID_Cliente int,
	Status varchar(50) default 'Pendente',
	DataPedido timestamp default current_timestamp, 
	foreign key (ID_Cliente) references Clientes(ID_Cliente)
);

create table Historico_Pedidos (
	ID int primary key auto_increment,
	Produto varchar(100),
	Quantidade int, 
	ID_Cliente int, 
	Statuts varchar(50),
	DataPedido timestamp,
	foreign key (ID_Cliente) references Clientes(ID_Cliente)
);
    
-- inserir Fornecedores 

insert into Fornecedores (Nome, Contato) values
('Kauã', 'contatokaua@gmail.com'),
('Gabrielly', 'contatogabrielly@gmail.com'),
('José', 'contatojose@gmail.com'),
('Jade', 'contatojade@gmail.com');
select*from Fornecedores;

-- inserir Estoque

insert into Estoque (Produto, Quantidade, Id_Fornecedor) values
('Polo Tommy Hilfiger', 50, 1),
('Boné lacoste', 40, 2),
('Tenis nike air max', 30, 3),
('Calça moletom Adidas',20, 4);
select*from Estoque;

-- inserir Clientes

insert into Clientes (Nome, Email) values
('Kaio', 'kaio10@gmail.com'),
('Sheila', 'sheila11@gmail.com'),
('Luciano', 'luciano12@gmail.com'),
('Regina', 'regina13@gmail.com');
select*from Clientes;

-- inserir Pedidos

insert into Pedidos(Produto, Quantidade, ID_Cliente, STATUS) values
('Tenis nike air max', 3, 1, 'Pendente'),
('Calça moletom Adidas', 2, 2, 'Em andamento'),
('Polo Tommy Hilfiger', 1, 3,'Finalizado'),
('Boné lacoste', 2, 4, 'Finalizado');
select*from Pedidos;

-- VIEWS 

create view view_fornecedores as
select f.ID, f.Nome, f.Contato, e.Produto, e.Quantidade
from Fornecedores f
join Estoque e on f.ID = e.ID_Fornecedor;
select*from view_fornecedores;

-- Procedure

DELIMITER $$
create procedure RegistroCliente(in nome varchar(100), in email varchar(100))
begin
insert into Clientes (Nome, Email) 
values (nome, email);
end $$

DELIMITER ;

call RegistroCliente ('Vinicius', 'vinicius14@gmail.com');
select*from Clientes;

-- Trigger 

DELIMITER $$
CREATE TRIGGER AtualizarEstoque
AFTER UPDATE ON Pedidos 
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Confirmado' THEN 
        UPDATE Estoque 
        SET Quantidade = Quantidade - NEW.Quantidade 
        WHERE Produto = NEW.Produto;
    END IF;
END $$

DELIMITER ;