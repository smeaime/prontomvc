
CREATE Procedure ProduccionOrdenes_TX_PorProceso
As
SELECT distinct 
 ProduccionProcesos.Descripcion,DP.idProduccionProceso
FROM ProduccionOrdenes ProduccionOrdenes
left outer join DetalleProduccionOrdenProcesos DP ON ProduccionOrdenes.idProduccionOrden=DP.idProduccionOrden
LEFT OUTER JOIN ProduccionProcesos  ON  DP.IdProduccionProceso = ProduccionProcesos.IdProduccionProceso
LEFT OUTER JOIN Unidades ON ProduccionOrdenes.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Articulos ON ProduccionOrdenes.IdArticuloGenerado = Articulos.IdArticulo
where DP.idProduccionProceso is not null
ORDER by  ProduccionProcesos.Descripcion 
