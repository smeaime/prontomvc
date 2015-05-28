CREATE Procedure [dbo].[Calles_TX_TT]

@IdCalle int

AS 

SELECT 
 IdCalle,
 Nombre as [Calle]
FROM Calles
WHERE (IdCalle=@IdCalle)