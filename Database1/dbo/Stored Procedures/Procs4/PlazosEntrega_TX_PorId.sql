




CREATE Procedure [dbo].[PlazosEntrega_TX_PorId]
@IdPlazoEntrega int
AS 
SELECT *
FROM PlazosEntrega
WHERE (IdPlazoEntrega=@IdPlazoEntrega)




