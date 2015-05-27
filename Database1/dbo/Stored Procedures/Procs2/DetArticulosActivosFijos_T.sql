














CREATE Procedure [dbo].[DetArticulosActivosFijos_T]
@IdDetalleArticuloActivosFijos int
AS 
SELECT *
FROM [DetalleArticulosActivosFijos]
WHERE (IdDetalleArticuloActivosFijos=@IdDetalleArticuloActivosFijos)















