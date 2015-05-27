


CREATE Procedure [dbo].[Transportistas_T]
@IdTransportista int
AS 
SELECT * 
FROM Transportistas
WHERE (IdTransportista=@IdTransportista)


