CREATE Procedure [dbo].[DetDevoluciones_M]

@IdDetalleDevolucion int,
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

DECLARE @IdStockAnt int, @IdArticuloAnt int, @PartidaAnt varchar(20), @CantidadUnidadesAnt numeric(18,2), @IdUnidadAnt int, @IdUbicacionAnt int, @IdObraAnt int, 
	@IdStock int, @NumeroCajaAnt int, @IdColorAnt int, @TalleAnt varchar(2)

SET @IdArticuloAnt=IsNull((Select Top 1 IdArticulo From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion),0)
SET @PartidaAnt=IsNull((Select Top 1 Partida From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion),'')
SET @CantidadUnidadesAnt=IsNull((Select Top 1 Cantidad From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion),0)
SET @IdUnidadAnt=IsNull((Select Top 1 IdUnidad From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion),0)
SET @IdUbicacionAnt=IsNull((Select Top 1 IdUbicacion From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion),0)
SET @IdObraAnt=IsNull((Select Top 1 IdObra From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion),0)
SET @NumeroCajaAnt=IsNull((Select Top 1 NumeroCaja From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion),0)
SET @IdColorAnt=IsNull((Select Top 1 IdColor From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion),0)
SET @TalleAnt=(Select Top 1 Talle From DetalleDevoluciones Where IdDetalleDevolucion=@IdDetalleDevolucion)

SET @IdStockAnt=IsNull((Select Top 1 Stock.IdStock From Stock 
			Where IdArticulo=@IdArticuloAnt and Partida=@PartidaAnt and IdUbicacion=@IdUbicacionAnt and IdObra=@IdObraAnt and IdUnidad=@IdUnidadAnt and 
				IsNull(NumeroCaja,0)=IsNull(@NumeroCajaAnt,0) and IsNull(IdColor,0)=IsNull(@IdColorAnt,0) and IsNull(Talle,'')=IsNull(@TalleAnt,'')),0)
IF @IdStockAnt>0 
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)-@CantidadUnidadesAnt
	WHERE IdStock=@IdStockAnt
ELSE
	INSERT INTO Stock 
	(IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
	VALUES 
	(@IdArticuloAnt, @PartidaAnt, @CantidadUnidadesAnt*-1, Null, @IdUnidadAnt, @IdUbicacionAnt, @IdObraAnt, @NumeroCajaAnt, @IdColorAnt, @TalleAnt)

SET @IdStock=IsNull((Select Top 1 Stock.IdStock From Stock 
			Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and 
				IsNull(NumeroCaja,0)=IsNull(@NumeroCaja,0) and IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
IF @IdStock>0 
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)+@Cantidad
	WHERE IdStock=@IdStock
ELSE
	INSERT INTO Stock 
	(IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, NumeroCaja, IdColor, Talle)
	VALUES 
	(@IdArticulo, @Partida, @Cantidad, Null, @IdUnidad, @IdUbicacion, @IdObra, @NumeroCaja, @IdColor, @Talle)

UPDATE [DetalleDevoluciones]
SET 
 IdDevolucion=@IdDevolucion,
 NumeroDevolucion=@NumeroDevolucion,
 TipoABC=@TipoABC,
 PuntoVenta=@PuntoVenta,
 IdArticulo=@IdArticulo,
 CodigoArticulo=@CodigoArticulo,
 Cantidad=@Cantidad,
 Partida=@Partida,
 Costo=@Costo,
 PrecioUnitario=@PrecioUnitario,
 Bonificacion=@Bonificacion,
 IdUnidad=@IdUnidad,
 OrigenDescripcion=@OrigenDescripcion,
 Observaciones=@Observaciones,
 PorcentajeCertificacion=@PorcentajeCertificacion,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 NumeroCaja=@NumeroCaja,
 IdDetalleFactura=@IdDetalleFactura,
 Talle=@Talle,
 IdColor=@IdColor,
 IdDetallePresupuestoVenta=@IdDetallePresupuestoVenta
WHERE (IdDetalleDevolucion=@IdDetalleDevolucion)

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleDevolucion)