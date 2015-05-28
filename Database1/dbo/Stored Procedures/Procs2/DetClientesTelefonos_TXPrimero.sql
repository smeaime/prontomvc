CREATE Procedure [dbo].[DetClientesTelefonos_TXPrimero]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001133'
SET @vector_T='008700'

SELECT TOP 1
 DetalleClientesTelefonos.IdDetalleClienteTelefono,
 DetalleClientesTelefonos.IdCliente,
 DetalleClientesTelefonos.Detalle,
 DetalleClientesTelefonos.Telefono,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleClientesTelefonos