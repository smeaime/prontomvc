﻿
































CREATE Procedure [dbo].[OrdenesPago_MarcarComoPendiente]
@IdOrdenPago int
AS 
UPDATE OrdenesPago
SET Estado='FI'
WHERE IdOrdenPago=@IdOrdenPago

































