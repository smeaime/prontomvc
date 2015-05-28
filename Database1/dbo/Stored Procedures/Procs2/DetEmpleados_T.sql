





























CREATE Procedure [dbo].[DetEmpleados_T]
@IdDetalleEmpleado int
AS 
SELECT *
FROM [DetalleEmpleados]
where (IdDetalleEmpleado=@IdDetalleEmpleado)






























