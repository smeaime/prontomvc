





















CREATE Procedure [dbo].[PuntosVenta_TX_PorId]
@IdPuntoVenta int
AS 
SELECT *
FROM PuntosVenta
WHERE (IdPuntoVenta=@IdPuntoVenta)






















