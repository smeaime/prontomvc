CREATE PROCEDURE [dbo].[DetRequerimientos_TXReq]

@IdRequerimiento int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00101111110111011111111133'
SET @vector_T='000011000002F4009234535500'

SELECT
 DetReq.IdDetalleRequerimiento,
 DetReq.IdRequerimiento,
 DetReq.NumeroItem as [Item],
 DetReq.IdDetalleLMateriales,
 LMateriales.NumeroLMateriales as [L.Mat.],
 DetalleLMateriales.NumeroOrden as [Itm.LM],
 DetReq.Cantidad as [Cant.],
 Unidades.Abreviatura as [Unidad en],
 DetReq.Cantidad1 as [Med.1],
 DetReq.Cantidad2 as [Med.2],
 DetReq.IdArticulo,
 Articulos.Codigo as [Codigo],
 IsNull(Articulos.Descripcion, DetReq.DescripcionManual COLLATE Modern_Spanish_CI_AS) as [Articulo],
 DetReq.FechaEntrega as [F.entrega],
 DetReq.IdControlCalidad,
 ControlesCalidad.Abreviatura as [CC],
 (SELECT SUM(DetallePedidos.CantidadRecibida) FROM DetallePedidos WHERE DetReq.IdDetalleRequerimiento=DetallePedidos.IdDetalleRequerimiento) as [CantidadRecibida],
 IsNull(DetReq.Cumplido,'NO') as [Cump],
 Proveedores.RazonSocial as [Proveedor asignado],
 Empleados.Iniciales as [Llamado por],
 DetReq.FechaLlamadoAProveedor as [Fecha llamada],
 (SELECT SUM(DetalleReservas.CantidadUnidades) FROM DetalleReservas WHERE DetalleReservas.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) as [Reservado],
 DetReq.Observaciones as [Observaciones],
 DetReq.ObservacionesFirmante as [Observaciones firmante],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = DetReq.IdUnidad
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN Proveedores ON DetReq.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Empleados ON DetReq.IdLlamadoAProveedor = Empleados.IdEmpleado
WHERE (DetReq.IdRequerimiento = @IdRequerimiento)
ORDER by DetReq.NumeroItem