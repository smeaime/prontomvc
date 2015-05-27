
CREATE Procedure [dbo].[OtrosIngresosAlmacen_A]

@IdOtroIngresoAlmacen int  output,
@NumeroOtroIngresoAlmacen int,
@FechaOtroIngresoAlmacen datetime,
@IdObra int,
@Observaciones ntext,
@Aprobo int,
@TipoIngreso int,
@Emitio int,
@FechaRegistracion datetime,
@EnviarEmail tinyint,
@IdOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime,
@Anulado varchar(2),
@IdAutorizaAnulacion int,
@FechaAnulacion datetime,
@IdSalidaMateriales int = Null,
@CircuitoFirmasCompleto varchar(2) = Null

AS 

BEGIN TRAN

BEGIN
	SET @NumeroOtroIngresoAlmacen=IsNull((Select Top 1 ProximoNumeroOtroIngresoAlmacen From Parametros Where IdParametro=1),1)
	UPDATE Parametros
	SET ProximoNumeroOtroIngresoAlmacen=@NumeroOtroIngresoAlmacen+1
END

INSERT INTO OtrosIngresosAlmacen
(
 NumeroOtroIngresoAlmacen,
 FechaOtroIngresoAlmacen,
 IdObra,
 Observaciones,
 Aprobo,
 TipoIngreso,
 Emitio,
 FechaRegistracion,
 EnviarEmail,
 IdOtroIngresoAlmacenOriginal,
 IdOrigenTransmision,
 FechaImportacionTransmision,
 Anulado,
 IdAutorizaAnulacion,
 FechaAnulacion,
 IdSalidaMateriales,
 CircuitoFirmasCompleto
)
VALUES 
(
 @NumeroOtroIngresoAlmacen,
 @FechaOtroIngresoAlmacen,
 @IdObra,
 @Observaciones,
 @Aprobo,
 @TipoIngreso,
 @Emitio,
 GetDate(),
 @EnviarEmail,
 @IdOtroIngresoAlmacenOriginal,
 @IdOrigenTransmision,
 @FechaImportacionTransmision,
 @Anulado,
 @IdAutorizaAnulacion,
 @FechaAnulacion,
 @IdSalidaMateriales,
 @CircuitoFirmasCompleto
)

SELECT @IdOtroIngresoAlmacen=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdOtroIngresoAlmacen)
