


CREATE Procedure [dbo].[Transportistas_TX_PorId]
@IdTransportista int
AS 
SELECT * 
FROM Transportistas
WHERE (IdTransportista=@IdTransportista)


