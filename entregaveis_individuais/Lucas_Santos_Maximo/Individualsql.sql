
CREATE DATABASE armorysafe; 

USE armorysafe; 

CREATE TABLE umidade( 
idumidade INT PRIMARY KEY AUTO_INCREMENT, 
dtCaptura DATETIME DEFAULT CURRENT_TIMESTAMP, 
qtUmidade DECIMAL(5,2) NOT NULL, 
organizacao VARCHAR(40) NOT NULL, 
paiol VARCHAR(40), 
comando VARCHAR(30) 
);

CREATE TABLE lote( 
idlote INT PRIMARY KEY AUTO_INCREMENT, 
lotecol VARCHAR(45), 
numLote VARCHAR(10) NOT NULL UNIQUE, 
qtdCaixa INT, 
comando VARCHAR(30) NOT NULL, 
paiol VARCHAR(40) NOT NULL, 
calibre VARCHAR(10) NOT NULL, 
dtRecebimento DATETIME,
dtFabricacao DATE, 
dtExame DATETIME, 
marcacao VARCHAR(11) DEFAULT 'TESTED', 
CONSTRAINT chk_mark CHECK(marcacao IN('A','R','REP','INSP','PKD','DES','COND','US/T','TESTED','FAILED TEST')), 
condicao CHAR(2) DEFAULT 'A1', 
CONSTRAINT chk_cond CHECK(condicao IN('A1','A2','A3','B1','B2','B3','B4','C1','C2','C3','C4','C5','D1','D2','D3')), 
umidade_idumidade INT, 
CONSTRAINT fk_lote_umidade FOREIGN KEY (umidade_idumidade)
    REFERENCES umidade(idumidade)
    ON DELETE SET NULL ON UPDATE CASCADE 
);


CREATE TABLE cadastro( 
idcadastro INT PRIMARY KEY AUTO_INCREMENT, 
cim CHAR(10) NOT NULL UNIQUE, 
senha VARCHAR(30) NOT NULL, 
dtCriacao DATETIME DEFAULT CURRENT_TIMESTAMP, 
tipUsuario VARCHAR(30) NOT NULL, 
CONSTRAINT chk_tip CHECK(tipUsuario IN('Praça','Subalterno','Superior')), 
organizacao VARCHAR(40) NOT NULL, 
comando VARCHAR(30) NOT NULL, 
sexo CHAR(1), 
CONSTRAINT chk_sex CHECK(sexo IN('M','F')), 
lote_idlote INT, -- FK PARA LOTE
CONSTRAINT fk_cadastro_lote FOREIGN KEY (lote_idlote)
    REFERENCES lote(idlote)
    ON DELETE SET NULL ON UPDATE CASCADE 
);


CREATE TABLE paiol( 
idPaiol INT PRIMARY KEY AUTO_INCREMENT, 
nome VARCHAR(45) NOT NULL, 
localizacao VARCHAR(60), 
municipio VARCHAR(40), 
estado CHAR(2) 
);


CREATE TABLE arduino( 
idArduino INT PRIMARY KEY AUTO_INCREMENT, 
instituicaoMilitar VARCHAR(45) NOT NULL, 
idPaiol INT NOT NULL, 
CONSTRAINT fk_arduino_paiol FOREIGN KEY (idPaiol)
    REFERENCES paiol(idPaiol)
    ON DELETE CASCADE ON UPDATE CASCADE 
);



INSERT INTO paiol (nome, localizacao, municipio, estado) VALUES
('Paiol Central', 'Área Militar A', 'São Paulo', 'SP'),
('Paiol Bravo', 'Área Militar B', 'Campinas', 'SP'),
('Paiol Delta', 'Base Oeste', 'Ribeirão Preto', 'SP');

INSERT INTO umidade (qtUmidade, organizacao, paiol, comando) VALUES
(45.20, '12º BI', 'Paiol Central', 'CMSE'),
(63.50, '7º BIB', 'Paiol Bravo', 'CMS'),
(38.90, '9º BEC', 'Paiol Delta', 'CMN');

INSERT INTO lote (numLote, qtdCaixa, comando, paiol, calibre, dtRecebimento, dtFabricacao, dtExame, marcacao, condicao, umidade_idumidade) VALUES
('L2025A001', 12, 'CMSE', 'Paiol Central', '7.62mm', '2025-02-10 09:30:00', '2023-05-12', '2025-02-15 14:00:00', 'TESTED', 'A1', 1),
('L2025A002', 8, 'CMS', 'Paiol Bravo', '5.56mm', '2025-03-05 11:00:00', '2022-10-11', '2025-03-10 08:00:00', 'INSP', 'B2', 2);

INSERT INTO cadastro (cim, senha, tipUsuario, organizacao, comando, sexo, lote_idlote) VALUES
('9283746150', 'senha123', 'Praça', '12º BI', 'CMSE', 'M', 1),
('4819273650', 'forca2025', 'Subalterno', '7º BIB', 'CMS', 'F', 2),
('7391825460', 'senhaSegura', 'Superior', '9º BEC', 'CMN', 'M', NULL);

INSERT INTO arduino (instituicaoMilitar, idPaiol) VALUES
('12º BI', 1),
('7º BIB', 2),
('9º BEC', 3);



SELECT * FROM cadastro;


SELECT * FROM lote WHERE qtdCaixa > 10;


SELECT * FROM umidade WHERE qtUmidade > 60;


SELECT * FROM paiol;


SELECT * FROM arduino;


SELECT 
    numLote AS 'LOTE',
    CASE 
        WHEN condicao LIKE 'A%' THEN 'Excelente Condição'
        WHEN condicao LIKE 'B%' THEN 'Boa Condição'
        WHEN condicao LIKE 'C%' THEN 'Regular'
        ELSE 'Precisa de Inspeção'
    END AS 'SITUAÇÃO ATUAL'
FROM lote;


SELECT 
    cim AS 'IDENTIDADE MILITAR',
    CASE
        WHEN tipUsuario = 'Praça' THEN 'Baixa patente'
        WHEN tipUsuario = 'Subalterno' THEN 'Média patente'
        WHEN tipUsuario = 'Superior' THEN 'Alta patente'
    END AS 'CATEGORIA HIERÁRQUICA'
FROM cadastro;


