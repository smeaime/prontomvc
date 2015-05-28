






























CREATE Procedure [dbo].[Vendedores_TXCod]
@CodVen int
As
SELECT IdVendedor, Nombre
FROM Vendedores
WHERE (CodigoVendedor = @CodVen)





























