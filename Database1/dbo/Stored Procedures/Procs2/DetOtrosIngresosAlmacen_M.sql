CREATE Procedure [dbo].[DetOtrosIngresosAlmacen_M]

@IdDetalleOtroIngresoAlmacen int,
@IdOtroIngresoAlmacen int,
@IdArticulo int,
@IdStock int,
@Partida varchar(20),
@Cantidad numeric(12,2),
@CantidadAdicional numeric(12,2),
@IdUnidad int,
@Cantidad1 numeric(12,2),
@Cantidad2 numeric(12,2),
@Adjunto varchar(2),
@ArchivoAdjunto1 varchar(100),
@ArchivoAdjunto2 varchar(100),
@ArchivoAdjunto3 varchar(100),
@ArchivoAdjunto4 varchar(100),
@ArchivoAdjunto5 varchar(100),
@ArchivoAdjunto6 varchar(100),
@ArchivoAdjunto7 varchar(100),
@ArchivoAdjunto8 varchar(100),
@ArchivoAdjunto9 varchar(100),
@ArchivoAdjunto10 varchar(100),
@Observaciones ntext,
@IdUbicacion int,
@IdObra int,
@EnviarEmail tinyint,
@IdDetalleOtroIngresoAlmacenOriginal int,
@IdOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int,
@CostoUnitario numeric(18,2),
@IdMoneda int,
@IdControlCalidad int,
@Controlado varchar(2),
@CantidadCC numeric(18,2),
@CantidadRechazadaCC numeric(18,2),
@IdDetalleSalidaMateriales int = Null,
@IdEquipoDestino int = Null,
@IdOrdenTrabajo int = Null,
@IdDetalleObraDestino int = Null,
@Talle varchar(2) = Null,
@IdColor int = Null

AS

BEGIN TRAN

DECLARE @IdStockAnt int, @IdArticuloAnt int, @PartidaAnt varchar(20), @CantidadUnidadesAnt numeric(18,2), @IdUnidadAnt int, @IdUbicacionAnt int, @IdObraAnt int, @IdStock1 int, @Anulado varchar(2), 
	@Controlar varchar(2), @TalleAnt varchar(20), @IdColorAnt int

SET @Anulado=IsNull((Select Top 1 OtrosIngresosAlmacen.Anulado From OtrosIngresosAlmacen Where OtrosIngresosAlmacen.IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen),'NO')
SET @Controlar=IsNull((Select Top 1 ControlesCalidad.Inspeccion From ControlesCalidad Where ControlesCalidad.IdControlCalidad=@IdControlCalidad),'NO')

IF @Controlar='SI'
   BEGIN
	SET @Controlado=Null
	IF @CantidadCC is null
		SET @CantidadCC=0
   END
ELSE
   BEGIN
	SET @Controlado='DI'
	SET @CantidadCC=@Cantidad
   END

