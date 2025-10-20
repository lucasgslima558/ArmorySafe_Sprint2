CREATE DATABASE armorysafe;

USE armorysafe;

-- Criação de tabela para comando militar

CREATE TABLE comando_militar (
	idComando_Militar INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE,
    contato VARCHAR(10) NOT NULL
);
	
-- Inserindo dados na tabela

INSERT INTO comando_militar (nome, contato) VALUES
	('Comando Militar da Amazônia', '99198231'),
	('Comando Militar do Leste', '34901923'),
	('Comando Militar do Nordeste', '9948382'),
	('Comando Militar do Norte', '39299112'),
	('Comando Militar do Oeste', '33321231'),
	('Comando Militar do Planalto', '998763452'),
    ('Comando Militar do Sudeste', '198534563'),
    ('Comando Militar do Sul', '945321765');

-- Criação de tabela para endereço de OM

CREATE TABLE endereco (
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(50) NOT NULL,
    bairro VARCHAR(40) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL
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
    nome VARCHAR(40) NOT NULL UNIQUE,
    sigla VARCHAR(10)
);

-- Inserindo dados na tabela

INSERT INTO organizacao_militar (fkComando_Militar, fkEndereco, nome, sigla) VALUES
	(1, 1, 'Batalhão de Suprimento', 'B Sup'),
	(2, 2, 'Base Logística do Exército', 'Ba Log Ex'),
	(3, 3, 'Regimento de Cavalaria', 'RCav'),
	(4, 4, 'Centro de Instrução de Artilharia', 'CIArt');

-- Criação de tabela de cadastro Usuário

