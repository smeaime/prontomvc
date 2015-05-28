CREATE Procedure [dbo].[Paises_E]

@IdPais int 

AS 

DELETE Paises
WHERE (IdPais=@IdPais)