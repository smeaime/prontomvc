





























CREATE Procedure [dbo].[DetAcoCalidades_T]
@IdDetalleAcoCalidad int
AS 
SELECT *
FROM DetalleAcoCalidades
where (IdDetalleAcoCalidad=@IdDetalleAcoCalidad)






























