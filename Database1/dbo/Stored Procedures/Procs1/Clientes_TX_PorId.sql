
CREATE Procedure Clientes_TX_PorId
@IdCliente int
AS 
SELECT * 
FROM Clientes
WHERE (IdCliente=@IdCliente)

