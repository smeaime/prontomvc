




CREATE Procedure [dbo].[PlazosEntrega_E]
@IdPlazoEntrega int 
AS 
DELETE PlazosEntrega
WHERE (IdPlazoEntrega=@IdPlazoEntrega)




