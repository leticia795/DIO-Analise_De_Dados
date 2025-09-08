
CREATE DATABASE IF NOT EXISTS `E-commerce` DEFAULT CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci';
USE `E-commerce`;

-- -----------------------------------------------------
-- Table Cargo
-- -----------------------------------------------------
CREATE TABLE `Cargo` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `Nome_Cargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCargo`),
  UNIQUE (`Nome_Cargo`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Funcionario
-- -----------------------------------------------------
CREATE TABLE `Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Senha` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Data_Criacao` DATETIME NOT NULL,
  `Cargo_idCargo` INT NOT NULL,
  PRIMARY KEY (`idFuncionario`),
  UNIQUE (`Email`),
  CONSTRAINT `fk_funcionario_cargo`
    FOREIGN KEY (`Cargo_idCargo`) REFERENCES `Cargo`(`idCargo`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Pnome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(100),
  `Contato` VARCHAR(20),
  `CPF` CHAR(11) UNIQUE,
  `DataDeNascimento` DATE,
  PRIMARY KEY (`idCliente`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------
CREATE TABLE `Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(100),
  `Valor` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Estoque
-- -----------------------------------------------------
CREATE TABLE `Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Local` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idEstoque`),
  UNIQUE (`Local`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Fornecedor
-- -----------------------------------------------------
CREATE TABLE `Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(100) NOT NULL,
  `CNPJ` CHAR(14) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE (`Razao_Social`),
  UNIQUE (`CNPJ`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Terceiro_Vendedor
-- -----------------------------------------------------
CREATE TABLE `Terceiro_Vendedor` (
  `idTerceiro_Vendedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(100) NOT NULL,
  `Local` VARCHAR(100),
  `Nome_Fantasia` VARCHAR(100),
  `CNPJ` CHAR(14),
  PRIMARY KEY (`idTerceiro_Vendedor`),
  UNIQUE (`Razao_Social`),
  UNIQUE (`CNPJ`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Pedido
-- -----------------------------------------------------
CREATE TABLE `Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Status_Do_Pedido` ENUM('ENVIADO','EM ANDAMENTO','EM PROCESSAMENTO','SAIU PARA ENTREGA','ENTREGUE') NOT NULL DEFAULT 'EM PROCESSAMENTO',
  `Descricao` VARCHAR(100),
  `Cliente_idCliente` INT NOT NULL,
  `Frete` DECIMAL(10,2) NOT NULL,
  `Data_Pedido` DATE NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  CONSTRAINT `fk_pedido_cliente`
    FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente`(`idCliente`),
  CONSTRAINT `fk_pedido_funcionario`
    FOREIGN KEY (`Funcionario_idFuncionario`) REFERENCES `Funcionario`(`idFuncionario`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Entrega
-- -----------------------------------------------------
CREATE TABLE `Entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `Status_Entrega` ENUM('PENDENTE','ENVIADO','ENTREGUE','ATRASADO') NOT NULL DEFAULT 'PENDENTE',
  `Pedido_idPedido` INT NOT NULL,
  `Codigo_Rastreio` VARCHAR(45) UNIQUE NOT NULL,
  `DataEnvio` DATETIME NOT NULL,
  `DataEntrega_Prevista` DATETIME NULL,
  `DataEntrega_Real` DATETIME NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idEntrega`),
  CONSTRAINT `fk_entrega_pedido`
    FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido`(`idPedido`),
  CONSTRAINT `fk_entrega_funcionario`
    FOREIGN KEY (`Funcionario_idFuncionario`) REFERENCES `Funcionario`(`idFuncionario`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Pagamento
-- -----------------------------------------------------
CREATE TABLE `Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `FormaPagamento` ENUM('PIX','BOLETO','CARTAO','TRANSFERENCIA') NOT NULL,
  `Valor` DECIMAL(10,2) NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Status_pagamento` ENUM('PENDENTE','PAGO','CANCELADO') NOT NULL DEFAULT 'PENDENTE',
  `Valor_Parcelas` DECIMAL(10,2),
  `Parcelas` INT,
  `Data_Pagamento` DATE,
  PRIMARY KEY (`idPagamento`),
  CONSTRAINT `fk_pagamento_pedido`
    FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido`(`idPedido`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabelas de associação
-- -----------------------------------------------------

-- Fornecedor x Produto
CREATE TABLE `Fornecedor_Produto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  CONSTRAINT `fk_fornecedor_produto_forn`
    FOREIGN KEY (`Fornecedor_idFornecedor`) REFERENCES `Fornecedor`(`idFornecedor`),
  CONSTRAINT `fk_fornecedor_produto_prod`
    FOREIGN KEY (`Produto_idProduto`) REFERENCES `Produto`(`idProduto`)
) ENGINE = InnoDB;

-- Produto x Estoque
CREATE TABLE `Produto_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  CONSTRAINT `fk_produto_estoque_prod`
    FOREIGN KEY (`Produto_idProduto`) REFERENCES `Produto`(`idProduto`),
  CONSTRAINT `fk_produto_estoque_est`
    FOREIGN KEY (`Estoque_idEstoque`) REFERENCES `Estoque`(`idEstoque`)
) ENGINE = InnoDB;

-- Pedido x Produto
CREATE TABLE `Pedido_Produto` (
  `Pedido_idPedido` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  `Status` ENUM('DISPONIVEL','EM ESTOQUE') NOT NULL DEFAULT 'DISPONIVEL',
  PRIMARY KEY (`Pedido_idPedido`, `Produto_idProduto`),
  CONSTRAINT `fk_pedido_produto_ped`
    FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido`(`idPedido`),
  CONSTRAINT `fk_pedido_produto_prod`
    FOREIGN KEY (`Produto_idProduto`) REFERENCES `Produto`(`idProduto`)
) ENGINE = InnoDB;

-- Produto x Terceiro_Vendedor
CREATE TABLE `Produto_Vendedor_Terceiro` (
  `Terceiro_Vendedor_idTerceiro_Vendedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Terceiro_Vendedor_idTerceiro_Vendedor`, `Produto_idProduto`),
  CONSTRAINT `fk_terceiro_produto_vend`
    FOREIGN KEY (`Terceiro_Vendedor_idTerceiro_Vendedor`) REFERENCES `Terceiro_Vendedor`(`idTerceiro_Vendedor`),
  CONSTRAINT `fk_terceiro_produto_prod`
    FOREIGN KEY (`Produto_idProduto`) REFERENCES `Produto`(`idProduto`)
) ENGINE = InnoDB;





