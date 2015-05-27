





























CREATE Procedure [dbo].[DetAcoGrados_T]
@IdDetalleAcoGrado int
AS 
SELECT *
FROM DetalleAcoGrados
where (IdDetalleAcoGrado=@IdDetalleAcoGrado)






























