﻿

































CREATE Procedure [dbo].[Facturas_TXCod]
@NroFac int
As
SELECT *
FROM Facturas
WHERE NumeroFactura = @NroFac And Year(FechaFactura)>=2000


































