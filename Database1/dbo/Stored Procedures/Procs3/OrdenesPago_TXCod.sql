﻿

































CREATE Procedure [dbo].[OrdenesPago_TXCod]
@NroOP int
As
SELECT IdOrdenPago, FechaOrdenPago
FROM OrdenesPago
WHERE (NumeroOrdenPago = @NroOP)


































