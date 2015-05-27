CREATE Procedure [dbo].[DetClientesLugaresEntrega_M]

@IdDetalleClienteLugarEntrega int,
@IdCliente int,
@DireccionEntrega varchar(50),
@IdLocalidadEntrega int,
@IdProvinciaEntrega int

AS

UPDATE [DetalleClientesLugaresEntrega]
SET 
 IdCliente=@IdCliente,
 DireccionEntrega=@DireccionEntrega,
 IdLocalidadEntrega=@IdLocalidadEntrega,
 IdProvinciaEntrega=@IdProvinciaEntrega
WHERE (IdDetalleClienteLugarEntrega=@IdDetalleClienteLugarEntrega)

RETURN(@IdDetalleClienteLugarEntrega)