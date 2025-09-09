-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;


CREATE TABLE Oficina (
    idOficina INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    PRIMARY KEY (idOficina)
);

CREATE TABLE Mecanicos (
    idMecanico INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    Especialidade VARCHAR(50),
    Oficina_idOficina INT NOT NULL,
    PRIMARY KEY (idMecanico),
    FOREIGN KEY (Oficina_idOficina) REFERENCES Oficina(idOficina)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Estoque (
    idEstoque INT NOT NULL AUTO_INCREMENT,
    Local VARCHAR(100),
    Observacao VARCHAR(150),
    Oficina_idOficina INT NOT NULL,
    PRIMARY KEY (idEstoque),
    FOREIGN KEY (Oficina_idOficina) REFERENCES Oficina(idOficina)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Cliente (
    idCliente INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20),
    Endereco VARCHAR(150),
    PRIMARY KEY (idCliente)
);

CREATE TABLE Cliente_PF (
    idCliente_PF INT NOT NULL AUTO_INCREMENT,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Data_Nascimento DATE,
    Cliente_idCliente INT NOT NULL,
    PRIMARY KEY (idCliente_PF, Cliente_idCliente),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Cliente_PJ (
    idCliente_PJ INT NOT NULL AUTO_INCREMENT,
    CNPJ VARCHAR(18) NOT NULL UNIQUE,
    Razao_Social VARCHAR(100) UNIQUE,
    Cliente_idCliente INT NOT NULL,
    PRIMARY KEY (idCliente_PJ, Cliente_idCliente),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Veiculos (
    idVeiculo INT NOT NULL AUTO_INCREMENT,
    Marca VARCHAR(50),
    Modelo VARCHAR(50) NOT NULL,
    Ano INT NOT NULL,
    Placa VARCHAR(20) NOT NULL UNIQUE,
    Cliente_idCliente INT NOT NULL,
    PRIMARY KEY (idVeiculo, Cliente_idCliente),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Ordem_de_Servico (
    idOS INT NOT NULL AUTO_INCREMENT,
    Data_Emissao DATE NOT NULL,
    Data_Conclusao DATE,
    Status ENUM('Aberto','Em Andamento','Concluido') NOT NULL,
    Valor_Total DECIMAL(10,2),
    Veiculo_idVeiculo INT NOT NULL,
    Cliente_idCliente INT NOT NULL,
    Oficina_idOficina INT NOT NULL,
    PRIMARY KEY (idOS, Veiculo_idVeiculo, Cliente_idCliente, Oficina_idOficina),
    FOREIGN KEY (Veiculo_idVeiculo, Cliente_idCliente) REFERENCES Veiculos(idVeiculo, Cliente_idCliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Oficina_idOficina) REFERENCES Oficina(idOficina)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Servico (
    idServico INT NOT NULL AUTO_INCREMENT,
    Descricao VARCHAR(100) NOT NULL,
    Valor_Mao_Obra DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idServico)
);

CREATE TABLE Pecas (
    idPeca INT NOT NULL AUTO_INCREMENT,
    Nome_Peca VARCHAR(100) NOT NULL,
    Descricao VARCHAR(150),
    PRIMARY KEY (idPeca)
);

CREATE TABLE OS_Mecanicos (
    Ordem_de_Servico_idOS INT NOT NULL,
    Ordem_de_Servico_Veiculo_idVeiculo INT NOT NULL,
    Ordem_de_Servico_Cliente_idCliente INT NOT NULL,
    Mecanico_idMecanico INT NOT NULL,
    PRIMARY KEY (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente, Mecanico_idMecanico),
    FOREIGN KEY (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente)
        REFERENCES Ordem_de_Servico(idOS, Veiculo_idVeiculo, Cliente_idCliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanicos(idMecanico)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Pecas_OS (
    Ordem_de_Servico_idOS INT NOT NULL,
    Ordem_de_Servico_Veiculo_idVeiculo INT NOT NULL,
    Ordem_de_Servico_Cliente_idCliente INT NOT NULL,
    Peca_idPeca INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente, Peca_idPeca),
    FOREIGN KEY (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente)
        REFERENCES Ordem_de_Servico(idOS, Veiculo_idVeiculo, Cliente_idCliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Peca_idPeca) REFERENCES Pecas(idPeca)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Servico_OS (
    Ordem_de_Servico_idOS INT NOT NULL,
    Ordem_de_Servico_Veiculo_idVeiculo INT NOT NULL,
    Ordem_de_Servico_Cliente_idCliente INT NOT NULL,
    Servico_idServico INT NOT NULL,
    PRIMARY KEY (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente, Servico_idServico),
    FOREIGN KEY (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente)
        REFERENCES Ordem_de_Servico(idOS, Veiculo_idVeiculo, Cliente_idCliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Produto (
    idProduto INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50),
    Descricao VARCHAR(150),
    Valor DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idProduto)
);

CREATE TABLE Fornecedor (
    idFornecedor INT NOT NULL AUTO_INCREMENT,
    Razao_Social VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(18) NOT NULL UNIQUE,
    Telefone VARCHAR(20),
    Endereco VARCHAR(150),
    PRIMARY KEY (idFornecedor)
);

CREATE TABLE Produto_Fornecedor (
    Produto_idProduto INT NOT NULL,
    Fornecedor_idFornecedor INT NOT NULL,
    PRIMARY KEY (Produto_idProduto, Fornecedor_idFornecedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Produto_Estoque (
    Produto_idProduto INT NOT NULL,
    Estoque_idEstoque INT NOT NULL,
    Quantidade_pecas VARCHAR(100) NOT NULL,
    PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Inserção de dados

INSERT INTO Oficina (Nome, Endereco) VALUES
('Oficina Central', 'Rua A, 100'),
('Oficina Norte', 'Rua B, 200');

INSERT INTO Cliente (Nome, Telefone, Endereco) VALUES
('Carlos Silva', '11999990001', 'Rua C, 300'),
('Ana Souza', '11999990002', 'Rua D, 400');

INSERT INTO Veiculos (Marca, Modelo, Ano, Placa, Cliente_idCliente) VALUES
('Ford', 'Fiesta', 2020, 'AAA1111', 1),
('Chevrolet', 'Onix', 2021, 'BBB2222', 2);

INSERT INTO Mecanicos (Nome, Endereco, Especialidade, Oficina_idOficina) VALUES
('João', 'Rua X, 10', 'Motor', 1),
('Maria', 'Rua Y, 20', 'Elétrica', 2);

INSERT INTO Estoque (Local, Observacao, Oficina_idOficina) VALUES
('Estoque Central', 'Principal', 1),
('Estoque Norte', 'Secundário', 2);

INSERT INTO Produto (Nome, Categoria, Descricao, Valor) VALUES
('Óleo Lubrificante', 'Lubrificantes', 'Óleo 5W30', 50.00),
('Filtro de Ar', 'Filtros', 'Filtro de ar padrão', 30.00);

INSERT INTO Produto_Estoque (Produto_idProduto, Estoque_idEstoque, Quantidade_pecas) VALUES
(1, 1, '50'),
(2, 2, '30');

INSERT INTO Pecas (Nome_Peca, Descricao) VALUES
('Filtro de Óleo', 'Filtro de óleo padrão'),
('Velas', 'Jogo de velas');

INSERT INTO Servico (Descricao, Valor_Mao_Obra) VALUES
('Troca de Óleo', 80.00),
('Revisão Elétrica', 120.00);

INSERT INTO Ordem_de_Servico (Data_Emissao, Data_Conclusao, Status, Valor_Total, Veiculo_idVeiculo, Cliente_idCliente, Oficina_idOficina) VALUES
('2025-09-08', NULL, 'Aberto', 200.00, 1, 1, 1),
('2025-09-08', NULL, 'Aberto', 150.00, 2, 2, 2);

INSERT INTO OS_Mecanicos (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente, Mecanico_idMecanico) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2);

INSERT INTO Pecas_OS (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente, Peca_idPeca, Quantidade) VALUES
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 1);

INSERT INTO Servico_OS (Ordem_de_Servico_idOS, Ordem_de_Servico_Veiculo_idVeiculo, Ordem_de_Servico_Cliente_idCliente, Servico_idServico) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2);




-- Total gasto por cliente em OS
SELECT c.idCliente, c.Nome, 
       SUM(os.Valor_Total) AS TotalGasto
FROM Cliente c
JOIN Ordem_de_Servico os ON os.Cliente_idCliente = c.idCliente
GROUP BY c.idCliente, c.Nome
HAVING TotalGasto > 100
ORDER BY TotalGasto DESC;

-- Serviços mais realizados
SELECT s.idServico, s.Descricao, COUNT(so.Servico_idServico) AS Quantidade
FROM Servico s
JOIN Servico_OS so ON so.Servico_idServico = s.idServico
GROUP BY s.idServico, s.Descricao
ORDER BY Quantidade DESC;

-- Ordens de serviço abertas
SELECT os.idOS, c.Nome AS Cliente, v.Modelo AS Veiculo, os.Status, os.Valor_Total
FROM Ordem_de_Servico os
JOIN Cliente c ON c.idCliente = os.Cliente_idCliente
JOIN Veiculos v ON v.idVeiculo = os.Veiculo_idVeiculo AND v.Cliente_idCliente = c.idCliente
WHERE os.Status = 'Aberto'
ORDER BY os.Data_Emissao ASC;

-- Peças com estoque baixo
SELECT p.idPeca, p.Nome_Peca, e.Local, pe.Quantidade_pecas
FROM Pecas p
JOIN Produto_Estoque pe ON pe.Produto_idProduto = p.idPeca
JOIN Estoque e ON e.idEstoque = pe.Estoque_idEstoque
WHERE pe.Quantidade_pecas <= '20'
ORDER BY pe.Quantidade_pecas ASC;

-- Fornecedores e seus produtos
SELECT f.Razao_Social AS Fornecedor, pr.Nome AS Produto
FROM Fornecedor f
JOIN Produto_Fornecedor pf ON pf.Fornecedor_idFornecedor = f.idFornecedor
JOIN Produto pr ON pr.idProduto = pf.Produto_idProduto
ORDER BY f.Razao_Social, pr.Nome;


-- Ticket médio por OS
SELECT os.idOS, c.Nome AS Cliente, 
       COUNT(so.Servico_idServico) AS QtdeServicos,
       os.Valor_Total / COUNT(so.Servico_idServico) AS TicketMedio
FROM Ordem_de_Servico os
JOIN Servico_OS so ON so.Ordem_de_Servico_idOS = os.idOS
JOIN Cliente c ON c.idCliente = os.Cliente_idCliente
GROUP BY os.idOS, c.Nome, os.Valor_Total
HAVING QtdeServicos >= 1
ORDER BY TicketMedio DESC;

-- Ordens de serviço atrasadas 
SELECT os.idOS, c.Nome AS Cliente, os.Status, os.Data_Emissao
FROM Ordem_de_Servico os
JOIN Cliente c ON c.idCliente = os.Cliente_idCliente
WHERE os.Status <> 'Concluido' AND os.Data_Conclusao IS NULL
ORDER BY os.Data_Emissao ASC;

