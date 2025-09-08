USE Ecommerce;


INSERT INTO Cliente (Tipo_Cliente, Nome, CPF, Endereco, Contato, DataDeNascimento) VALUES
('PF','Maria Silva','12345678901','Rua das Flores, 123 - Centro','48999990000','1990-05-14'),
('PF','João Santos','98765432100','Av. Brasil, 456 - Bairro São Pedro','47988887777','1985-10-22'),
('PF','Ana Costa','11122233344','Rua da Paz, 789 - Bairro Bela Vista','47977776666','2000-01-01'),
('PF','Carlos Oliveira','55544433322','Rua XV de Novembro, 1000 - Centro','47966665555','1995-07-30'),
('PF','Fernanda Lima','99988877766','Av. Beira Mar, 250 - Ponta Aguda','47955554444','1988-12-12'),
('PJ','Tech Distribuidora Ltda',NULL,'Av. Industrial, 100','48999990011',NULL),
('PJ','Moveis Brasil SA',NULL,'Av. Móveis, 200','47988887788',NULL);


INSERT INTO Cargo (Nome_Cargo) VALUES ('Administrador'), ('Vendedor'), ('Gerente');


INSERT INTO Funcionario (Nome, Senha, Email, Cargo_idCargo) VALUES
('Carlos Souza','senha123','carlos@empresa.com',1),
('Maria Oliveira','senha456','maria@empresa.com',2),
('João Silva','senha789','joao@empresa.com',3);


INSERT INTO Produto (Categoria, Descricao, Valor) VALUES
('Eletronicos','Smartphone X Pro 128GB',2500.00),
('Eletrodomesticos','Geladeira Frost Free 400L',3200.00),
('Moveis','Sofa Retratil 3 lugares - Slim',1500.00),
('Eletronicos','Fone de Ouvido Bluetooth',199.90);


INSERT INTO Estoque (Local) VALUES
('Centro de Distribuicao SP'),
('Centro de Distribuicao RJ');


INSERT INTO Fornecedor (Razao_Social, CNPJ) VALUES
('Tech Distribuidora Ltda','11222333444455'),
('Moveis Brasil SA','99887766554433');


INSERT INTO Terceiro_Vendedor (Razao_Social, Local, Nome_Fantasia, CNPJ) VALUES
('Loja Eletronicos Online Ltda','Sao Paulo - SP','Eletronicos Online','55443322110099'),
('Casa dos Moveis EIRELI','Rio de Janeiro - RJ','Moveis Casa','66778899001122');


INSERT INTO Pedido (Status_Do_Pedido, Descricao, Cliente_idCliente, Frete, Data_Pedido, Funcionario_idFuncionario) VALUES
('EM PROCESSAMENTO','Compra de Smartphone X Pro',1,30.00,'2025-09-01 09:00:00',2),
('ENVIADO','Compra de Geladeira Frost Free',2,150.00,'2025-09-02 11:30:00',3),
('ENTREGUE','Compra de Sofa Retratil',3,50.00,'2025-08-28 14:00:00',2),
('EM ANDAMENTO','Compra de Fone Bluetooth',1,10.00,'2025-09-05 10:15:00',2);


INSERT INTO Entrega (Status_Entrega, Pedido_idPedido, Codigo_Rastreio, DataEnvio, DataEntrega_Prevista, DataEntrega_Real, Funcionario_idFuncionario) VALUES
('ENVIADO',1,'R123456BR','2025-09-02 10:00:00','2025-09-05 18:00:00',NULL,2),
('PENDENTE',2,'R654321BR','2025-09-03 15:00:00','2025-09-08 18:00:00',NULL,3),
('ENTREGUE',3,'R999999BR','2025-08-29 08:00:00','2025-09-01 18:00:00','2025-09-01 17:20:00',2),
('ENVIADO',4,'R111222BR','2025-09-06 12:00:00','2025-09-09 18:00:00',NULL,2);


INSERT INTO Pagamento (FormaPagamento, Valor, Pedido_idPedido, Status_pagamento, Valor_Parcelas, Parcelas, Data_Pagamento) VALUES
('PIX',2530.00,1,'PAGO',NULL,NULL,'2025-09-01'),
('CARTAO',3350.00,2,'PENDENTE',1675.00,2,NULL),
('PIX',1550.00,3,'PAGO',NULL,NULL,'2025-08-28'),
('PIX',209.90,4,'PAGO',NULL,NULL,'2025-09-05');


INSERT INTO Fornecedor_Produto (Fornecedor_idFornecedor, Produto_idProduto) VALUES
(1,1),
(1,4),
(2,3);


INSERT INTO Produto_Estoque (Produto_idProduto, Estoque_idEstoque, Quantidade) VALUES
(1,1,50),
(2,1,20),
(3,2,15),
(4,1,200);


