





























CREATE PROCEDURE [dbo].[DetNotasDebito_TX_PorIdCabecera]
@IdNotaDebito int
AS
SELECT *
FROM DetalleNotasDebito DetND
WHERE (DetND.IdNotaDebito = @IdNotaDebito)






























