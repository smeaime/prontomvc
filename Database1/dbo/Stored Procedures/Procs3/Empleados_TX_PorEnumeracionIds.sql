CREATE Procedure [dbo].[Empleados_TX_PorEnumeracionIds]

@IdEmpleados varchar(100)

AS 

SELECT *
FROM Empleados 
WHERE Patindex('%('+Convert(varchar,Empleados.IdEmpleado)+')%', @IdEmpleados)<>0