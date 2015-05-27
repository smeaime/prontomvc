CREATE Procedure [dbo].[Paises_TX_TT]

@IdPais int

AS 

SELECT *
FROM Paises
WHERE (IdPais=@IdPais)