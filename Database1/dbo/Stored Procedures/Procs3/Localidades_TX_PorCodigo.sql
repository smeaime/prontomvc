CREATE Procedure [dbo].[Localidades_TX_PorCodigo]

@Codigo int

AS 

SELECT *
FROM Localidades
WHERE Codigo=@Codigo