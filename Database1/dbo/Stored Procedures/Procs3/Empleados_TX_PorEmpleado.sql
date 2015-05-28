CREATE Procedure [dbo].[Empleados_TX_PorEmpleado]

@IdEmpleado int 

AS 

SELECT *
FROM EmpleadosAccesos
WHERE (IdEmpleado=@IdEmpleado)