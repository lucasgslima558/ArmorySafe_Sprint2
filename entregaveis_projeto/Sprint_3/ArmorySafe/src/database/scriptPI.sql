CREATE DATABASE armorysafe;

USE armorysafe;

-- Criação de tabela para comando militar

CREATE TABLE comando_militar (
	idComando_Militar INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE,
    contato VARCHAR(10) NOT NULL
);

-- Criação de tabela para endereço de OM

CREATE TABLE endereco (
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(50) NOT NULL,
    bairro VARCHAR(40) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL
);

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

-- Dados gerais

SELECT usuario.nome AS nomeUsuario,
	IFNULL(usuario.cim, 'Sem CIM') AS cim,
    usuario.senha AS senha,
    usuario.cargoUsuario AS cargoUsuario,
    cm.nome AS nomeCM,
    cm.contato AS contato,
    om.nome AS nomeOM,
    om.sigla AS sigla,
    CONCAT(endereco.logradouro, ', ', endereco.bairro, ', ', endereco.cidade, ', ', endereco.uf, ', ', endereco.cep) AS endereco,
    paiol.nome AS nomePaiol,
    paiol.capacidade AS capacidade,
    paiol.status AS statusPaiol,
    sensor.nomenclatura AS nomeSensor,
    sensor.status AS statusSensor,
    leitura.umidade AS umidade
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

SELECT om.nome AS nomeOM,
    om.sigla AS sigla,
    cm.nome AS nomeCM,
    cm.contato AS contatoCM,
    CONCAT(endereco.logradouro, ', ', endereco.bairro, ', ', endereco.cidade, ', ', endereco.uf, ', ', endereco.cep) AS endereco
	FROM organizacao_militar AS om
		JOIN comando_militar AS cm
			ON fkComando_Militar = idComando_Militar
		JOIN endereco
			ON fkEndereco = idEndereco;
    
-- Organização Militar + Soldado

SELECT usuario.nome AS nomeUsuario,
    IFNULL(usuario.cim, 'Sem CIM') AS cim,
    usuario.senha AS senha,
    usuario.cargoUsuario AS cargoUsuario,
    om.nome AS nomeOM,
    om.sigla AS sigla
	FROM usuario
		JOIN organizacao_militar AS om
			ON fkOrganizacao_Militar = idOrganizacao_Militar;

-- Organização militar + Paiol

SELECT om.nome AS nomeOM,
	om.sigla AS sigla,
    paiol.nome AS nomePaiol,
    paiol.capacidade AS capacidade,
    CASE
		WHEN paiol.status = 1 THEN 'Ativo'
        ELSE 'Inativo'
        END AS statusPaiol
	FROM organizacao_militar AS om
		JOIN paiol
			ON fkOrganizacao_Militar = idOrganizacao_Militar;

-- Paiol + Sensor + Leitura

SELECT paiol.nome AS nomePaiol,
	paiol.capacidade AS capacidade,
    CASE
		WHEN paiol.status = 1 THEN 'Ativo'
        ELSE 'Inativo'
        END AS statusPaiol,
	sensor.nomenclatura AS nomeSensor,
	CASE
		WHEN sensor.status = 1 THEN 'Ativo'
        ELSE 'Inativo'
        END AS statusSensor,
	leitura.umidade AS umidade
	FROM paiol
		JOIN sensor
			ON fkPaiol = idPaiol
		JOIN leitura
			ON fkSensor = idSensor;
            
-- Criação de Views

-- View geral

CREATE VIEW vw_geral AS
SELECT usuario.nome AS nomeUsuario,
	IFNULL(usuario.cim, 'Sem CIM') AS cim,
    usuario.senha AS senha,
    usuario.cargoUsuario AS cargoUsuario,
    cm.nome AS nomeCM,
    cm.contato AS contato,
    om.nome AS nomeOM,
    om.sigla AS sigla,
    CONCAT(end.logradouro, ', ', end.bairro, ', ', end.cidade, ', ', end.uf, ', ', end.cep) AS endereco,
    p.nome AS nomePaiol,
    p.capacidade AS capacidade,
    p.status AS statusPaiol,
    s.nomenclatura AS nomeSensor,
    s.status AS statusSensor,
    l.umidade AS umidade
	FROM usuario
		JOIN organizacao_militar AS om
			ON usuario.fkOrganizacao_Militar = om.idOrganizacao_Militar
		JOIN comando_militar AS cm
			ON om.fkComando_Militar = cm.idComando_Militar
		JOIN endereco end
			ON om.fkEndereco = end.idEndereco
		JOIN paiol p
			ON p.fkOrganizacao_Militar = om.idOrganizacao_Militar
		JOIN sensor s
			ON s.fkPaiol = p.idPaiol
		JOIN leitura l
			ON l.fkSensor = s.idSensor;
            
-- View OM, CM, Endereço

CREATE VIEW vw_om_cm_endereco AS
SELECT cm.nome AS nomeCM,
	cm.contato AS contato,
	om.nome AS nomeOM,
	om.sigla AS sigla,
    CONCAT(end.logradouro, ', ', end.bairro, ', ', end.cidade, ', ', end.uf, ', ', end.cep) AS endereco
    FROM comando_militar cm
	JOIN organizacao_militar om 
		ON cm.idComando_Militar = om.fkComando_Militar
	JOIN endereco end
		ON om.fkEndereco = end.idEndereco;
        
-- View OM, Paiol, Sensor, Leitura

CREATE VIEW vw_om_paiol_sensor_leitura AS
SELECT om.nome AS nomeOM,
	om.sigla AS sigla,
    p.nome AS nomePaiol,
    p.capacidade AS capacidade,
    p.status AS statusPaiol,
    s.nomenclatura AS nomeSensor,
    s.status AS statusSensor,
    l.umidade AS umidade,
    l.dtLeitura AS dtHoraLeitura
    FROM organizacao_militar om
    JOIN paiol p
		ON p.fkOrganizacao_Militar = om.idOrganizacao_Militar
	JOIN sensor s
		ON s.fkPaiol = p.idPaiol
	JOIN leitura l
		ON l.fkSensor = s.idSensor;

-- View para Dashboard

CREATE VIEW vw_dashboardd AS
SELECT p.nome AS nomePaiol,
	p.status AS statusPaiol,
    MAX(l.umidade) AS umidade_maxima,
	MIN(l.umidade) AS umidade_minima,
    DAY(l.dtLeitura) AS dia_leitura,
    MINUTE(l.dtLeitura) AS minuto_leitura,
    COUNT(l.idLeitura) AS quantidade_emissoes
    FROM sensor s
	JOIN leitura l
		ON l.fkSensor = s.idSensor
	JOIN paiol p
		ON s.fkPaiol = p.idPaiol
	WHERE DAY(l.dtLeitura) = DAY(CURDATE()) AND p.idPaiol = 1
	GROUP BY l.dtLeitura;
    
    SELECT * FROM vw_dashboard;
    
    -- view para ver somente umidade máxima
    CREATE VIEW vw_umidadeMaxima AS
SELECT 
    p.idPaiol,
    p.nome AS nomePaiol,
    p.status AS statusPaiol,
    MAX(l.umidade) AS umidade_maxima
FROM paiol p
JOIN sensor s ON s.fkPaiol = p.idPaiol
JOIN leitura l ON l.fkSensor = s.idSensor
WHERE DATE(l.dtLeitura) = CURDATE()
GROUP BY p.idPaiol;

SELECT * FROM vw_umidadeMaxima;