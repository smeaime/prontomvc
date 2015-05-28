CREATE Procedure [dbo].[Paises_T]

@IdPais int

AS 

SELECT*
FROM Paises
WHERE (IdPais=@IdPais)