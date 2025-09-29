/*

	Grupo 09

	Gabriel Medeiros Nascimento
    Larissa Rocha Dias
    Lucas Gomes Souza Lima
    Lucas Santos Máximo
    Matheus Yuji Yamakuti
    Murilo Marinho Suzuki

*/

-- Criando Database de projeto

CREATE DATABASE projetoPI;

USE projetoPI;

-- Criação da tabela "Comando Militar"
-- Responsável pelos dados do comando regional

CREATE TABLE comando_militar (
	idCM INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40) -- Nome do comando
);

-- Criação de tabela "Organização Militar"
-- Responsável pelos dados do batalhão/base/comando/outros.

CREATE TABLE organizacao_militar (
	idOM INT PRIMARY KEY AUTO_INCREMENT,
    fkCM INT, -- Foreign Key da tabela Comando Militar,
    nome VARCHAR(40) NOT NULL, -- Nome da sede
    
);

-- Criação de tabela "Militar"
-- Utilizada no cadastro de militares que farão uso da plataforma web

CREATE TABLE militar (
	idMilitar INT PRIMARY KEY AUTO_INCREMENT,
    fkOM INT, -- Foreign Key da tabela Organização Militar
    cim CHAR(10) NOT NULL, -- Número de identidade militar
    senha VARCHAR(30) NOT NULL, --  Senha de login
    cargoUsuario VARCHAR(30) NOT NULL, -- Nível do cargo do militar
    sexo CHAR(1), -- Sexo do militar, cadastrado como "F" ou "M"
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP -- Data e hora do cadastro
);