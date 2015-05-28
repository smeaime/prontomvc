
CREATE Procedure [dbo].[DetRequerimientos_T]
@IdDetalleRequerimiento int
AS 
SELECT *
FROM [DetalleRequerimientos]
WHERE (IdDetalleRequerimiento=@IdDetalleRequerimiento)
