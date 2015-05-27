




CREATE Procedure [dbo].[OrdenesPago_TXMesAnio]
AS
SELECT 
	MIN(CONVERT(varchar, MONTH(FechaOrdenPago)) + '/' + CONVERT(varchar, YEAR(FechaOrdenPago)) )  AS Período,
YEAR(FechaOrdenPago) , MONTH(FechaOrdenPago)  
FROM OrdenesPago op
WHERE (op.Confirmado is null or op.Confirmado<>'NO')
GROUP BY  YEAR(FechaOrdenPago) , MONTH(FechaOrdenPago)  
ORDER by  YEAR(FechaOrdenPago)  desc , MONTH(FechaOrdenPago)  desc




