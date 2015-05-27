



CREATE Procedure [dbo].[DetProveedores_TXPrimero]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='00111133'
Set @vector_T='00211100'

SELECT TOP 1
 DetalleProveedores.IdDetalleProveedor,
 DetalleProveedores.IdProveedor,
 DetalleProveedores.Contacto,
 DetalleProveedores.Puesto,
 DetalleProveedores.Telefono,
 DetalleProveedores.Email,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProveedores



