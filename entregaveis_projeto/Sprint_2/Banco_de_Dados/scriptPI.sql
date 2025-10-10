CREATE DATABASE projetopi;

USE projetopi;

-- Criação de tabela para comando militar

CREATE TABLE comando_militar (
	idComando_Militar INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50)
);

-- Inserindo dados na tabela

INSERT INTO comando_militar (nome) VALUES
	('Comando Militar da Amazônia'),
	('Comando Militar do Leste'),
	('Comando Militar do Nordeste'),
	('Comando Militar do Norte'),
	('Comando Militar do Oeste'),
	('Comando Militar do Planalto'),
    ('Comando Militar do Sudeste'),
    ('Comando Militar do Sul');

-- Criação de tabela para endereço de OM

CREATE TABLE endereco (
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(50),
    bairro VARCHAR(40),
    cidade VARCHAR(40),
    uf CHAR(2),
    cep CHAR(8)
);

-- Inserindo dados na tabela

INSERT INTO endereco (logradouro, bairro, cidade, uf, cep) VALUES
	('Rua das Acácias', 'Centro', 'Brasília', 'DF', '70000000'),
	('Av. Getúlio Vargas', 'São Pedro', 'Rio de Janeiro', 'RJ', '20000000'),
	('Rua XV de Novembro', 'Centro', 'Curitiba', 'PR', '80000000'),
	('Av. Independência', 'Bela Vista', 'São Paulo', 'SP', '01000000');

-- Criação de tabela para organização militar

CREATE TABLE organizacao_militar (
	idOrganizacao_Militar INT PRIMARY KEY AUTO_INCREMENT,
    fkComando_Militar INT,
    CONSTRAINT fkOM_CM
		FOREIGN KEY (fkComando_Militar)
			REFERENCES comando_militar (idComando_Militar),
	fkEndereco INT,
	CONSTRAINT fkOM_Endereco
		FOREIGN KEY (fkEndereco)
			REFERENCES endereco (idEndereco),
    nome VARCHAR(40),
    sigla VARCHAR(10)
);

-- Inserindo dados na tabela

INSERT INTO organizacao_militar (fkComando_Militar, fkEndereco, nome, sigla) VALUES
	(1, 1, 'Batalhão de Suprimento', 'B Sup'),
	(2, 2, 'Base Logística do Exército', 'Ba Log Ex'),
	(3, 3, 'Regimento de Cavalaria', 'RCav'),
	(4, 4, 'Centro de Instrução de Artilharia', 'CIArt');

-- Criação de tabela de cadastro Militar

CREATE TABLE militar (	
	idMilitar INT PRIMARY KEY AUTO_INCREMENT,
    fkOrganizacao_Militar INT,
    CONSTRAINT fkMilitar_OM
		FOREIGN KEY (fkOrganizacao_Militar)
			REFERENCES organizacao_militar (idOrganizacao_Militar),
	cim CHAR(10), -- Número de Carteira de Identificação Militar
    senha VARCHAR(30), -- Senha de acesso
    cargoUsuario VARCHAR(30), -- Nível de acesso do militar na rede
    sexo CHAR(1),
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserindo dados na tabela

INSERT INTO militar (fkOrganizacao_Militar, cim, senha, cargoUsuario, sexo) VALUES
	(1, '1234567890', 'senha123', 'Administrador', 'M'),
	(2, '0987654321', 'segura456', 'Operador', 'F'),
	(3, '1122334455', 'teste789', 'Técnico', 'M'),
	(4, '5566778899', 'militar2024', 'Supervisor', 'F');

-- Criação de tabela de lote

CREATE TABLE lote (
	idLote INT PRIMARY KEY AUTO_INCREMENT,
    fkOrganizacao_Militar INT,
    CONSTRAINT fkLote_OM
		FOREIGN KEY (fkOrganizacao_Militar)
			REFERENCES organizacao_militar (idOrganizacao_Militar),
	paiol VARCHAR(45),
    qtdCaixa INT,
    calibre VARCHAR(10) NOT NULL,
    marcacao VARCHAR(11),
    CONSTRAINT chkMarcacao
		CHECK (marcacao IN('A','R','REP','INSP','PKD','DES','COND','US/T','TESTED','FAILED TEST')),
    condicao VARCHAR(45),
    CONSTRAINT chkCondicao
		CHECK (condicao IN('A1','A2','A3','B1','B2','B3','B4','C1','C2','C3','C4','C5','D1','D2','D3')),
    dtRecebimento DATETIME,
    dtFabricacao DATE,
    dtVerificacao DATETIME
);

-- Inserindo dados na tabela

INSERT INTO lote (fkOrganizacao_Militar, paiol, qtdCaixa, calibre, marcacao, condicao, dtRecebimento, dtFabricacao, dtVerificacao) VALUES
	(1, 'Paiol 1', 50, '5.56mm', 'A', 'A1', '2025-01-15 08:00:00', '2023-12-01', '2025-02-01 09:30:00'),
	(2, 'Paiol 2', 30, '7.62mm', 'R', 'B2', '2025-02-20 10:00:00', '2024-05-15', '2025-03-05 11:00:00'),
	(3, 'Paiol 3', 70, '9mm', 'INSP', 'C1', '2025-03-10 09:15:00', '2024-10-10', '2025-04-12 08:45:00'),
	(4, 'Paiol 4', 40, '12mm', 'PKD', 'B1', '2025-04-05 14:30:00', '2024-07-01', '2025-05-01 15:00:00');
    
-- Criação de tabela Arduino

CREATE TABLE arduino (
	idArduino INT PRIMARY KEY AUTO_INCREMENT,
    fkLote INT,
    CONSTRAINT fkArduino_Lote
		FOREIGN KEY (fkLote)
			REFERENCES lote (idLote),
	nomenclatura VARCHAR(15) NOT NULL,
    ativo TINYINT,
    dtInstalacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserindo dados na tabela

INSERT INTO arduino (fkLote, nomenclatura, ativo, dtInstalacao) VALUES
	(1, 'ARD001', 1, '2025-02-10 08:00:00'),
	(2, 'ARD002', 1, '2025-03-01 09:00:00'),
	(3, 'ARD003', 0, '2025-03-15 10:00:00'),
	(4, 'ARD004', 1, '2025-04-01 11:00:00');

-- Criação de tabela Dados de Arduino

CREATE TABLE dadosArduino (
	idDados_Arduino INT PRIMARY KEY AUTO_INCREMENT,
    fkArduino INT,
    CONSTRAINT fkDadosArduino_Arduino
		FOREIGN KEY (fkArduino)
			REFERENCES arduino (idArduino),
	temperatura DECIMAL(5,2),
    umidade DECIMAL(4,2),
    dtCaptura DATETIME
);

-- Inserindo dados na tabela

INSERT INTO dadosArduino (fkArduino, temperatura, umidade, dtCaptura) VALUES
	(1, 27.45, 65.20, '2025-02-11 08:30:00'),
	(1, 28.10, 63.90, '2025-02-11 09:00:00'),
	(2, 26.80, 61.50, '2025-03-02 10:15:00'),
	(3, 29.50, 58.70, '2025-03-16 11:30:00'),
	(4, 25.90, 70.10, '2025-04-02 12:00:00');