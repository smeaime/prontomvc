﻿
































CREATE PROCEDURE [dbo].[DetOrdenesPagoValores_TX_PorIdCabecera]
@IdOrdenPago int
AS
SELECT *
FROM DetalleOrdenesPagoValores DetOP
WHERE (DetOP.IdOrdenPago = @IdOrdenPago)

































