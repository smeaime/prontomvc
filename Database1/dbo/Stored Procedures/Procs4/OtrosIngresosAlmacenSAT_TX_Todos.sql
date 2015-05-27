
CREATE  Procedure [dbo].[OtrosIngresosAlmacenSAT_TX_Todos]

@IdObraAsignadaUsuario int = Null

AS 

SET @IdObraAsignadaUsuario=IsNull(@IdObraAsignadaUsuario,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111133'
SET @vector_T='0754522114300'

SELECT 
 oia.IdOtroIngresoAlmacen,
 CASE	WHEN oia.TipoIngreso=0 THEN 'Devolucion de fabrica'
	WHEN oia.TipoIngreso=1 THEN 'Devolucion prestamo'
	WHEN oia.TipoIngreso=2 THEN 'Devolucion muestra'
	WHEN oia.TipoIngreso=3 THEN 'Devolucion de obra'
	WHEN oia.TipoIngreso=4 THEN 'Otros ingresos'
	ELSE Null
 END as [Tipo de ingreso],
 oia.NumeroOtroIngresoAlmacen as [Nro. de ingreso],
 oia.FechaOtroIngresoAlmacen as [Fecha],
 Obras.NumeroObra as [Obra],
 Empleados.Nombre as [Aprobo],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 oia.Anulado as [Anulado],
 (Select Top 1 Empleados.Nombre From Empleados
  Where oia.IdAutorizaAnulacion = Empleados.IdEmpleado) as [Anulo],
 oia.FechaAnulacion as [Fecha anulacion],
 oia.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OtrosIngresosAlmacenSAT oia
LEFT OUTER JOIN Obras ON oia.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados ON oia.Aprobo = Empleados.IdEmpleado
LEFT OUTER JOIN ArchivosATransmitirDestinos ON oia.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
WHERE @IdObraAsignadaUsuario=-1 or oia.IdObra=@IdObraAsignadaUsuario
ORDER BY oia.FechaOtroIngresoAlmacen
