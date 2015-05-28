



CREATE Procedure [dbo].[DetProveedores_TXDetPrv]
@IdProveedor int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='00111133'
set @vector_T='00211100'
Select 
 DetalleProveedores.IdDetalleProveedor,
 DetalleProveedores.IdProveedor,
 DetalleProveedores.Contacto,
 DetalleProveedores.Puesto,
 DetalleProveedores.Telefono,
 DetalleProveedores.Email,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProveedores
WHERE (DetalleProveedores.IdProveedor = @IdProveedor)



