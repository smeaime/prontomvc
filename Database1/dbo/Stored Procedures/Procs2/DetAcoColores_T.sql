





























CREATE Procedure [dbo].[DetAcoColores_T]
@IdDetalleAcoColor int
AS 
SELECT *
FROM DetalleAcoColores
where (IdDetalleAcoColor=@IdDetalleAcoColor)






























