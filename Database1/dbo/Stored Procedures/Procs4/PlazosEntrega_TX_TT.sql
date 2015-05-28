




CREATE Procedure [dbo].[PlazosEntrega_TX_TT]
@IdPlazoEntrega int
AS 
SELECT *
FROM PlazosEntrega
WHERE (IdPlazoEntrega=@IdPlazoEntrega)




