



CREATE Procedure [dbo].[Cotizaciones_TXAnio]
As
SELECT 
min(CONVERT(varchar, YEAR(Fecha))) AS Período,YEAR(Fecha)
FROM Cotizaciones
GROUP BY  YEAR(Fecha) 
ORDER by  YEAR(Fecha)  desc



