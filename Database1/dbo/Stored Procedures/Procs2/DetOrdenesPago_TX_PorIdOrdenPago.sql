﻿

































CREATE Procedure [dbo].[DetOrdenesPago_TX_PorIdOrdenPago]
@IdOrdenPago int
AS 
SELECT *
FROM DetalleOrdenesPago
WHERE IdOrdenPago=@IdOrdenPago


































