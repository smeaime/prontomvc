CREATE Procedure [dbo].[DetClientesTelefonos_A]

@IdDetalleClienteTelefono int  output,
@IdCliente int,
@Detalle varchar(50),
@Telefono varchar(50)

AS 

INSERT INTO [DetalleClientesTelefonos]
(
 IdCliente,
 Detalle,
 Telefono
)
VALUES
(
 @IdCliente,
 @Detalle,
 @Telefono
)

SELECT @IdDetalleClienteTelefono=@@identity

RETURN(@IdDetalleClienteTelefono)