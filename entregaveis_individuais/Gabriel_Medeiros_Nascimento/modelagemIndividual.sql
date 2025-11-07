CREATE DATABASE ArmorySafe;

USE ArmorySafe;

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cim VARCHAR(20) UNIQUE NOT NULL,
    cargo VARCHAR(45),
    senha VARCHAR(25),
    fkOrganizacao INT,
    CONSTRAINT fkUsuarioOM
    FOREIGN KEY (id_organizacao) REFERENCES organizacao_militar(fkOrganizacao)
);

CREATE TABLE organizacao_militar(
	id_organizacao INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200),
    sigla VARCHAR(20),
    uf CHAR(2),
    telefone CHAR(11),
    logradouro VARCHAR(200),
    cep char(9),
    numero VARCHAR(10)
);

CREATE TABLE paiol (
    id_paiol INT AUTO_INCREMENT PRIMARY KEY,
	nome_paiol VARCHAR(15),
    fkOrganizacao INT,
    CONSTRAINT fkPaiolOrganizacao
    FOREIGN KEY (fkOrganizacao) REFERENCES organizacao_militar(fkOrganizacao)
);

CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45),
    local_instalado VARCHAR(45),
    fkPaiol INT,
    FOREIGN KEY (fkPaiol) REFERENCES paiol(id_paiol)
);

CREATE TABLE umidade (
    id_umidade INT AUTO_INCREMENT PRIMARY KEY,
	fkSensor INT,
    data_hora DATETIME,
    umidade DECIMAL(5,2),
    CONSTRAINT fkUmidadeSensor
    FOREIGN KEY (fkSensor) REFERENCES sensor(id_sensor)
);

CREATE TABLE alerta (
    id_alerta INT,
    fkUmidade INT,
    fkSensor INT,
    data_hora DATETIME NOT NULL,
    fkUsuario INT,
    CONSTRAINT PRIMARY KEY(id_alerta, fkUmidade, fkSensor),
    CONSTRAINT fkAlertaSensor 
    FOREIGN KEY (fkSensor) REFERENCES sensor(id_sensor),
    CONSTRAINT fkAlertaUmidade
	FOREIGN KEY (fkUmidade) REFERENCES umidade(id_umidade),
    CONSTRAINT fkAlertaUsuario
    FOREIGN KEY (fkUsuario) REFERENCES usuario(id_usuario)
);

