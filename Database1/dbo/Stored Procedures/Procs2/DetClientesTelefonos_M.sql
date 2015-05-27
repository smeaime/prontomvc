CREATE Procedure [dbo].[DetClientesTelefonos_M]

@IdDetalleClienteTelefono int,
@IdCliente int,
@Detalle varchar(50),
@Telefono varchar(50)

AS

UPDATE [DetalleClientesTelefonos]
SET 
 IdCliente=@IdCliente,
 Detalle=@Detalle,
 Telefono=@Telefono
WHERE (IdDetalleClienteTelefono=@IdDetalleClienteTelefono)

RETURN(@IdDetalleClienteTelefono)