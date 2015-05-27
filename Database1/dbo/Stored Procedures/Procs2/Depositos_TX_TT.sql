




CREATE Procedure [dbo].[Depositos_TX_TT]
@IdDeposito int
AS 
SELECT 
 Depositos.IdDeposito,
 Depositos.Descripcion,
 Depositos.Abreviatura,
 Obras.NumeroObra as [Obra]
FROM Depositos
LEFT OUTER JOIN Obras ON Depositos.IdObra = Obras.IdObra
WHERE (IdDeposito=@IdDeposito)




