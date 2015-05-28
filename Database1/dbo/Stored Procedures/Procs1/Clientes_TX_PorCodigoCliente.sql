CREATE Procedure [dbo].[Clientes_TX_PorCodigoCliente]

@CodigoCliente int

AS 

SELECT * 
FROM Clientes
WHERE (CodigoCliente=@CodigoCliente)