CREATE TABLE usuario (	
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    fkOrganizacao_Militar INT,
    CONSTRAINT fkUsuario_OM
		FOREIGN KEY (fkOrganizacao_Militar)
			REFERENCES organizacao_militar (idOrganizacao_Militar),
	nome VARCHAR(80) NOT NULL,
	cim CHAR(10) UNIQUE, -- Número de Carteira de Identificação Militar
    senha VARCHAR(30) NOT NULL, -- Senha de acesso
    cargoUsuario VARCHAR(30) NOT NULL, -- Nível de acesso do militar na rede
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserindo dados na tabela

INSERT INTO usuario (fkOrganizacao_Militar, nome, cim, senha, cargoUsuario) VALUES
	(1, 'Roberto Lima', '1234567890', 'senha123', 'General'),
	(2, 'Gabriela Gomes', '0987654321', 'segura456', 'Sargento'),
	(3, 'Ronaldo Nascimento', '1122334455', 'teste789', 'Major'),
	(4, 'Victor Duarte', '5566778899', 'militar2024', 'Subtenente'),
    (4, 'Paulo Rocha', NULL, 'u7t4092pe', 'Civil');

-- Criação de tabela de paiol

CREATE TABLE paiol (
	idPaiol INT PRIMARY KEY AUTO_INCREMENT,
    fkOrganizacao_Militar INT,
    CONSTRAINT fkOM_Paiol
		FOREIGN KEY (fkOrganizacao_Militar)
			REFERENCES organizacao_militar(idOrganizacao_Militar),
	nome VARCHAR(45) NOT NULL,
    capacidade INT NOT NULL,
    status TINYINT NOT NULL,
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserindo dados na tabela

INSERT INTO paiol (fkOrganizacao_Militar, nome, capacidade, status) VALUES
	(1, 'Paiol Alpha', 100, 1),
	(2, 'Paiol Charlie', 80, 0),
	(3, 'Paiol Delta', 120, 1),
	(4, 'Paiol Omega', 60, 1);
    
-- Criação de tabela Arduino

CREATE TABLE sensor (
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    fkPaiol INT,
    CONSTRAINT fkSensor_Paiol
		FOREIGN KEY (fkPaiol)
			REFERENCES paiol (idPaiol),
	tipoSensor VARCHAR(20) NOT NULL,
	nomenclatura VARCHAR(15) NOT NULL,
    status TINYINT NOT NULL,
    dtInstalacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserindo dados na tabela

INSERT INTO sensor (fkPaiol, tipoSensor, nomenclatura, status, dtInstalacao) VALUES
	(1, 'DHT11', 'S_UMID_01', 1, '2025-02-10 08:00:00'),
	(2, 'DHT11', 'S_UMID_02', 1, '2025-03-01 09:00:00'),
	(3, 'DHT11', 'S_UMID_03', 0, '2025-03-15 10:00:00'),
	(4, 'DHT11', 'S_UMID_04', 1, '2025-04-01 11:00:00');

-- Criação de tabela Dados de Arduino

CREATE TABLE leitura (
	idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    fkSensor INT,
    CONSTRAINT fkLeitura_Sensor
		FOREIGN KEY (fkSensor)
			REFERENCES sensor (idSensor),
    umidade DECIMAL(4,2),
    CONSTRAINT chkUmidade
		CHECK (umidade >= 0 AND umidade <= 100),
    dtLeitura DATETIME
);

-- Inserindo dados na tabela

INSERT INTO leitura (fkSensor, umidade, dtLeitura) VALUES
	(1, 27.45, '2025-02-11 08:30:00'),
	(2, 26.80, '2025-03-02 10:15:00'),
	(3, 29.50, '2025-03-16 11:30:00'),
	(4, 25.90, '2025-04-02 12:00:00');
    
-- Selecionando dados do banco

-- Dados gerais
SELECT usuario.nome AS 'Nome do Usuário',
	IFNULL(usuario.cim, 'Sem CIM') AS 'Carteira de Identificação Militar',
    usuario.senha AS 'Senha (Mocada)',
    usuario.cargoUsuario AS 'Cargo do Usuário',
    cm.nome AS 'Comando responsável',
    cm.contato AS 'Contato do CM',
    om.nome AS 'Nome da OM',
    om.sigla AS 'Sigla',
    CONCAT(endereco.logradouro, ', ', endereco.bairro, ', ', endereco.cidade, ', ', endereco.uf, ', ', endereco.cep) AS 'Endereço da OM',
    paiol.nome AS 'Nome do Paiol',
    paiol.capacidade AS 'Capacidade',
    paiol.status AS 'Status do Paiol',
    sensor.nomenclatura AS 'Nomenclatura do Arduino',
    sensor.status AS 'Status do Arduino',
    leitura.umidade AS 'Umidade'
	FROM usuario
		JOIN organizacao_militar AS om
			ON usuario.fkOrganizacao_Militar = om.idOrganizacao_Militar
		JOIN comando_militar AS cm
			ON om.fkComando_Militar = cm.idComando_Militar
		JOIN endereco
			ON om.fkEndereco = endereco.idEndereco
		JOIN paiol
			ON paiol.fkOrganizacao_Militar = om.idOrganizacao_Militar
		JOIN sensor
			ON sensor.fkPaiol = paiol.idPaiol
		JOIN leitura
			ON leitura.fkSensor = sensor.idSensor;
		

-- Organização Militar + Comando + Endereço
SELECT om.nome AS 'Nome da OM',
    om.sigla AS 'Sigla',
    cm.nome AS 'Comando responsável',
    cm.contato 'Contato do CM',
    CONCAT(endereco.logradouro, ', ', endereco.bairro, ', ', endereco.cidade, ', ', endereco.uf, ', ', endereco.cep) AS 'Endereço'
	FROM organizacao_militar AS om
		JOIN comando_militar AS cm
			ON fkComando_Militar = idComando_Militar
		JOIN endereco
			ON fkEndereco = idEndereco;
    
-- Organizacao Militar + Soldado
SELECT usuario.nome AS 'Nome do Usuário',
    IFNULL(usuario.cim, 'Sem CIM') AS 'Carteira de Identificação Militar',
    usuario.senha AS 'Senha (mocada)',
    usuario.cargoUsuario AS 'Cargo do Usuário',
    om.nome AS 'Nome',
    om.sigla AS 'Sigla'
	FROM usuario
		JOIN organizacao_militar AS om
			ON fkOrganizacao_Militar = idOrganizacao_Militar;

-- Arduino + Dados do Arduino

SELECT sensor.nomenclatura AS 'Nomenclatura do Arduino',
	sensor.status AS 'Status do Arduino',
	leitura.umidade AS 'Umidade'
	FROM sensor
		JOIN leitura
			ON fkSensor = idSensor;