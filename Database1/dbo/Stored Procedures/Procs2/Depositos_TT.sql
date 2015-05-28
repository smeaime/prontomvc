CREATE Procedure [dbo].[Depositos_TT]

AS 

SELECT 
 Depositos.IdDeposito,
 Depositos.Descripcion,
 Depositos.Abreviatura,
 Obras.NumeroObra as [Obra]
FROM Depositos
LEFT OUTER JOIN Obras ON Depositos.IdObra = Obras.IdObra
ORDER by Depositos.Descripcion