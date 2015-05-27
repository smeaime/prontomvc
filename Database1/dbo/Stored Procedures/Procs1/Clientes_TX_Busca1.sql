CREATE Procedure [dbo].[Clientes_TX_Busca1]

@Buscar varchar(100)

AS 

SELECT IdCliente, RazonSocial as [Titulo]
FROM Clientes
WHERE (RazonSocial LIKE '%' + @buscar + '%' OR Codigo LIKE '%' + @buscar + '%')
ORDER BY [Titulo]