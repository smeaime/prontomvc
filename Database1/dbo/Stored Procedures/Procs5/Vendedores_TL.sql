CREATE Procedure [dbo].[Vendedores_TL]

AS 

SELECT IdVendedor,Nombre as [Titulo]
FROM Vendedores 
ORDER BY Nombre