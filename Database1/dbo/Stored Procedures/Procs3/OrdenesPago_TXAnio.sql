




CREATE Procedure [dbo].[OrdenesPago_TXAnio]
AS 
SELECT 
	MIN(CONVERT(varchar, YEAR(FechaOrdenPago)))  AS Período,YEAR(FechaOrdenPago)
FROM OrdenesPago op
WHERE (op.Confirmado is null or op.Confirmado<>'NO')
GROUP BY  YEAR(FechaOrdenPago) 
ORDER by  YEAR(FechaOrdenPago)  desc




