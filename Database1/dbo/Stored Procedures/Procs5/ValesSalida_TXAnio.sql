
CREATE Procedure [dbo].[ValesSalida_TXAnio]

AS

SELECT Min(Convert(varchar,Year(FechaValeSalida)))  as [Período], Year(FechaValeSalida)
FROM ValesSalida
WHERE FechaValeSalida is not null
GROUP BY YEAR(FechaValeSalida) 
ORDER bY YEAR(FechaValeSalida)  DESC
