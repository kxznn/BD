-- Criar o banco de dados
CREATE DATABASE e_logiware;
USE e_logiware;


-- criação das tabelas 
CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    contato VARCHAR(100)
);

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    endereço VARCHAR(100), 
    contato VARCHAR(100)
);

CREATE TABLE Transportadora (
    id_transportadora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    contato VARCHAR(100)
);

CREATE TABLE Armazenamento (
    id_armazenamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    capacidade_total DECIMAL(10,2) NOT NULL, 
    capacidade_utilizada DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    descrição VARCHAR(100) NOT NULL, 
    qnt_estoque INT NOT NULL, 
    id_armazenamento INT,
    id_fornecedor INT,
    FOREIGN KEY (id_armazenamento) REFERENCES Armazenamento (id_armazenamento),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor (id_fornecedor)
);

CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATE,
    status VARCHAR(50),
    id_cliente INT,
    id_transportadora INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_transportadora) REFERENCES Transportadora(id_transportadora)
);

-- Relacionamento entre pedido e produto 
CREATE TABLE Pedido_Produto (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

create table historico_estoque (
id_historico int primary key auto_increment,
id_produto int,
id_pedido int,
quantidade int, 
movimentação enum('entrada', 'saida'), 
data_movi datetime default current_timestamp,
foreign key (id_produto) references Produto(id_produto),
foreign key (id_pedido) references Pedido(id_pedido)
);


-- Funcionalidades do Banco de dados 

-- atualização do estoque automatico (TRIGGER)

DELIMITER $$
create trigger atualiza_estoque
after insert on Pedido_Produto
for each row 
begin
	update Produto set qnt_estoque = qnt_estoque - NEW.quantidade
    where id_produto = NEW.id_Produto;
    
	insert into historico_estoque (id_produto, quantidade, movimentação, id_pedido) values
	(NEW.id_produto, NEW.quantidade, 'SAIDA', NEW.id_pedido);
END $$
DELIMITER ;

-- Procedimento para uma alocação dinâmica (PROCEDURE)

DELIMITER $$
create procedure alocar_armazenamento (
in p_id_produto int,
in p_quantidade int,
in p_volume_uni decimal(10,2)
)
begin 
	declare v_id_armazem int;
    declare v_espaco_armazem decimal(10,2);
    set v_espaco_armazem = quantidade * p_volume_uni;
    
    select id_armazenamento into v_id_armazem from Armazenamento 
    where (capacidade_total - capacidade_utilizada) >= v_espaco_armazem 
    limit 1;
    
    if v_id_armazem then
		update Produto set id_armazenamento = v_id_armazem where id_produto = p_id_produto;
		update Armazenamento set capacidade_utilizada = capacidade_utilizada + v_espaco_armazem 
		where id_armazenamento = v_id_armazem;
		select 'Ok' as status;
	else 
		select 'Armazenamento sem espaço' as status;
    end if;
end $$
DELIMITER ;

-- Visualizar os pedidos com mais detalhes (VIEW)

create view view_pedido as 
select 
	p.pedido, 
    p.data_pedido, 
    p.status,
	c.nome as Cliente,
	t.nome as Transportadora
from Pedido p 
join Cliente c on p.id_cliente = c.id_cliente
join Transportadora t on p.id_transportadora = t.id_transportadora;

-- Consulta dos produtos por fornecedor

create view produtos_fornecedore as 
select 
	f.id_fornecedor,
    f.nome as Fornecedor, 
    f.contato,
    p.id_produto,
    p.descriçãoo as Produto,
    p.qnt_estoque
from Fornecedor f
left join Produto p on f.id_fornecedor = p.id_forncedor;

-- SQL e Procedimentos Armazenados

-- Consulta de disponibilidade de produto
select 
	p.id_produto,
	p.descrição,
	p.qnt_estoque, 
	a.nome as armazenamento,
	f.nome as fornecedor
from Produto p
join Armazenamento a on p.id_armazenamento = a.id_armazenamento
join Fornecedor f on p.id_fornecedor = f.id_fornecedor
where p.qnt_estoque < 10;

-- Relatório de movimentação 
select 
	p.id_produto,
    p.descrição AS produto,
    h.tipo_movimentacao,
    h.quantidade,
    p.qnt_estoque AS estoque_atual,
    h.data_movi
from historico_estoque h
join Produto p on h.id_produto = p.id_produto
order by p.id_produto, h.data_movi

-- Atualização de estoque (PROCEDURE)

DELIMITER $$
create procedure att_estoque(
    in produto_id int,
    in qtd int,
    in tipo varchar(7)
)
begin
    update Produto 
    set qnt_estoque = qnt_estoque + if (tipo = 'ENTRADA', qtd, -qtd)
    where id_produto = produto_id;

    insert into historico_estoque (id_produto, quantidade, tipo_movimentacao)
    values (produto_id, qtd, tipo);
end $$
DELIMITER ;

-- Gerenciamento do armazenamento 

DELIMITER $$
create procedure geren_armazen ()
begin
	select 
		id_armazenamento,
        nome,
        capacidade_total,
        capacidade_utilizada
	from Armazenamento
    order by (capacidade_utlizada / capacidade_total) desc;
end $$
DELIMITER ;