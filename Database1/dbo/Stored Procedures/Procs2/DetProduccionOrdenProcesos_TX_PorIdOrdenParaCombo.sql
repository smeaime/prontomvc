﻿CREATE Procedure DetProduccionOrdenProcesos_TX_PorIdOrdenParaCombo
 @IdProduccionOrden int 
AS 
SELECT  distinct
 det.IdProduccionProceso,
 ProduccionProcesos.Descripcion as Titulo,det.IdDetalleProduccionOrdenProceso
FROM DetalleProduccionOrdenProcesos det
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=Det.IdProduccionProceso
WHERE det.IdProduccionOrden=@IdProduccionOrden
and det.IdProduccionParteQueCerroEsteProceso IS NULL
ORDER by det.IdDetalleProduccionOrdenProceso
