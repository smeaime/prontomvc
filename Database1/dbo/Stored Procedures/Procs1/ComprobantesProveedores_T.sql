﻿



































CREATE Procedure [dbo].[ComprobantesProveedores_T]
@IdComprobanteProveedor int
AS 
SELECT *
FROM ComprobantesProveedores
WHERE (IdComprobanteProveedor=@IdComprobanteProveedor)




































