
CREATE Procedure [dbo].[RecepcionesSAT_TXAnio]
AS
SELECT Min(CONVERT(varchar,YEAR(FechaRecepcion)))  as [Periodo], YEAR(FechaRecepcion)
FROM RecepcionesSAT
WHERE FechaRecepcion is not null
GROUP BY YEAR(FechaRecepcion) 
ORDER BY YEAR(FechaRecepcion)  desc
