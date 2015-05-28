CREATE Procedure [dbo].[DetClientes_E]

@IdDetalleCliente int  

AS

DELETE DetalleClientes
WHERE (IdDetalleCliente=@IdDetalleCliente)