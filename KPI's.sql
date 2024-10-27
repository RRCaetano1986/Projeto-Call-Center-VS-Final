
/*--1 - Tempo Médio de Espera por Canal
SELECT c.Nome_Canal, AVG(f.Tempo_Espera) AS Tempo_Medio_Espera
FROM backup.fato_atendimento f
JOIN backup.dim_canal_atendimento c ON f.CanalID = c.CanalID
GROUP BY c.Nome_Canal; 

-- EXPLAIN: O JOIN com índice em CanalID e o GROUP BY melhora a performance de agregação.

EXPLAIN SELECT c.Nome_Canal, AVG(f.Tempo_Espera) AS Tempo_Medio_Espera
FROM backup.fato_atendimento f
JOIN backup.dim_canal_atendimento c ON f.CanalID = c.CanalID
GROUP BY c.Nome_Canal;

--EXPLAIN Result:
fato_atendimento (f): A tabela fato tem um índice em CanalID, que será usado no JOIN.
dim_canal_atendimento (c): O índice em CanalID também será utilizado, acelerando a junção.
GROUP BY: Como o GROUP BY está sendo aplicado na coluna Nome_Canal, que já faz parte da tabela dim_canal_atendimento, o MySQL otimizará essa operação através do índice, tornando a agregação mais eficiente.
Using index: Quando possível, a consulta aproveitará os índices disponíveis para a coluna CanalID.

*/

/*--2 - Satisfação Média por Agente

SELECT a.Nome, AVG(f.Nivel_Satisfacao) AS Satisfacao_Media
FROM backup.fato_atendimento f
JOIN backup.dim_agente a ON f.AgenteID = a.AgenteID
GROUP BY a.Nome;

-- EXPLAIN: O índice em AgenteID acelera o JOIN e o cálculo de agregação de satisfação. 
EXPLAIN SELECT a.Nome, AVG(f.Nivel_Satisfacao) AS Satisfacao_Media
FROM backup.fato_atendimento f
JOIN backup.dim_agente a ON f.AgenteID = a.AgenteID
GROUP BY a.Nome;

-- EXPLAIN Result:
fato_atendimento (f): A tabela tem um índice em AgenteID, que será utilizado para o JOIN.
dim_agente (a): O índice em AgenteID também será aproveitado, tornando a junção mais rápida.
GROUP BY: A agregação por Nome na tabela de agentes não será um problema, dado que a tabela de dimensões é muito menor que a tabela fato.
Using index: Os índices em AgenteID permitem que o banco de dados acesse rapidamente os dados dos agentes sem ter que varrer toda a tabela.

*/

/*--3 - Taxa de Resolução por Categoria de Atendimento
SELECT cat.Nome_Categoria, 
       SUM(CASE WHEN f.Resolvido = 'S' THEN 1 ELSE 0 END) / COUNT(f.AtendimentoID) AS Taxa_Resolucao
FROM backup.fato_atendimento f
JOIN backup.dim_categoria_atendimento cat ON f.CategoriaID = cat.CategoriaID
GROUP BY cat.Nome_Categoria;

-- EXPLAIN: 
EXPLAIN SELECT cat.Nome_Categoria, 
       SUM(CASE WHEN f.Resolvido = 'S' THEN 1 ELSE 0 END) / COUNT(f.AtendimentoID) AS Taxa_Resolucao
FROM backup.fato_atendimento f
JOIN backup.dim_categoria_atendimento cat ON f.CategoriaID = cat.CategoriaID
GROUP BY cat.Nome_Categoria;

-- EXPLAIN Result:
fato_atendimento (f): O índice em CategoriaID será utilizado para o JOIN com a tabela dim_categoria_atendimento.
dim_categoria_atendimento (cat): Como a tabela tem um índice primário em CategoriaID, a junção será otimizada.
SUM(CASE...): O uso de CASE WHEN não impacta significativamente a performance porque ele opera em dados já filtrados via o JOIN otimizado.
GROUP BY: A agregação com GROUP BY no campo Nome_Categoria será eficiente por conta do uso do índice em CategoriaID.
-- */

/*--4 - Número de Chamadas por Cliente
SELECT cl.Nome, SUM(f.Numero_Chamadas) AS Total_Chamadas
FROM backup.fato_atendimento f
JOIN backup.dim_cliente cl ON f.ClienteID = cl.ClienteID
GROUP BY cl.Nome; 

--EXPLAIN:
EXPLAIN SELECT cl.Nome, SUM(f.Numero_Chamadas) AS Total_Chamadas
FROM backup.fato_atendimento f
JOIN backup.dim_cliente cl ON f.ClienteID = cl.ClienteID
GROUP BY cl.Nome;

--EXPLAIN Result:
fato_atendimento (f): O índice em ClienteID na tabela fato será utilizado no JOIN.
dim_cliente (cl): O índice primário em ClienteID permite que o banco encontre rapidamente o cliente relacionado.
GROUP BY: O GROUP BY no campo Nome da tabela de clientes será otimizado, pois a dimensão de clientes é relativamente pequena.
Using index: A consulta utilizará o índice de ClienteID, facilitando a junção e a agregação.

*/

/*--5 - Quantidade de Atendimentos por Dia
SELECT t.data, COUNT(f.AtendimentoID) AS Total_Atendimentos
FROM backup.fato_atendimento f
JOIN backup.dim_tempo t ON f.TempoID = t.TempoID
GROUP BY t.data;

--EXPLAIN:
EXPLAIN SELECT t.Data, COUNT(f.AtendimentoID) AS Total_Atendimentos
FROM backup.fato_atendimento f
JOIN backup.dim_tempo t ON f.TempoID = t.TempoID
GROUP BY t.Data;

-- EXPLAIN Result:
fato_atendimento (f): O índice em TempoID será utilizado no JOIN com a tabela dim_tempo.
dim_tempo (t): O índice primário em TempoID acelera a junção.
GROUP BY: O GROUP BY no campo Data da dimensão tempo será eficiente, pois a tabela dim_tempo é otimizada para operações de data.
Using index: O uso de índices em TempoID tanto na tabela fato quanto na tabela de tempo faz com que a consulta execute mais rápido.

*/

/*-- RESULTADO DAS OTIMIZAÇÕES

JOIN Otimizado: O uso de índices nas colunas de ID (ex.: ClienteID, AgenteID, CanalID) garante que os JOINs sejam rápidos, pois o banco de dados pode acessar as tabelas diretamente por meio dos índices, sem realizar varreduras completas.
Agrupamentos Eficientes: A presença de índices nas colunas de agrupamento (ex.: Nome_Canal, Nome, Data) otimiza a operação de GROUP BY, permitindo que o MySQL execute as operações de agregação de maneira mais rápida.
Filtragem com Índices: O uso de índices em colunas como Resolvido, Nivel_Satisfacao e Tempo_Espera melhora o desempenho de consultas que filtram ou agregam com base nessas colunas.

*/
