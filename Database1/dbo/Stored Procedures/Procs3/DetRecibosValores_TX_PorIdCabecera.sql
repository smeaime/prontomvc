﻿































CREATE PROCEDURE [dbo].[DetRecibosValores_TX_PorIdCabecera]
@IdRecibo int
AS
SELECT *
FROM DetalleRecibosValores DetRec
WHERE (DetRec.IdRecibo = @IdRecibo)
































