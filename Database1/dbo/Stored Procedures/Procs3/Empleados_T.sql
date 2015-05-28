


CREATE Procedure [dbo].[Empleados_T]
@IdEmpleado int
AS 
SELECT *
FROM Empleados
WHERE (IdEmpleado=@IdEmpleado)


