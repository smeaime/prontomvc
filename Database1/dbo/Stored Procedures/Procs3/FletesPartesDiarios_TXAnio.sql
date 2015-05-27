
CREATE Procedure [dbo].[FletesPartesDiarios_TXAnio]

AS

SELECT Min(Convert(varchar,Year(Fecha))) as [Período], Year(Fecha)
FROM FletesPartesDiarios
GROUP BY YEAR(Fecha) 
ORDER BY YEAR(Fecha) Desc