IF @Anulado<>'SI'
   BEGIN
	SET @IdArticuloAnt=IsNull((Select Top 1 IdArticulo From DetalleOtrosIngresosAlmacen Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @PartidaAnt=IsNull((Select Top 1 Partida From DetalleOtrosIngresosAlmacen Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),'')
	SET @CantidadUnidadesAnt=IsNull((Select Top 1 CantidadCC From DetalleOtrosIngresosAlmacen Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @IdUnidadAnt=IsNull((Select Top 1 IdUnidad From DetalleOtrosIngresosAlmacen Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @IdUbicacionAnt=IsNull((Select Top 1 IdUbicacion From DetalleOtrosIngresosAlmacen Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @IdObraAnt=IsNull((Select Top 1 IdObra From DetalleOtrosIngresosAlmacen Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)
	SET @TalleAnt=(Select Top 1 Talle From DetalleOtrosIngresosAlmacen Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen)
	SET @IdColorAnt=IsNull((Select Top 1 IdColor From DetalleOtrosIngresosAlmacen Where IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen),0)

	SET @IdStockAnt=IsNull((Select Top 1 Stock.IdStock From Stock 
				Where IdArticulo=@IdArticuloAnt and Partida=@PartidaAnt and IdUbicacion=@IdUbicacionAnt and IdObra=@IdObraAnt and IdUnidad=@IdUnidadAnt and 
					IsNull(IdColor,0)=IsNull(@IdColorAnt,0) and IsNull(Talle,'')=IsNull(@TalleAnt,'')),0)
	IF @IdStockAnt>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)-@CantidadUnidadesAnt
		WHERE IdStock=@IdStockAnt
	ELSE
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, IdColor, Talle)
		VALUES (@IdArticuloAnt, @PartidaAnt, @CantidadUnidadesAnt*-1, Null, @IdUnidadAnt, @IdUbicacionAnt, @IdObraAnt, @IdColorAnt, @TalleAnt)
	
	SET @IdStock1=IsNull((Select Top 1 Stock.IdStock From Stock 
				Where IdArticulo=@IdArticulo and Partida=@Partida and IdUbicacion=@IdUbicacion and IdObra=@IdObra and IdUnidad=@IdUnidad and 
					IsNull(IdColor,0)=IsNull(@IdColor,0) and IsNull(Talle,'')=IsNull(@Talle,'')),0)
	IF @IdStock1>0 
		UPDATE Stock
		SET CantidadUnidades=IsNull(CantidadUnidades,0)+IsNull(@CantidadCC,0)
		WHERE IdStock=@IdStock1
	ELSE
		INSERT INTO Stock (IdArticulo, Partida, CantidadUnidades, CantidadAdicional, IdUnidad, IdUbicacion, IdObra, IdColor, Talle)
		VALUES (@IdArticulo, @Partida, IsNull(@CantidadCC,0), Null, @IdUnidad, @IdUbicacion, @IdObra, @IdColor, @Talle)
   END

UPDATE [DetalleOtrosIngresosAlmacen]
SET 
 IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen,
 IdArticulo=@IdArticulo,
 IdStock=@IdStock,
 Partida=@Partida,
 Cantidad=@Cantidad,
 CantidadAdicional=@CantidadAdicional,
 IdUnidad=@IdUnidad,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 Adjunto=@Adjunto,
 ArchivoAdjunto1=@ArchivoAdjunto1,
 ArchivoAdjunto2=@ArchivoAdjunto2,
 ArchivoAdjunto3=@ArchivoAdjunto3,
 ArchivoAdjunto4=@ArchivoAdjunto4,
 ArchivoAdjunto5=@ArchivoAdjunto5,
 ArchivoAdjunto6=@ArchivoAdjunto6,
 ArchivoAdjunto7=@ArchivoAdjunto7,
 ArchivoAdjunto8=@ArchivoAdjunto8,
 ArchivoAdjunto9=@ArchivoAdjunto9,
 ArchivoAdjunto10=@ArchivoAdjunto10,
 Observaciones=@Observaciones,
 IdUbicacion=@IdUbicacion,
 IdObra=@IdObra,
 EnviarEmail=@EnviarEmail,
 IdDetalleOtroIngresoAlmacenOriginal=@IdDetalleOtroIngresoAlmacenOriginal,
 IdOtroIngresoAlmacenOriginal=@IdOtroIngresoAlmacenOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 CostoUnitario=@CostoUnitario,
 IdMoneda=@IdMoneda,
 IdControlCalidad=@IdControlCalidad,
 Controlado=@Controlado,
 CantidadCC=@CantidadCC,
 CantidadRechazadaCC=@CantidadRechazadaCC,
 IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales,
 IdEquipoDestino=@IdEquipoDestino,
 IdOrdenTrabajo=@IdOrdenTrabajo,
 IdDetalleObraDestino=@IdDetalleObraDestino,
 Talle=@Talle,
 IdColor=@IdColor
WHERE (IdDetalleOtroIngresoAlmacen=@IdDetalleOtroIngresoAlmacen)

IF @@ERROR <> 0 
GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleOtroIngresoAlmacen)