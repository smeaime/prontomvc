
CREATE Procedure [dbo].[Subcontratos_TX_PorNumeroSubcontrato]

@NumeroSubcontrato int

AS 

SELECT C.*
FROM Subcontratos C
WHERE C.NumeroSubcontrato=@NumeroSubcontrato
ORDER BY C.Descripcion, C.IdSubcontrato
