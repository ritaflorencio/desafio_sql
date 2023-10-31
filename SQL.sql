SELECT DISTINCT Categoria
FROM DB_Teste;

/*Listar todas as vendas (ID) e seus respectivos clientes apenas no ano de 2020*/
    
SELECT
    strftime('%Y-%m-%d', substr(Data_da_Venda, 7, 4) || '-' || substr(Data_da_Venda, 4, 2) || '-' || substr(Data_da_Venda, 1, 2)) AS data_formatada,
    
    ID,
    Cliente
FROM
    DB_Teste
WHERE
    data_formatada >= '2020-01-01' AND data_formatada <= '2020-12-31';   
    


/*Listar a equipe de cada vendedor*/
SELECT Vendedor, GROUP_CONCAT(Equipe, ', ') AS Equipes
FROM DB_Teste
GROUP BY Vendedor;

 

/*- Construir uma tabela que avalia trimestralmente o resultado de vendas e plote um gráfico deste histórico.*/
SELECT 
    strftime('%Y', strftime('%Y-%m-%d', substr(Data_da_Venda, 7, 4) || '-' || substr(Data_da_Venda, 4, 2) || '-' || substr(Data_da_Venda, 1, 2))) AS ano,
    sum(case WHEN strftime('%m', strftime('%Y-%m-%d', substr(Data_da_Venda, 7, 4) || '-' || substr(Data_da_Venda, 4, 2) || '-' || substr(Data_da_Venda, 1, 2))) BETWEEN '01' AND '03' then 1 else 0 end) AS 'Trimestre 1',
    sum(case when strftime('%m', strftime('%Y-%m-%d', substr(Data_da_Venda, 7, 4) || '-' || substr(Data_da_Venda, 4, 2) || '-' || substr(Data_da_Venda, 1, 2))) BETWEEN '04' AND '06' then 1 else 0 end) AS 'Trimestre 2',
    sum(case when strftime('%m', strftime('%Y-%m-%d', substr(Data_da_Venda, 7, 4) || '-' || substr(Data_da_Venda, 4, 2) || '-' || substr(Data_da_Venda, 1, 2))) BETWEEN '07' AND '09' then 1 else 0 end) AS 'Trimestre 3',
    sum(case when strftime('%m', strftime('%Y-%m-%d', substr(Data_da_Venda, 7, 4) || '-' || substr(Data_da_Venda, 4, 2) || '-' || substr(Data_da_Venda, 1, 2))) BETWEEN '10' AND '12' then 1 else 0 end) AS 'Trimestre 4',
	sum(Valor) AS total_vendas
FROM DB_Teste
GROUP BY ano;
