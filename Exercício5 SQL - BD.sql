create database controle_estoque;
use controle_estoque;

CREATE TABLE Produtos (
id_produto INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
quantidade INT 
); 


CREATE TABLE Log_estoque (
id_log INT AUTO_INCREMENT PRIMARY KEY,
id_produto INT,
quantidade_antiga INT,
quantidade_nova INT,
data_alteracao DATETIME,
CONSTRAINT fk_produto FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO Produtos (nome, quantidade) VALUES
('Tenis Nike air max TN', 40),
('Playstation 5', 20),
('Monitor 265Hz', 5),
('Iphone 16', 10),
('Teclado mecânico 60% ', 15);


-- Trigger - AFTER UPDATE 
delimiter $$
create trigger trg_qnt
after update on Produtos
for each row
begin
	insert into log_estoque(id_produto, quantidade_antiga, quantidade_nova, data_alteracao)
	values (old.id_produto, old.quantidade, new.quantidade, now());
end $$
delimiter ;

update Produtos set quantidade = 50 where id_produto = 1;
select * from log_estoque;
select*from Produtos;


-- Função
DELIMITER $$
CREATE FUNCTION get_qtd(p_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE quantidade INT;

    SELECT quantidade INTO quantidade from Produtos where id_produto = id_p;

    return quantidade;
end$$
delimiter ;


-- Procedure
delimiter $$
create procedure att_qntd(p_id int, p_nv_qntd int)
begin
    update produtos
    set quantidade = p_nv_qntd
    where id_produto = p_id;

    select 'Produto atualizado com sucesso' as mensagem;
end $$
delimiter ;
CALL att_qntd(3, 40);