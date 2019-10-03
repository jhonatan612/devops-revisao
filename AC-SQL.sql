CREATE TABLE Usuario (
 ID INT NOT NULL IDENTITY PRIMARY KEY,
 login VARCHAR(12) UNIQUE,
 Senha VARCHAR(16),
 DtExpiracao DATETIME DEFAULT (1900-01-01),
 )

 CREATE TABLE Coordenador (
 ID int NOT NULL IDENTITY PRIMARY KEY,
 Nome VARCHAR (50) NOT NULL,
 Email VARCHAR UNIQUE,
 Celular SMALLINT UNIQUE,
 Id_usuario int FOREIGN KEY REFERENCES Usuario(ID)
)
 
 CREATE TABLE Aluno (
 ID int NOT NULL IDENTITY PRIMARY KEY,
 Nome VARCHAR (50) NOT NULL,
 Email VARCHAR UNIQUE,
 Celular SMALLINT UNIQUE,
 RA smallint,
 Foto TEXT,
 Id_usuario int FOREIGN KEY REFERENCES Usuario(ID)
 )
 
 CREATE TABLE Professor(
 ID int NOT NULL IDENTITY PRIMARY KEY,
 Email VARCHAR UNIQUE,
 Celular SMALLINT UNIQUE,
 Apelido varchar(15),
 Id_usuario int FOREIGN KEY REFERENCES Usuario(ID)
 )

 ----------------------------------------------------------------------------------
 CREATE TABLE Disciplina(
 ID int NOT NULL IDENTITY PRIMARY KEY,
 Nome VARCHAR UNIQUE,
 Data DATE DEFAULT GETDATE(),
 Status VARCHAR CHECK (status= 'Aberta' or status='Não aberta') DEFAULT 'Aberta',
 PlanoDeEnsino VARCHAR,
 CargaHoraria TINYINT CHECK(CargaHoraria= 40 or CargaHoraria= 80),
 Competencias VARCHAR,
 Habilidades VARCHAR,
 Ementa VARCHAR,
 ConteudoProgramatico VARCHAR,
 BibliografiaBasica VARCHAR,
 BibliografiaComplementar VARCHAR,
 PercentualPratico TINYINT CHECK (PercentualPratico >=00 and PercentualPratico <= 100),
 PercentualTeorico TINYINT CHECK (PercentualTeorico >=00 and PercentualTeorico <= 100),
 IdCoordenador int FOREIGN KEY REFERENCES Coordenador(ID)
 )

----------------------------------------------------------------------------------
CREATE TABLE Curso(
id int not null IDENTITY PRIMARY KEY,
nome varchar(16) UNIQUE
)

CREATE TABLE DisciplinaOfertada(
id int not null IDENTITY PRIMARY KEY,
id_coordenador int FOREIGN KEY REFERENCES Coordenador(ID),
id_disciplina int FOREIGN KEY REFERENCES Disciplina(ID),
id_curso int FOREIGN KEY REFERENCES Curso(ID),
id_professor int FOREIGN KEY REFERENCES Professor(ID) DEFAULT null,
ano tinyint CHECK (ano >=1900 AND ano <=2100),
semestre tinyint CHECK (semestre = 1 OR semestre = 2),
turma varchar(1) CHECK (turma >= 'A' AND turma <= 'Z'),
dt_inicio_matricula datetime DEFAULT null,
dt_fim_matricula datetime DEFAULT null,
metodologia datetime DEFAULT null,
recursos varchar(16) DEFAULT null,
criterio_avaliacao varchar(16) DEFAULT null,
plano_de_aulas varchar(16) DEFAULT null
)

----------------------------------------------------------------------------------
CREATE TABLE SolicitacaoMatricula (
ID int NOT NULL IDENTITY,
IdAluno int NOT NULL FOREIGN KEY REFERENCES Aluno(ID),
IdDisciplinaOfertada int NOT NULL FOREIGN KEY REFERENCES DisciplinaOfertada(ID),
DtSolicitacao DATETIME default current_timestamp,
IdCoordenador int NULL FOREIGN KEY REFERENCES Coordenador(ID),
Status varchar CHECK (status = 'Solicitada' OR status = 'Aprovada' OR status = 'Rejeitada' OR status = 'Cancelada') DEFAULT 'Solicitada'
)

----------------------------------------------------------------------------------
CREATE TABLE Atividade(
id int not null IDENTITY PRIMARY KEY,
titulo varchar(16) UNIQUE,
descricao TEXT,
conteudo TEXT,
tipo varchar(16) CHECK (tipo= 'Resposta Aberta' or tipo='Teste'),
extras TEXT,
id_professor int FOREIGN KEY REFERENCES Professor(ID)
)

CREATE TABLE AtividadeVinculada(
id int not null IDENTITY PRIMARY KEY,
id_atividade int FOREIGN KEY REFERENCES Atividade(id) UNIQUE,
id_professor int FOREIGN KEY REFERENCES Professor(ID),
id_disciplinaofertada int FOREIGN KEY REFERENCES DisciplinaOfertada(id) UNIQUE,
rotulo varchar(6) UNIQUE,
status varchar(16) CHECK (status = 'Disponibilizada' OR status = 'Aberta' OR status = 'Fechada' OR status = 'Encerrada' OR status = 'Prorrogada'),
dt_inicio_respostas datetime,
dt_fim_respostas datetime
)

----------------------------------------------------------------------------------
CREATE TABLE Entrega (
ID int NOT NULL IDENTITY PRIMARY KEY,
IdAluno int NOT NULL FOREIGN KEY REFERENCES Aluno(ID),
IdAtividadeVinculada int NOT NULL FOREIGN KEY REFERENCES AtividadeVinculada(ID),
Titulo TEXT,
Resposta TEXT,
DtEntrega DATETIME default current_timestamp,
Status varchar CHECK (Status= 'Entregue' or Status= 'Corrigido') DEFAULT 'Entregue',
Idprofessor int NULL FOREIGN KEY REFERENCES Professor(ID),
Nota smallint CHECK ( Nota >= 0.00 and nota<= 10.00),
DtAvaliacao datetime,
Obs TEXT,
)


CREATE TABLE Mensagem (
ID int NOT NULL IDENTITY PRIMARY KEY,
IdAluno int NOT NULL FOREIGN KEY REFERENCES Aluno(ID),
IdProfessor int NOT NULL FOREIGN KEY REFERENCES Professor(ID),
Assunto VARCHAR,
Referência VARCHAR,
Conteúdo VARCHAR,
Status VARCHAR CHECK (Status= 'Enviado' or Status= 'Lido' or Status= 'Respondido') DEFAULT 'Enviado',
DtEnvio DATETIME default current_timestamp,
)



---IDENTITY deve ser usado após o ID? E é necessário NOT NULL em todos os id's?