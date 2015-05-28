
CREATE Procedure [dbo].[Empleados_E]

@IdEmpleado int  

AS 

DELETE DetalleDefinicionAnulaciones
WHERE IdEmpleado=@IdEmpleado

DELETE Empleados
WHERE IdEmpleado=@IdEmpleado
