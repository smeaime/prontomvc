﻿


































CREATE  Procedure [dbo].[Articulos_TX_xDetLMat]
@IdDetalleLMateriales int
AS 
SELECT IdArticulo
FROM DetalleLMateriales
WHERE DetalleLMateriales.IdDetalleLMateriales=@IdDetalleLMateriales



































