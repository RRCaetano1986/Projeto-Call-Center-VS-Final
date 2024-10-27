/*Criação da tabela Fato_Atendimento
USE backup;
CREATE TABLE Fato_Atendimento (
    AtendimentoID INT PRIMARY KEY,
    ClienteID INT,
    AgenteID INT,
    TempoID INT,
    CanalID INT,
    CategoriaID INT,
    DuracaoAtendimento INT,
    Nivel_Satisfacao FLOAT,
    Resolvido CHAR(1),
    Tempo_Espera FLOAT,
    Numero_Chamadas INT,
    Primeiro_Atendimento CHAR(1),
    Data_Criacao DATETIME,
    Data_Alteracao DATETIME,
    Usuario_Criacao VARCHAR(255),
    Usuario_Alteracao VARCHAR(255),
    INDEX idx_cliente (ClienteID),
    INDEX idx_agente (AgenteID),
    INDEX idx_tempo (TempoID),
    INDEX idx_canal (CanalID),
    INDEX idx_categoria (CategoriaID),
    INDEX idx_duracao_atendimento (Duracao_Atendimento),
    INDEX idx_nivel_satisfacao (Nivel_Satisfacao),
    INDEX idx_resolvido (Resolvido),
    INDEX idx_data_criacao (Data_Criacao),
    INDEX idx_data_alteracao (Data_Alteracao),
    FOREIGN KEY (ClienteID) REFERENCES DIM_Cliente(ClienteID),
    FOREIGN KEY (AgenteID) REFERENCES DIM_Agente(AgenteID),
    FOREIGN KEY (TempoID) REFERENCES DIM_Tempo(TempoID),
    FOREIGN KEY (CanalID) REFERENCES DIM_Canal_Atendimento(CanalID),
    FOREIGN KEY (CategoriaID) REFERENCES DIM_Categoria_Atendimento(CategoriaID)
    
);

-removi chave estrangeira pra criar com auto incremento
ALTER TABLE fato_atendimento
DROP FOREIGN KEY fato_atendimento_ibfk_1;

ALTER TABLE fato_atendimento
DROP FOREIGN KEY fato_atendimento_ibfk_2;

ALTER TABLE Fato_Atendimento
DROP FOREIGN KEY fato_atendimento_ibfk_3; 

ALTER TABLE fato_atendimento
DROP FOREIGN KEY fato_atendimento_ibfk_4;
);*/

/*Criação da tabela DIM_Cliente
	USE backup;
	CREATE TABLE DIM_Cliente (
		ClienteID INT PRIMARY KEY,
		Nome VARCHAR(255),
		CPF_CNPJ VARCHAR(20),
		DataNascimento DATE,  -- Nome correto da coluna para Data de Nascimento
		Sexo VARCHAR(10),
		Endereco VARCHAR(255),
		Estado VARCHAR(50),
		Cidade VARCHAR(50),
		Telefone VARCHAR(20),
		Email VARCHAR(100),  -- Email com letra maiúscula inicial
		Data_Criacao DATETIME,
		Data_Alteracao DATETIME,
		Usuario_Criacao VARCHAR(255),
		Usuario_Alteracao VARCHAR(255),
		Ativo CHAR(1),
		Data_Inicio_Vigente DATETIME,  -- Nome correto
		Data_Fim_Vigente DATETIME,  -- Nome correto
		INDEX idx_data_criacao (Data_Criacao),
		INDEX idx_data_alteracao (Data_Alteracao)
	);
    */

/*Criação da tabela DIM_Agente
use backup;
CREATE TABLE DIM_Agente (
    AgenteID INT PRIMARY KEY,
    Nome VARCHAR(255),
    CPF VARCHAR(20),
    Data_Contratacao DATE,
    Departamento VARCHAR(100),
    Turno VARCHAR(50),
    Supervisor VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Data_Criacao DATETIME,
    Data_Alteracao DATETIME,
    Usuario_Criacao VARCHAR(255),
    Usuario_Alteracao VARCHAR(255),
	Ativo CHAR(1),
    Data_Inicio_Vigente DATETIME,
    Data_Fim_Vigente DATETIME,
    INDEX idx_data_criacao (Data_Criacao),
    INDEX idx_data_alteracao (Data_Alteracao)
);
*/