INSERT INTO Pedido_Produto (Pedido_idPedido, Produto_idProduto, Quantidade, Preco_Unitario) VALUES
(1,1,1,2500.00),
(2,2,1,3200.00),
(3,3,1,1500.00),
(4,4,1,199.90);


INSERT INTO Produto_Vendedor_Terceiro (Terceiro_Vendedor_idTerceiro_Vendedor, Produto_idProduto, Quantidade) VALUES
(1,1,10),
(2,3,5),
(1,4,40);


-- 1. Clientes com idade
SELECT idCliente, Nome,
TIMESTAMPDIFF(YEAR, DataDeNascimento, CURDATE()) AS Idade
FROM Cliente
WHERE Tipo_Cliente='PF'
ORDER BY Idade DESC;

-- 2. Pedidos por cliente
SELECT c.idCliente, c.Nome, COUNT(p.idPedido) AS QtdePedidos
FROM Cliente c
JOIN Pedido p ON p.Cliente_idCliente = c.idCliente
GROUP BY c.idCliente, c.Nome
ORDER BY QtdePedidos DESC;

-- 3. Total gasto por cliente (pedido + frete)
SELECT c.idCliente, c.Nome,
SUM(pp.Quantidade*pp.Preco_Unitario + p.Frete) AS TotalGasto
FROM Cliente c
JOIN Pedido p ON p.Cliente_idCliente = c.idCliente
JOIN Pedido_Produto pp ON pp.Pedido_idPedido = p.idPedido
GROUP BY c.idCliente, c.Nome
HAVING TotalGasto > 1000
ORDER BY TotalGasto DESC;

-- 4. Produtos mais vendidos
SELECT pr.idProduto, pr.Descricao, SUM(pp.Quantidade) AS TotalVendido
FROM Pedido_Produto pp
JOIN Produto pr ON pr.idProduto = pp.Produto_idProduto
GROUP BY pr.idProduto, pr.Descricao
ORDER BY TotalVendido DESC;

-- 5. Pagamentos pendentes
SELECT p.idPedido, c.Nome AS Cliente, pg.Status_pagamento, pg.FormaPagamento, pg.Valor
FROM Pagamento pg
JOIN Pedido p ON pg.Pedido_idPedido = p.idPedido
JOIN Cliente c ON p.Cliente_idCliente = c.idCliente
WHERE pg.Status_pagamento='PENDENTE'
ORDER BY pg.Valor DESC;

-- 6. Produtos com estoque baixo
SELECT pr.idProduto, pr.Descricao, e.Local, pe.Quantidade
FROM Produto_Estoque pe
JOIN Produto pr ON pr.idProduto = pe.Produto_idProduto
JOIN Estoque e ON e.idEstoque = pe.Estoque_idEstoque
WHERE pe.Quantidade <= 20
ORDER BY pe.Quantidade ASC;

-- 7. Fornecedores e seus produtos
SELECT f.Razao_Social AS Fornecedor, pr.Descricao AS Produto
FROM Fornecedor_Produto fp
JOIN Fornecedor f ON f.idFornecedor = fp.Fornecedor_idFornecedor
JOIN Produto pr ON pr.idProduto = fp.Produto_idProduto
ORDER BY f.Razao_Social, pr.Descricao;

-- 8. Entregas atrasadas
SELECT en.idEntrega, p.idPedido, p.Descricao, en.Codigo_Rastreio, en.DataEntrega_Prevista, en.Status_Entrega
FROM Entrega en
JOIN Pedido p ON p.idPedido = en.Pedido_idPedido
WHERE en.DataEntrega_Prevista < NOW() AND en.DataEntrega_Real IS NULL
ORDER BY en.DataEntrega_Prevista ASC;

-- 9. Ticket médio por cliente
SELECT c.idCliente, c.Nome,
COUNT(DISTINCT p.idPedido) AS QtdePedidos,
SUM(pp.Quantidade*pp.Preco_Unitario + p.Frete)/COUNT(DISTINCT p.idPedido) AS TicketMedio
FROM Cliente c
JOIN Pedido p ON p.Cliente_idCliente = c.idCliente
JOIN Pedido_Produto pp ON pp.Pedido_idPedido = p.idPedido
GROUP BY c.idCliente, c.Nome
HAVING QtdePedidos >= 1
ORDER BY TicketMedio DESC;

-- 10. Tempo para envio de pedido
SELECT p.idPedido, p.Descricao, p.Data_Pedido,
en.DataEnvio,
TIMESTAMPDIFF(DAY, p.Data_Pedido, en.DataEnvio) AS DiasParaEnvio
FROM Pedido p
LEFT JOIN Entrega en ON en.Pedido_idPedido = p.idPedido
ORDER BY DiasParaEnvio ASC;

