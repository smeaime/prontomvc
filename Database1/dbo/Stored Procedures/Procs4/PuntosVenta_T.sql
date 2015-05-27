





















CREATE Procedure [dbo].[PuntosVenta_T]
@IdPuntoVenta int
AS 
SELECT *
FROM PuntosVenta
WHERE (IdPuntoVenta=@IdPuntoVenta)






















