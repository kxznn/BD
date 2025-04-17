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
WHERE salário BETWEEN 4000.00 AND 8000.00;
