


















CREATE PROCEDURE [dbo].[DetNotasCredito_TX_PorIdCabecera]
@IdNotaCredito int
AS
SELECT *
FROM DetalleNotasCredito 
WHERE (DetalleNotasCredito.IdNotaCredito = @IdNotaCredito)


















