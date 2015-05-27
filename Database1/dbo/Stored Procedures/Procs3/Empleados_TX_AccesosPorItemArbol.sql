


CREATE Procedure [dbo].[Empleados_TX_AccesosPorItemArbol]

@Nodo varchar(50)

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011111133'
Set @vector_T='039939900'

SELECT 
 Empleados.IdEmpleado,
 Empleados.Nombre as [Empleado],
 Empleados.IdEmpleado as [IdAux1],
 Case When EmpleadosAccesos.IdEmpleadoAcceso is null 
	Then -1 
	Else EmpleadosAccesos.IdEmpleadoAcceso 
 End as [IdAux2],
 Sectores.Descripcion as [Sector],
 Case When EmpleadosAccesos.Acceso is null Then 0 Else EmpleadosAccesos.Acceso End as [Acceso],
 Case When EmpleadosAccesos.Nivel is null Then 0 Else EmpleadosAccesos.Nivel End as [Nivel],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Empleados
LEFT OUTER JOIN EmpleadosAccesos ON EmpleadosAccesos.IdEmpleado=Empleados.IdEmpleado and 
					EmpleadosAccesos.Nodo=@Nodo
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
ORDER BY Empleados.Nombre


