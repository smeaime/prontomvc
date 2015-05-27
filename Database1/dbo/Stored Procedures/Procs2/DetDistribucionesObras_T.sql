


CREATE Procedure [dbo].[DetDistribucionesObras_T]
@IdDetalleDistribucionObra int
AS 
SELECT *
FROM [DetalleDistribucionesObras]
WHERE (IdDetalleDistribucionObra=@IdDetalleDistribucionObra)


