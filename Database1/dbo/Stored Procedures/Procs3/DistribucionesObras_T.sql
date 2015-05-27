


CREATE Procedure [dbo].[DistribucionesObras_T]
@IdDistribucionObra int
AS 
SELECT * 
FROM DistribucionesObras
WHERE (IdDistribucionObra=@IdDistribucionObra)


