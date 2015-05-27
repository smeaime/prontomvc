CREATE Procedure [dbo].[DetClientesLugaresEntrega_A]

@IdDetalleClienteLugarEntrega int  output,
@IdCliente int,
@DireccionEntrega varchar(50),
@IdLocalidadEntrega int,
@IdProvinciaEntrega int

AS 

INSERT INTO [DetalleClientesLugaresEntrega]
(
 IdCliente,
 DireccionEntrega,
 IdLocalidadEntrega,
 IdProvinciaEntrega
)
VALUES
(
 @IdCliente,
 @DireccionEntrega,
 @IdLocalidadEntrega,
 @IdProvinciaEntrega
)

SELECT @IdDetalleClienteLugarEntrega=@@identity
RETURN(@IdDetalleClienteLugarEntrega)