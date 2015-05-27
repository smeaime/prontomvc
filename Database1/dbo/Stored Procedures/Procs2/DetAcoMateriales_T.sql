





























CREATE Procedure [dbo].[DetAcoMateriales_T]
@IdDetalleAcoMaterial int
AS 
SELECT *
FROM DetalleAcoMateriales
where (IdDetalleAcoMaterial=@IdDetalleAcoMaterial)






























