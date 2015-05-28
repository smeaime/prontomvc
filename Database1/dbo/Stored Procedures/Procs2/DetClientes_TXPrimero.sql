CREATE Procedure [dbo].[DetClientes_TXPrimero]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111133'
SET @vector_T='00211100'

SELECT TOP 1
 DetalleClientes.IdDetalleCliente,
 DetalleClientes.IdCliente,
 DetalleClientes.Contacto,
 DetalleClientes.Puesto,
 DetalleClientes.Telefono,
 DetalleClientes.Email,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleClientes