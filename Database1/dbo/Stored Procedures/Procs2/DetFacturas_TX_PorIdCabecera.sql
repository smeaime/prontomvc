CREATE PROCEDURE [dbo].[DetFacturas_TX_PorIdCabecera]

@IdFactura int

AS

SELECT *
FROM DetalleFacturas DetFac
WHERE (DetFac.IdFactura = @IdFactura)