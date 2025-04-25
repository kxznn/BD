create database EmpresaX;
use EmpresaX;

CREATE TABLE Departamento (
    iddep INT(5) NOT NULL,  
    nome CHAR(30),
    Localização CHAR(60),
    PRIMARY KEY (iddep)
);


CREATE TABLE Funcionários (
    idfun INT NOT NULL,
    nome CHAR(30),
    cargo CHAR(20),
    salário DECIMAL(10,2),
    DataContratação DATE,
    departamento INT,
    PRIMARY KEY (idfun),
    FOREIGN KEY (departamento) REFERENCES Departamento(iddep)
);


INSERT INTO Departamento VALUES
('111', 'Kauã Aguiar', '2° andar'),
('112', 'Gabrielly', '1° andar'),
('113', 'João Alves', '3° andar');


INSERT INTO Funcionários VALUES ('001', 'Kauã Aguiar', 'Tecnico de informática', 5000.00, '2021-03-01', '111');
INSERT INTO Funcionários VALUES ('002', 'Gabrielly Aguiar', 'Gerente', 10000.00, '2021-02-01', '112');
INSERT INTO Funcionários VALUES ('003', 'João Alves', 'Operador de Máquina', 3500.00, '2021-03-05','113');

select*from departamento;
select*from funcionários;

SELECT nome, cargo, salário
FROM Funcionários
WHERE salário BETWEEN 3000.00 AND 6000.00;



------------------------------

DELIMITER $$
CREATE PROCEDURE listaFuncionarios()
BEGIN
    SELECT nome FROM Funcionários;
END $$
DELIMITER ;

call listaFuncionarios();

------------------------------
DELIMITER $$
create function salario_anual(salário DECIMAL(10,2))
returns decimal(10,2)
deterministic
begin
	return salário *12;
end $$
DELIMITER;

SELECT nome, cargo, salario_anual(salário) as salario_anual
from funcionários;

------------------------------

DELIMITER $$

CREATE PROCEDURE inserirFuncionario (
    IN pnome CHAR(30),
    IN pcargo CHAR(20),
    IN psalário DECIMAL(10,2),
    IN pDataContratação DATE,
    IN piddep int
)
BEGIN
    INSERT INTO Funcionários (nome, cargo, salário, DataContratação, iddep)
    VALUES (pnome, pcargo, psalário, pDataContratação, piddep);
END$$

DELIMITER ;


CALL inserirFuncionario('Jousé', 'segurança', 2500.00, '2021-03-01',114);
select*from funcionários;

------------------------------

CREATE VIEW listaFuncionarioSalario AS
SELECT nome, salário
FROM Funcionários
WHERE salário > 6000.00;

SELECT * FROM listaFuncionarioSalario;
