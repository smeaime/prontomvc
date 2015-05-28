





























CREATE Procedure [dbo].[DetEquipos_T]
@IdDetalleEquipo int
AS 
SELECT *
FROM [DetalleEquipos]
where (IdDetalleEquipo=@IdDetalleEquipo)






























