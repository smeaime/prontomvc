CREATE PROCEDURE [dbo].[DetEmpleadosObras_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0133'
SET @vector_T='0800'

SELECT TOP 1
 Det.IdDetalleEmpleadoObra,
 Obras.NumeroObra as [Obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleEmpleadosObras Det
LEFT OUTER JOIN Obras ON Obras.IdObra=Det.IdObra