


CREATE Procedure [dbo].[OrdenesTrabajo_TXAnio]
AS 
SELECT MIN(CONVERT(varchar, YEAR(FechaInicio))) AS Período,YEAR(FechaInicio)
FROM OrdenesTrabajo 
GROUP BY YEAR(FechaInicio) 
ORDER by YEAR(FechaInicio) desc


