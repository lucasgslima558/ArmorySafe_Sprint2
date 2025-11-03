CREATE DATABASE ArmorySafe;
USE ArmorySafe;

CREATE TABLE organizacao_militar(
	id_organizacao INT AUTO_INCREMENT PRIMARY KEY,
    nome_organizacao VARCHAR(45),
    sigla VARCHAR(20),
    uf CHAR(2),
    comandante_responsavel VARCHAR(45),
    telefone CHAR(11)
);

CREATE TABLE militar (
    id_militar INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    matricula VARCHAR(20) UNIQUE NOT NULL,
    funcao VARCHAR(45),
    senha VARCHAR(25),
    id_organizacao INT,
    FOREIGN KEY (id_organizacao) REFERENCES organizacao_militar(id_organizacao)
);

CREATE TABLE lote_municao (
    id_lote INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(30) UNIQUE NOT NULL,
    tipoMunicao VARCHAR(45),
    quantidade INT,
    dataRecebimento DATE,
    validade DATE,
    local_armazenamento VARCHAR(50),
    id_organizacao INT,
    FOREIGN KEY (id_organizacao) REFERENCES organizacao_militar(id_organizacao)
);

CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45),
    local_instalado VARCHAR(45),
    id_lote INT,
    FOREIGN KEY (id_lote) REFERENCES lote_municao(id_lote)
);

CREATE TABLE leitura_umidade (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT,
    id_lote INT,
    data_hora DATETIME,
    umidade DECIMAL(5,2),
    FOREIGN KEY (id_sensor) REFERENCES sensor(id_sensor),
    FOREIGN KEY (id_lote) REFERENCES lote_municao(idLote)
);

CREATE TABLE alerta (
    id_alerta INT PRIMARY KEY,
    id_leitura INT,
    descricao VARCHAR(100),
    data_alerta DATETIME NOT NULL,
    id_militar_responsavel INT,
    FOREIGN KEY (id_leitura) REFERENCES leitura_umidade(id_leitura),
    FOREIGN KEY (id_militar_responsavel) REFERENCES militar(id_militar)
);