/*Criação da tabela DIM_Tempo
USE backup;
CREATE TABLE DIM_Tempo (
    TempoID INT PRIMARY KEY AUTO_INCREMENT, -- TempoID com auto incremento
    Data DATE, -- Data completa
    Dia_Semana VARCHAR(10), -- Nome do dia da semana (segunda, terça, etc.)
    Dia INT, -- Dia do mês (1 a 31)
    Mes VARCHAR(10), -- Nome do mês (janeiro, fevereiro, etc.)
    Numero_Mes INT, -- Número do mês (1 a 12)
    Ano INT, -- Ano
    Bimestre INT, -- Bimestre (1 a 6)
    Trimestre INT, -- Trimestre (1 a 4)
    Semestre INT, -- Semestre (1 ou 2)
    INDEX idx_data (Data) -- Índice para otimizar buscas pela data
);

DESCRIBE DIM_Tempo;
*/

/*Criação da tabela DIM_Canal_Atendimento
USE backup;
CREATE TABLE DIM_Canal_Atendimento (
    CanalID INT PRIMARY KEY AUTO_INCREMENT,  -- CanalID com auto incremento
    ClienteID INT,  -- Adicionar ClienteID para relacionamento
    Nome_Canal VARCHAR(255),
    Plataforma VARCHAR(255),
    Data_Criacao DATETIME,
    Data_Alteracao DATETIME,
    Usuario_Criacao VARCHAR(255),
    Usuario_Alteracao VARCHAR(255),
    INDEX idx_cliente_id (ClienteID),  -- Índice para melhorar consultas por ClienteID
    INDEX idx_data_criacao (Data_Criacao),
    INDEX idx_data_alteracao (Data_Alteracao),
    CONSTRAINT fk_cliente FOREIGN KEY (ClienteID) REFERENCES DIM_Cliente(ClienteID)  -- Chave estrangeira para DIM_Cliente
);*/

/*Criação da tabela DIM_Categoria_Atendimento
use backup;
CREATE TABLE DIM_Categoria_Atendimento (
    CategoriaID INT PRIMARY KEY,
    Nome_Categoria VARCHAR(255),
    Prioridade INT,
    Data_Criacao DATETIME,
    Data_Alteracao DATETIME,
    Usuario_Criacao VARCHAR(255),
    Usuario_Alteracao VARCHAR(255),
    INDEX idx_data_criacao (Data_Criacao),
    INDEX idx_data_alteracao (Data_Alteracao)
);
*/

/*DROPS
-- Remover a tabela Fato_Atendimento
use backup; DROP TABLE IF EXISTS Fato_Atendimento;

-- Remover a tabela DIM_Cliente
use backup; DROP TABLE IF EXISTS DIM_Cliente;

-- Remover a tabela DIM_Agente
use backup; DROP TABLE IF EXISTS DIM_Agente;

-- Remover a tabela DIM_Tempo
use backup; DROP TABLE IF EXISTS DIM_Tempo;

-- Remover a tabela DIM_Canal_Atendimento
use backup; DROP TABLE IF EXISTS dim_canal_atendimento;

-- Remover a tabela DIM_Categoria_Atendimento
use backup; DROP TABLE IF EXISTS DIM_Categoria_Atendimento;
*/

/*Verificando as tabelas 
-- dim_tempo 2 anos de operação de 02/01/2020 a 31/12/2023
SELECT 
    MIN(Data) AS Data_Minima,
    MAX(Data) AS Data_Maxima
FROM dim_tempo;

--dim_cliente 2000 clientes atendidos
SELECT * 
FROM dim_cliente;

-dim_canal_atendimento 2000 canalid gerados de acordo com canal, plaforma e data.
SELECT *
FROM dim_canal_atendimento;

-dim_canal_atendimento 2000 categoriaid gerados 
SELECT *
FROM dim_categoria_atendimento;

SELECT * FROM DIM_Agente;

SELECT COUNT(*) FROM backup.Fato_Atendimento;

*/
