use Concessionaria
go


CREATE TABLE Ano
( 
idAno tinyint identity(1,1)
, ano smallint not null 
, constraint pkAno primary key (idAno)
)
go


CREATE TABLE Fabricante
( 
idFabricante       tinyint identity(1,1)
, Nome               varchar(50) not null 
, endereco           varchar(100) null 
, cidade             varchar(50) not null 
, UF                 char(2) null 
, telefone           varchar(20) null 
, contato            varchar(50) not null
, constraint pkFabricante primary key (idFabricante)
)
go

CREATE TABLE Mes
( 
idMes        tinyint identity (15, 3) 
, mes        tinyint  not null 
, constraint pkMes primary key (idMes)
)
go

CREATE TABLE Modelo
( 
idModelo           smallint identity(1,1)
, descricao          varchar(50) not null 
, constraint pkModelo primary key (idModelo)
)
go

CREATE TABLE Veiculo
( 
idVeiculo          smallint identity(1,1)
, descricao          varchar(50) not null
, valor              decimal(9,2)not null
, dataCompra date not null
, idModelo           smallint null 
, idFabricante       tinyint  null 
, idAnoFabricacao    tinyint  null 
, constraint pkVeiculo primary key (idVeiculo)
, constraint fkVeiculo_idModelo foreign key (idModelo) references Modelo(idModelo)
, constraint fkVeiculo_idFabricante foreign key (idFabricante) references Fabricante(idFabricante)
, constraint fkVeiculo_idAnoFabricacao foreign key (idAnoFabricacao) references Ano(idAno)
)
go

CREATE TABLE VendasAnuais
( 
idVendas           smallint identity (1,1)
, qtd                smallint not null 
, idVeiculo          smallint  null 
, idAnodaVenda       tinyint  null 
, idMesdaVenda       tinyint  null 
, constraint pkVendasAnuais primary key (idVendas)
, constraint fkVendasAnuais_idVeiculo foreign key (idVeiculo) references Veiculo(idVeiculo)
, constraint fkVendasAnuais_idAnodaVenda foreign key (idAnodaVenda) references Ano(idAno)
, constraint fkVendasAnuais_idMesdaVenda foreign key (idMesdaVenda) references Mes(idMes)
)
go

/*
-- Selects
select * from Fabricante
select * from Modelo
select * from Ano
select * from Mes
select * from VendasAnuais
select * from Veiculo
select * from Ano

*/

alter table Modelo Drop Constraint ckDescricao
alter table Modelo add Constraint ckDescricao()