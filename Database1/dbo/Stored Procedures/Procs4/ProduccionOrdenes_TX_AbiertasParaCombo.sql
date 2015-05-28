CREATE Procedure ProduccionOrdenes_TX_AbiertasParaCombo
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
WHERE 
	not Aprobo is null
	and
	Cerro is null
	and
	isnull(Anulada,'')<>'SI'  
	
ORDER by NumeroOrdenProduccion
