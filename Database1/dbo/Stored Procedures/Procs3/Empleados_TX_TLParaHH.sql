































CREATE Procedure [dbo].[Empleados_TX_TLParaHH]
AS 
Select 
IdEmpleado,
Nombre as [Titulo]
FROM Empleados
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
Where Sectores.SeUsaEnPresupuestos='SI'
Order by Nombre
































