CREATE Procedure [dbo].[Clientes_TX_Busca]

@Buscar varchar(100)

AS 

SELECT IdCliente, RazonSocial as [Titulo]
FROM Clientes
WHERE RazonSocial LIKE '%' + @buscar + '%' 
ORDER BY RazonSocial