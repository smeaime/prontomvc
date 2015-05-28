
CREATE Procedure [dbo].[Empleados_TX_PorId]
@IdEmpleado int 
AS 
SELECT *
FROM Empleados
WHERE (IdEmpleado=@IdEmpleado)
