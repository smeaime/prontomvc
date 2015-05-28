CREATE Procedure [dbo].[DetClientesLugaresEntrega_TX_TodosSinFormato]

@IdCliente int

AS 

SELECT *
FROM DetalleClientesLugaresEntrega
WHERE (IdCliente=@IdCliente)