CREATE PROCEDURE [dbo].[OrdenesCompra_MarcarComoProducidas]

@IdOrdenCompra int,
@Marca varchar(2),
@IdUsuarioCambioEstado int,
@FechaCambioEstado datetime,
@IdDetalleOrdenCompra int = Null

AS 

SET @IdDetalleOrdenCompra=IsNull(@IdDetalleOrdenCompra,0)

IF @IdOrdenCompra>0
    BEGIN
	UPDATE OrdenesCompra
	SET Estado=@Marca, IdUsuarioCambioEstado=@IdUsuarioCambioEstado, FechaCambioEstado=@FechaCambioEstado
	WHERE IdOrdenCompra=@IdOrdenCompra

	UPDATE DetalleOrdenesCompra
	SET Estado=@Marca, IdUsuarioCambioEstado=@IdUsuarioCambioEstado, FechaCambioEstado=@FechaCambioEstado
	WHERE IdOrdenCompra=@IdOrdenCompra
    END

IF @IdDetalleOrdenCompra>0
    BEGIN
	SET @IdOrdenCompra=IsNull((Select Top 1 IdOrdenCompra From DetalleOrdenesCompra Where IdDetalleOrdenCompra=@IdDetalleOrdenCompra),0)

	UPDATE DetalleOrdenesCompra
	SET Estado=@Marca, IdUsuarioCambioEstado=@IdUsuarioCambioEstado, FechaCambioEstado=@FechaCambioEstado
	WHERE IdDetalleOrdenCompra=@IdDetalleOrdenCompra

	UPDATE OrdenesCompra
	SET Estado=Null, IdUsuarioCambioEstado=Null, FechaCambioEstado=Null
	WHERE IdOrdenCompra=@IdOrdenCompra
	IF Not Exists(Select Top 1 IdOrdenCompra From DetalleOrdenesCompra Where IdOrdenCompra=@IdOrdenCompra and IsNull(Estado,'')<>'SI')
		UPDATE OrdenesCompra
		SET Estado=@Marca, IdUsuarioCambioEstado=@IdUsuarioCambioEstado, FechaCambioEstado=@FechaCambioEstado
		WHERE IdOrdenCompra=@IdOrdenCompra
    END