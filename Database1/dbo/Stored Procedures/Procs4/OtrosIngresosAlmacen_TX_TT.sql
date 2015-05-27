

CREATE  Procedure [dbo].[OtrosIngresosAlmacen_TX_TT]

@IdOtroIngresoAlmacen int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111111111133'
set @vector_T='0754522114300'

SELECT 
 OtrosIngresosAlmacen.IdOtroIngresoAlmacen,
 CASE	WHEN OtrosIngresosAlmacen.TipoIngreso=0 THEN 'Devolucion de fabrica'
	WHEN OtrosIngresosAlmacen.TipoIngreso=1 THEN 'Devolucion prestamo'
	WHEN OtrosIngresosAlmacen.TipoIngreso=2 THEN 'Devolucion muestra'
	WHEN OtrosIngresosAlmacen.TipoIngreso=3 THEN 'Devolucion de obra'
	WHEN OtrosIngresosAlmacen.TipoIngreso=4 THEN 'Otros ingresos'
	ELSE Null
 END as [Tipo de ingreso],
 OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen as [Nro. de ingreso],
 OtrosIngresosAlmacen.FechaOtroIngresoAlmacen as [Fecha],
 Obras.NumeroObra as [Obra],
 Empleados.Nombre as [Aprobo],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 OtrosIngresosAlmacen.Anulado as [Anulado],
 (Select Top 1 Empleados.Nombre From Empleados
  Where OtrosIngresosAlmacen.IdAutorizaAnulacion = Empleados.IdEmpleado) as [Anulo],
 OtrosIngresosAlmacen.FechaAnulacion as [Fecha anulacion],
 OtrosIngresosAlmacen.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OtrosIngresosAlmacen
LEFT OUTER JOIN Obras ON OtrosIngresosAlmacen.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados ON OtrosIngresosAlmacen.Aprobo = Empleados.IdEmpleado
LEFT OUTER JOIN ArchivosATransmitirDestinos ON OtrosIngresosAlmacen.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
WHERE (IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen)

