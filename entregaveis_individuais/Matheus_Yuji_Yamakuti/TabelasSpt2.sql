create database ArmorySafe;
use ArmorySafe;

create table Cadastro (
idCadastro int primary key auto_increment,
Responsavel varchar(45) not null unique,
RA char(12) unique,
Email varchar(45),
constraint email_valido
check(email like '%@%'),
Senha varchar(45) not null unique,
TelefoneCelular char(13),
OrganizacaoMilitar varchar(45) not null,
Município varchar(30) not null,
Estado char(2) not null);

create table Arduino(
idArduino int primary key auto_increment,
instituiçãoMilitar varchar(45) not null,
Paiol varchar(45) not null);

create table Paiol(
idPaiol int primary key auto_increment,
nome varchar(45),
localizacao varchar(45),
municipio varchar(45)
estado char(2));

create table Dados (
idDados int primary key auto_increment,
DataHorário datetime default current_timestamp,
Umidade decimal (4,2));



create table TrabalheConosco (
idVagas int primary key auto_increment,
Nome varchar(60) not null unique,
Telefone varchar(30),
Email varchar(35) not null unique,
VagaPretend varchar(40) constraint chkvaga
check(VagaPretend in('Desenvolvedor', 'Suporte Técnico', 'SAC')));

insert into Cadastro values
(1, 'Militão', 000000000000, 'aaaaaaa@aaaa.com' , 'xxxxxxxx', '11 00000-0000', 'Companhia A', 'São Paulo', 'SP'),
(2, 'Jorge', 111111111111, 'bbbbbbbb@bbbb.com' ,'zzzzzzzz', '11 00000-0001', 'Organização B', 'Belo Horizonte' ,'MG');

select * from Cadastro;

select * from Cadastro
where Responsavel like '%s';

insert into Dados (Umidade) values
(49.19),
(70.45);

select * from Dados;

select DataHorário as 'Momento da Coleta',
case
when Umidade < 30 then 'Ambiente Seco'
when Umidade > 50 then 'Ambiente úmido'
else 'Ambiente Adequado'
end as 'Umidade em °C'
from Dados;

insert into TrabalheConosco values
(1, 'Joviscleison Man', '00 00000-0000', 'jovisman@mmmmm.com', 'SAC'),
(2, 'Repolhonson Dude', '11 00000-0000', 'repolhorocks@aaaaa.com', 'Desenvolvedor'),
(3, 'Batatôncio Amido', '22 00000-0000', 'comabatata@bbbbb.com', 'Suporte Técnico');

select * from TrabalheConosco;

select concat(telefone, ' ', email, ' ') as 'Dados Pessoais',
case
when VagaPretend = 'Desenvolvedor' then 'Sem vagas'
else 'Temos vagas'
end as 'Vagas Pretendidas'
from TrabalheConosco;
