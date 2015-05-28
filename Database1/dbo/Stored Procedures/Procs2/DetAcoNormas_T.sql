





























CREATE Procedure [dbo].[DetAcoNormas_T]
@IdDetalleAcoNorma int
AS 
SELECT *
FROM DetalleAcoNormas
where (IdDetalleAcoNorma=@IdDetalleAcoNorma)






























