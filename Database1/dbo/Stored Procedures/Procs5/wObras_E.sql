
CREATE Procedure [dbo].[wObras_E]

@IdObra int  

AS 

DELETE Obras
WHERE (IdObra=@IdObra)

