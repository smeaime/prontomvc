﻿
































CREATE Procedure [dbo].[TiposComprobante_TX_Buscar]
@IdTipoComprobante int
AS 
SELECT *
FROM TiposComprobante
WHERE (IdTipoComprobante=@IdTipoComprobante)

































