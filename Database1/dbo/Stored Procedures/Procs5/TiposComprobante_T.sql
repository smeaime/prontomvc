﻿
































CREATE Procedure [dbo].[TiposComprobante_T]
@IdTipoComprobante int
AS 
SELECT *
FROM TiposComprobante
where (IdTipoComprobante=@IdTipoComprobante)

































