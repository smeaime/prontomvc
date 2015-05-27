
CREATE PROCEDURE [dbo].[DetRequerimientos_TX_DetallesParametrizados]

@IdRequerimiento int,
@NivelParametrizacion int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)

IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='001011111101110111111133'
	Set @vector_T='000099009902040992999000'
   END
ELSE
   BEGIN
	Set @vector_X='001011111101110111111133'
	Set @vector_T='000011000002040092345300'
   END

SELECT
 DetReq.IdDetalleRequerimiento,
 DetReq.IdRequerimiento,
 DetReq.NumeroItem as [Item],
 DetReq.IdDetalleLMateriales,
 LMateriales.NumeroLMateriales as [L.Mat.],
 DetalleLMateriales.NumeroOrden as [Itm.LM],
 DetReq.Cantidad as [Cant.],
 ( SELECT Unidades.Descripcion
	FROM Unidades
	WHERE Unidades.IdUnidad=DetReq.IdUnidad) as  [Unidad en],
 DetReq.Cantidad1 as [Med.1],
 DetReq.Cantidad2 as [Med.2],
 DetReq.IdArticulo,
 Articulos.Codigo as [Codigo],
 CASE 
	WHEN DetReq.IdArticulo IS NULL THEN DetReq.DescripcionManual COLLATE SQL_Latin1_General_CP1_CI_AS
	WHEN DetReq.IdArticulo IS NOT NULL THEN Articulos.Descripcion
	ELSE NULL
 END as [Articulo],
 DetReq.FechaEntrega as [F.entrega],
 DetReq.IdControlCalidad,
 ControlesCalidad.Abreviatura as [CC],
 ( SELECT SUM(DetallePedidos.CantidadRecibida)
	FROM DetallePedidos
	WHERE DetReq.IdDetalleRequerimiento=DetallePedidos.IdDetalleRequerimiento) as [CantidadRecibida],
 CASE 
	WHEN DetReq.Cumplido is null THEN 'NO'
	ELSE DetReq.Cumplido 
 END as [Cump],
 Proveedores.RazonSocial as [Proveedor asignado],
 ( SELECT Empleados.Iniciales
	FROM Empleados
	WHERE Empleados.IdEmpleado=DetReq.IdLlamadoAProveedor) as  [Llamado por],
 DetReq.FechaLlamadoAProveedor as [Fecha llamada],
 (SELECT SUM(DetalleReservas.CantidadUnidades) 
	FROM DetalleReservas 
	WHERE DetalleReservas.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) 
	as [Reservado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN Proveedores ON DetReq.IdProveedor = Proveedores.IdProveedor
WHERE (DetReq.IdRequerimiento = @IdRequerimiento)
ORDER by DetReq.NumeroItem
