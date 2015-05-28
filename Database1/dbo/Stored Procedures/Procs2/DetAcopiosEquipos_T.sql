





























CREATE Procedure [dbo].[DetAcopiosEquipos_T]
@IdDetalleAcopioEquipo int
AS 
SELECT *
FROM [DetalleAcopiosEquipos]
where (IdDetalleAcopioEquipo=@IdDetalleAcopioEquipo)






























