




CREATE Procedure [dbo].[PlazosEntrega_T]
@IdPlazoEntrega int
AS 
SELECT *
FROM PlazosEntrega
WHERE (IdPlazoEntrega=@IdPlazoEntrega)




