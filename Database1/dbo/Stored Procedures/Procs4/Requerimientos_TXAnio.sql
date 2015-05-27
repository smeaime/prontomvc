



CREATE Procedure [dbo].[Requerimientos_TXAnio]
AS
SELECT 
 Min(CONVERT(varchar,YEAR(FechaRequerimiento)))  as Período,
 YEAR(FechaRequerimiento)
FROM Requerimientos
WHERE FechaRequerimiento is not null
GROUP BY  YEAR(FechaRequerimiento) 
ORDER by  YEAR(FechaRequerimiento)  desc



