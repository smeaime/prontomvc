CREATE Procedure [dbo].[Empleados_TX_ConOtrasNovedades]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30),@Novedad1 varchar(30)
SET @vector_X='01111133'
SET @vector_T='02700700'

SET @Novedad1='REGISTRO VENCIDO'

SELECT 
 Empleados.IdEmpleado as [IdEmpleado],
 Empleados.Nombre as [Apellido y nombre],
 @Novedad1 as [Novedad],
 Sectores.Descripcion as [Sector],
 Cargos.Descripcion as [Cargo],
 Empleados.FechaVencimientoRegistro as [Fecha Vto.Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Empleados
LEFT OUTER JOIN Sectores ON Empleados.IdSector=Sectores.IdSector
LEFT OUTER JOIN Cargos ON Empleados.IdCargo=Cargos.IdCargo
WHERE IsNull(Empleados.Activo,'SI')='SI' and IsNull(Empleados.EsConductor,'')='SI' and 
	Empleados.FechaVencimientoRegistro is not null and Empleados.FechaVencimientoRegistro<GetDate()
ORDER BY Empleados.Nombre,Empleados.Legajo