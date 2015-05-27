
CREATE Procedure [dbo].[DepositosBancarios_TXAnio]
As
SELECT 
 Min(CONVERT(varchar, YEAR(FechaDeposito)))  AS Período,YEAR(FechaDeposito)
FROM DepositosBancarios
WHERE FechaDeposito is not null
GROUP BY  YEAR(FechaDeposito) 
ORDER by  YEAR(FechaDeposito)  desc
