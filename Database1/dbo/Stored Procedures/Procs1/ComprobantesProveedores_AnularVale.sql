﻿


































CREATE Procedure [dbo].[ComprobantesProveedores_AnularVale]
@IdComprobanteProveedor int
AS
UPDATE ComprobantesProveedores
SET IdOrdenPago=Null
WHERE IdComprobanteProveedor=@IdComprobanteProveedor




































