
CREATE Procedure [dbo].[Vendedores_TX_PorCodigo]

@CodigoVendedor int

AS 

SELECT * 
FROM Vendedores
WHERE (CodigoVendedor=@CodigoVendedor)
