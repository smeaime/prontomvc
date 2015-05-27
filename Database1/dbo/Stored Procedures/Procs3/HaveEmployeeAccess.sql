
-------------------------------------------------------------------
CREATE PROCEDURE [dbo].[HaveEmployeeAccess]
@UserName Varchar(100),
@Nodo  Varchar(100)
 AS

Select * from EmpleadosAccesos as ea
inner join Empleados as e on ea.IdEmpleado = e.IdEmpleado
Where e.Nombre = @UserName And ea.Nodo = @Nodo
and ea.Acceso = 1

