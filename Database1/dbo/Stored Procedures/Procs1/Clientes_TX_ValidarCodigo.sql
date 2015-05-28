CREATE Procedure [dbo].[Clientes_TX_ValidarCodigo]

@CodigoCliente int,
@TipoCliente int,
@IdCliente int

AS 

SELECT * 
FROM Clientes
WHERE (@IdCliente<=0 or IdCliente<>@IdCliente) and CodigoCliente=@CodigoCliente and TipoCliente=@TipoCliente