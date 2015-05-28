CREATE Procedure [dbo].[DetClientes_T]

@IdDetalleCliente int

AS 

SELECT *
FROM DetalleClientes
WHERE (IdDetalleCliente=@IdDetalleCliente)