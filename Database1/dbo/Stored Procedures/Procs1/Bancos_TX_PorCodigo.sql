










CREATE Procedure [dbo].[Bancos_TX_PorCodigo]
@Codigo int
AS 
SELECT *
FROM Bancos
WHERE (Codigo=@Codigo)











