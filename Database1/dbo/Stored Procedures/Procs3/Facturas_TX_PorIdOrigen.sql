


CREATE Procedure [dbo].[Facturas_TX_PorIdOrigen]
@IdFacturaOriginal int,
@IdOrigenTransmision int
AS 
SELECT TOP 1 IdFactura
FROM Facturas
WHERE IdFacturaOriginal=@IdFacturaOriginal and IdOrigenTransmision=@IdOrigenTransmision


