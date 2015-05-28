CREATE Procedure [dbo].[DetOtrosIngresosAlmacen_A]

@IdDetalleOtroIngresoAlmacen int  output,
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

DECLARE @IdStock1 int, @Anulado varchar(2), @Controlar varchar(2)

SET @Anulado=IsNull((Select Top 1 OtrosIngresosAlmacen.Anulado From OtrosIngresosAlmacen Where OtrosIngresosAlmacen.IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen),'NO')
SET @Controlar=IsNull((Select Top 1 ControlesCalidad.Inspeccion From ControlesCalidad Where ControlesCalidad.IdControlCalidad=@IdControlCalidad),'NO')

IF @Controlar='SI'
   BEGIN
	SET @Controlado=Null
	SET @CantidadCC=0
   END
ELSE
   BEGIN
	SET @Controlado='DI'
	SET @CantidadCC=@Cantidad
   END

IF @Anulado<>'SI'
   BEGIN
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

INSERT INTO [DetalleOtrosIngresosAlmacen]
(
 IdOtroIngresoAlmacen,
 IdArticulo,
 IdStock,
 Partida,
 Cantidad,
 CantidadAdicional,
 IdUnidad,
 Cantidad1,
 Cantidad2,
 Adjunto,
 ArchivoAdjunto1,
 ArchivoAdjunto2,
 ArchivoAdjunto3,
 ArchivoAdjunto4,
 ArchivoAdjunto5,
 ArchivoAdjunto6,
 ArchivoAdjunto7,
 ArchivoAdjunto8,
 ArchivoAdjunto9,
 ArchivoAdjunto10,
 Observaciones,
 IdUbicacion,
 IdObra,
 EnviarEmail,
 IdDetalleOtroIngresoAlmacenOriginal,
 IdOtroIngresoAlmacenOriginal,
 IdOrigenTransmision,
 CostoUnitario,
 IdMoneda,
 IdControlCalidad,
 Controlado,
 CantidadCC,
 CantidadRechazadaCC,
 IdDetalleSalidaMateriales,
 IdEquipoDestino,
 IdOrdenTrabajo,
 IdDetalleObraDestino,
 Talle,
 IdColor
)
VALUES
(
 @IdOtroIngresoAlmacen,
 @IdArticulo,
 @IdStock,
 @Partida,
 @Cantidad,
 @CantidadAdicional,
 @IdUnidad,
 @Cantidad1,
 @Cantidad2,
 @Adjunto,
 @ArchivoAdjunto1,
 @ArchivoAdjunto2,
 @ArchivoAdjunto3,
 @ArchivoAdjunto4,
 @ArchivoAdjunto5,
 @ArchivoAdjunto6,
 @ArchivoAdjunto7,
 @ArchivoAdjunto8,
 @ArchivoAdjunto9,
 @ArchivoAdjunto10,
 @Observaciones,
 @IdUbicacion,
 @IdObra,
 @EnviarEmail,
 @IdDetalleOtroIngresoAlmacenOriginal,
 @IdOtroIngresoAlmacenOriginal,
 @IdOrigenTransmision,
 @CostoUnitario,
 @IdMoneda,
 @IdControlCalidad,
 @Controlado,
 @CantidadCC,
 @CantidadRechazadaCC,
 @IdDetalleSalidaMateriales,
 @IdEquipoDestino,
 @IdOrdenTrabajo,
 @IdDetalleObraDestino,
 @Talle,
 @IdColor
)

SELECT @IdDetalleOtroIngresoAlmacen=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleOtroIngresoAlmacen)