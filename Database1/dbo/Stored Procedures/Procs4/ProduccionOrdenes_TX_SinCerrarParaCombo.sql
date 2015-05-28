CREATE Procedure ProduccionOrdenes_TX_SinCerrarParaCombo
AS 
SELECT 
 IdProduccionOrden,
 ltrim(str(NumeroOrdenProduccion)) as Titulo,
Aprobo,
Cerro,
Anulada

 -- +' ' +Descripcion as Titulo
FROM ProduccionOrdenes
--LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=Det.IdProduccionProceso
--LEFT OUTER JOIN Articulos  ON Articulos.IdArticulo=Det.IdMaquina
--WHERE IsNull(IdTipo,0)=@IdTipo and IsNull(Articulos.Activo,'')<>'NO'
ORDER by NumeroOrdenProduccion
