




























CREATE Procedure [dbo].[Asientos_TX_DetallesPorIdAsiento]
@IdAsiento int
AS 
SELECT *
FROM DetalleAsientos
WHERE IdAsiento=@IdAsiento





























