

CREATE Procedure [dbo].[DetControlesCalidad_M]
@IdDetalleControlCalidad int,
@IdDetalleRecepcion int,
@IdRecepcion int,
@Fecha datetime,
@IdMotivoRechazo int,
@Cantidad numeric(18,2),
@Observaciones ntext,
@CantidadAdicional numeric(18,2),
@IdRealizo int,
@CantidadRechazada numeric(18,2),
@Trasabilidad varchar(10),
@IdDetalleOtroIngresoAlmacen int,
@NumeroRemitoRechazo int,
@FechaRemitoRechazo datetime,
@IdProveedorRechazo int

AS 

BEGIN TRAN

DECLARE @CantOrig numeric(18,2), @CantAcep numeric(18,2), @CantRech numeric(18,2), 
	@Estado varchar(2), @IdArticuloOrig int, @PartidaOrig varchar(20), @CantidadOrig numeric(18,2), 
	@IdUnidadOrig int, @IdUbicacionOrig int, @IdObraOrig int, @IdStock int

IF @IdDetalleRecepcion is not null
   BEGIN
	SET @CantOrig=IsNull((Select Sum(IsNull(Det.Cantidad,0))
				From DetalleRecepciones Det 
				Where Det.IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @CantAcep=IsNull((Select Sum(IsNull(Det.Cantidad,0))
				From DetalleControlesCalidad Det
				Where IsNull(Det.IdDetalleRecepcion,0)=@IdDetalleRecepcion and 
					Det.IdDetalleControlCalidad<>@IdDetalleControlCalidad),0)
	SET @CantRech=IsNull((Select Sum(IsNull(Det.CantidadRechazada,0))
				From DetalleControlesCalidad Det
				Where IsNull(Det.IdDetalleRecepcion,0)=@IdDetalleRecepcion and 
					Det.IdDetalleControlCalidad<>@IdDetalleControlCalidad),0)
	SET @CantAcep=@CantAcep+IsNull(@Cantidad,0)
	SET @CantRech=@CantRech+IsNull(@CantidadRechazada,0)

	IF @CantOrig>@CantAcep+@CantRech
		SET @Estado='PA'
	ELSE
		SET @Estado='DI'

	SET @IdArticuloOrig=IsNull((Select Top 1 IdArticulo From DetalleRecepciones 
				   Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @PartidaOrig=IsNull((Select Top 1 Partida From DetalleRecepciones 
				 Where IdDetalleRecepcion=@IdDetalleRecepcion),'')
	SET @CantidadOrig=IsNull((Select Top 1 CantidadCC From DetalleRecepciones 
					Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @IdUnidadOrig=IsNull((Select Top 1 IdUnidad From DetalleRecepciones 
					Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @IdUbicacionOrig=IsNull((Select Top 1 IdUbicacion From DetalleRecepciones 
					Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @IdObraOrig=IsNull((Select Top 1 IdObra From DetalleRecepciones 
				Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @IdStock=IsNull((Select Top 1 Stock.IdStock
				From Stock 
				Where IdArticulo=@IdArticuloOrig and Partida=@PartidaOrig and 
					IdUbicacion=@IdUbicacionOrig and IdObra=@IdObraOrig and 
					IdUnidad=@IdUnidadOrig),0)
	IF @IdStock>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)-@CantidadOrig
		WHERE IdStock=@IdStock
	ELSE
	   BEGIN
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional,
					IdUnidad, IdUbicacion, IdObra)
		VALUES (@IdArticuloOrig, @PartidaOrig, @CantidadOrig*-1, Null, @IdUnidadOrig, 
			@IdUbicacionOrig, @IdObraOrig)
		SET @IdStock=@@identity
	   END
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)+@CantAcep
	WHERE IdStock=@IdStock

	UPDATE DetalleRecepciones
	SET Controlado=@Estado, CantidadCC=@CantAcep, CantidadRechazadaCC=@CantRech
	WHERE IdDetalleRecepcion=@IdDetalleRecepcion
   END

IF @IdDetalleOtroIngresoAlmacen is not null
   BEGIN
	SET @CantOrig=IsNull((Select Sum(IsNull(Det.Cantidad,0))
				From DetalleOtrosIngresosAlmacen Det 
				Where Det.IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @CantAcep=IsNull((Select Sum(IsNull(Det.Cantidad,0))
				From DetalleControlesCalidad Det
				Where IsNull(Det.IdDetalleOtroIngresoAlmacen,0)=@IdDetalleOtroIngresoAlmacen and 
					Det.IdDetalleControlCalidad<>@IdDetalleControlCalidad),0)
	SET @CantRech=IsNull((Select Sum(IsNull(Det.CantidadRechazada,0))
				From DetalleControlesCalidad Det
				Where IsNull(Det.IdDetalleOtroIngresoAlmacen,0)=@IdDetalleOtroIngresoAlmacen and 
					Det.IdDetalleControlCalidad<>@IdDetalleControlCalidad),0)
	SET @CantAcep=@CantAcep+IsNull(@Cantidad,0)
	SET @CantRech=@CantRech+IsNull(@CantidadRechazada,0)

	IF @CantOrig>@CantAcep+@CantRech
		SET @Estado='PA'
	ELSE
		SET @Estado='DI'

	SET @IdArticuloOrig=IsNull((Select Top 1 IdArticulo From DetalleOtrosIngresosAlmacen 
				   Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @PartidaOrig=IsNull((Select Top 1 Partida From DetalleOtrosIngresosAlmacen 
				   Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),'')
	SET @CantidadOrig=IsNull((Select Top 1 CantidadCC From DetalleOtrosIngresosAlmacen 
				   Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @IdUnidadOrig=IsNull((Select Top 1 IdUnidad From DetalleOtrosIngresosAlmacen 
				   Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @IdUbicacionOrig=IsNull((Select Top 1 IdUbicacion From DetalleOtrosIngresosAlmacen 
				   Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @IdObraOrig=IsNull((Select Top 1 IdObra From DetalleOtrosIngresosAlmacen 
				   Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @IdStock=IsNull((Select Top 1 Stock.IdStock
				From Stock 
				Where IdArticulo=@IdArticuloOrig and Partida=@PartidaOrig and 
					IdUbicacion=@IdUbicacionOrig and IdObra=@IdObraOrig and 
					IdUnidad=@IdUnidadOrig),0)
	IF @IdStock>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)-@CantidadOrig
		WHERE IdStock=@IdStock
	ELSE
	   BEGIN
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional,
					IdUnidad, IdUbicacion, IdObra)
		VALUES (@IdArticuloOrig, @PartidaOrig, @CantidadOrig*-1, Null, @IdUnidadOrig, 
			@IdUbicacionOrig, @IdObraOrig)
		SET @IdStock=@@identity
	   END
	UPDATE Stock
	SET CantidadUnidades=IsNull(CantidadUnidades,0)+@CantAcep
	WHERE IdStock=@IdStock

	UPDATE DetalleOtrosIngresosAlmacen
	SET Controlado=@Estado, CantidadCC=@CantAcep, CantidadRechazadaCC=@CantRech
	WHERE IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen
   END

UPDATE [DetalleControlesCalidad]
SET 
 IdDetalleRecepcion=@IdDetalleRecepcion,
 IdRecepcion=@IdRecepcion,
 Fecha=@Fecha,
 IdMotivoRechazo=@IdMotivoRechazo,
 Cantidad=@Cantidad,
 Observaciones=@Observaciones,
 CantidadAdicional=@CantidadAdicional,
 IdRealizo=@IdRealizo,
 CantidadRechazada=@CantidadRechazada,
 Trasabilidad=@Trasabilidad,
 IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen,
 NumeroRemitoRechazo=@NumeroRemitoRechazo,
 FechaRemitoRechazo=@FechaRemitoRechazo,
 IdProveedorRechazo=@IdProveedorRechazo
WHERE (IdDetalleControlCalidad=@IdDetalleControlCalidad)

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleControlCalidad)

