
CREATE Procedure [dbo].[DetClientes_TX_TodosSinFormato]

@IdCliente int

AS 

SELECT *
FROM DetalleClientes
WHERE (IdCliente=@IdCliente)
