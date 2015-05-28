














CREATE Procedure [dbo].[Valores_TX_PorIdDetalleAsiento]
@IdDetalleAsiento int
AS 
SELECT TOP 1 *
FROM Valores
WHERE IdDetalleAsiento=@IdDetalleAsiento














