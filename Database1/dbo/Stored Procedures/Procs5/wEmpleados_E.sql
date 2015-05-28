
CREATE Procedure [dbo].[wEmpleados_E]

@IdEmpleado int  

AS 

DELETE Empleados
WHERE (IdEmpleado=@IdEmpleado)

