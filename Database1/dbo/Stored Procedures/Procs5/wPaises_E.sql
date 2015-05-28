
CREATE Procedure [dbo].[wPaises_E]

@IdPais int  

AS 

DELETE Paises
WHERE IdPais=@IdPais

