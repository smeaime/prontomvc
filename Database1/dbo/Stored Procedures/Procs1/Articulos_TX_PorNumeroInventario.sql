CREATE Procedure [dbo].[Articulos_TX_PorNumeroInventario]

@NumeroInventario varchar(20)

AS 

SELECT *
FROM Articulos 
WHERE NumeroInventario=@NumeroInventario