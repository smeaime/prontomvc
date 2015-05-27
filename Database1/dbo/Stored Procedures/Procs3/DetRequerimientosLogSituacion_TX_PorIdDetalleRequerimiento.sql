CREATE PROCEDURE [dbo].[DetRequerimientosLogSituacion_TX_PorIdDetalleRequerimiento]

@IdDetalleRequerimiento int = Null, 
@IdRequerimiento int = Null

AS

SET @IdDetalleRequerimiento=IsNull(@IdDetalleRequerimiento,0)
SET @IdRequerimiento=IsNull(@IdRequerimiento,0)

DECLARE @vector_X varchar(50),@vector_T varchar(50)


SET @vector_X='0111D1133'
SET @vector_T='020061800'

SELECT
 drls.IdDetalleRequerimiento [IdDetalleRequerimiento],
 Requerimientos.NumeroRequerimiento as [RM],
 dr.NumeroItem as [Item], 
 drls.Situacion as [Sit.],
 drls.Fecha as [Fecha],
 Empleados.Nombre as [Modifico],
 drls.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientosLogSituacion drls
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = drls.IdUsuarioModifico
LEFT OUTER JOIN DetalleRequerimientos dr ON dr.IdDetalleRequerimiento = drls.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = dr.IdRequerimiento
WHERE (@IdDetalleRequerimiento>0 and drls.IdDetalleRequerimiento=@IdDetalleRequerimiento) or (@IdRequerimiento>0 and dr.IdRequerimiento=@IdRequerimiento)
ORDER BY dr.NumeroItem, drls.Fecha DESC
