CREATE Procedure [dbo].[DetDevoluciones_A]

@IdDetalleDevolucion int  output,
@IdDevolucion int,
@NumeroDevolucion int,
@TipoABC varchar(1),
@PuntoVenta int,
@IdArticulo int,
@CodigoArticulo varchar(20),
@Cantidad numeric(18,3),
@Partida varchar(20),
@Costo  numeric(19,8),
@PrecioUnitario  numeric(19,8),
@Bonificacion numeric(12,2),
@IdUnidad int,
@OrigenDescripcion int,
@Observaciones ntext,
@PorcentajeCertificacion numeric(12,6),
@IdUbicacion int,
@IdObra int,
@NumeroCaja int,
@IdDetalleFactura int,
@Talle varchar(2),
@IdColor int,
@IdDetallePresupuestoVenta int

AS 

BEGIN TRAN

DECLARE @IdStock int

SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock 
			Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and 
				IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
IF @IdStock>0 
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
	WHERE IdStock=@IdStock
ELSE
	INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
	VALUES (@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @Talle)

INSERT INTO [DetalleDevoluciones]
(
 IdDevolucion,
 NumeroDevolucion,
 TipoABC,
 PuntoVenta,
 IdArticulo,
 CodigoArticulo,
 Cantidad,
 Partida,
 Costo,
 PrecioUnitario,
 Bonificacion,
 IdUnidad,
 OrigenDescripcion,
 Observaciones,
 PorcentajeCertificacion,
 IdUbicacion,
 IdObra,
 NumeroCaja,
 IdDetalleFactura,
 Talle,
 IdColor,
 IdDetallePresupuestoVenta
)
VALUES
(
 @IdDevolucion,
 @NumeroDevolucion,
 @TipoABC,
 @PuntoVenta,
 @IdArticulo,
 @CodigoArticulo,
 @Cantidad,
 @Partida,
 @Costo,
 @PrecioUnitario,
 @Bonificacion,
 @IdUnidad,
 @OrigenDescripcion,
 @Observaciones,
 @PorcentajeCertificacion,
 @IdUbicacion,
 @IdObra,
 @NumeroCaja,
 @IdDetalleFactura,
 @Talle,
 @IdColor,
 @IdDetallePresupuestoVenta
)

SELECT @IdDetalleDevolucion=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleDevolucion)