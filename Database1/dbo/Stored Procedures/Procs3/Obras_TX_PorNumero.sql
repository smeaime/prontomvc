
CREATE Procedure [dbo].[Obras_TX_PorNumero]

@NumeroObra varchar(13)

AS 

SELECT  * 
FROM Obras
WHERE NumeroObra=@NumeroObra
