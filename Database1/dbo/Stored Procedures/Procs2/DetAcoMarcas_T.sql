





























CREATE Procedure [dbo].[DetAcoMarcas_T]
@IdDetalleAcoMarca int
AS 
SELECT *
FROM DetalleAcoMarcas
where (IdDetalleAcoMarca=@IdDetalleAcoMarca)






























