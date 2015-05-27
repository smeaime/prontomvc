



CREATE Procedure [dbo].[SolicitudesCompra_TXAnio]
AS
SELECT 
 Min(CONVERT(varchar,YEAR(FechaSolicitud)))  as Período,
 YEAR(FechaSolicitud)
FROM SolicitudesCompra
WHERE FechaSolicitud is not null
GROUP BY  YEAR(FechaSolicitud) 
ORDER by  YEAR(FechaSolicitud)  desc



