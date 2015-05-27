CREATE Procedure [dbo].[Clientes_E]

@IdCliente int  

AS 

DELETE Clientes
WHERE (IdCliente=@IdCliente)
