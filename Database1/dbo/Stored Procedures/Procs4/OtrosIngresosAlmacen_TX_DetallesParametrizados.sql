



CREATE  Procedure [dbo].[OtrosIngresosAlmacen_TX_DetallesParametrizados]

@NivelParametrizacion int

AS

Declare @vector_X varchar(50),@vector_T varchar(50)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='011111133'
	Set @vector_T='075452900'
   END
ELSE
   BEGIN
	Set @vector_X='011111133'
	Set @vector_T='075452200'
   END

SELECT 
 OtrosIngresosAlmacen.IdOtroIngresoAlmacen,
 CASE	WHEN OtrosIngresosAlmacen.TipoIngreso=0 THEN 'Devolucion de fabrica'
	WHEN OtrosIngresosAlmacen.TipoIngreso=1 THEN 'Devolucion prestamo'
	WHEN OtrosIngresosAlmacen.TipoIngreso=2 THEN 'Devolucion muestra'
	WHEN OtrosIngresosAlmacen.TipoIngreso=3 THEN 'Rechazo cliente'
	WHEN OtrosIngresosAlmacen.TipoIngreso=4 THEN 'Otros ingresos'
	ELSE Null
 END as [Tipo de ingreso],
 OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen as [Nro. de ingreso],
 OtrosIngresosAlmacen.FechaOtroIngresoAlmacen as [Fecha],
 Obras.NumeroObra as [Obra],
 Empleados.Nombre as [Aprobo],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OtrosIngresosAlmacen
LEFT OUTER JOIN Obras ON OtrosIngresosAlmacen.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados ON OtrosIngresosAlmacen.Aprobo = Empleados.IdEmpleado
LEFT OUTER JOIN ArchivosATransmitirDestinos ON OtrosIngresosAlmacen.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
ORDER BY OtrosIngresosAlmacen.FechaOtroIngresoAlmacen



