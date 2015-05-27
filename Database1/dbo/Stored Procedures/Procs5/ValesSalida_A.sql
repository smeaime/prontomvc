CREATE Procedure [dbo].[ValesSalida_A]
@IdValeSalida int  output,
@NumeroValeSalida int,
@FechaValeSalida datetime,
@IdObra int,
@Observaciones ntext,
@IdCentroCosto int,
@Aprobo int,
@NumeroValePreimpreso int,
@Cumplido varchar(2),
@EnviarEmail tinyint,
@IdValeSalidaOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime,
@IdUsuarioAnulo int,
@FechaAnulacion datetime,
@MotivoAnulacion ntext,
@CircuitoFirmasCompleto varchar(2),
@IdUsuarioDioPorCumplido int,
@FechaDioPorCumplido datetime,
@MotivoDioPorCumplido ntext

AS

BEGIN TRAN

BEGIN
	SET @NumeroValeSalida=IsNull((Select Top 1 P.ProximoNumeroValeSalida From Parametros P Where P.IdParametro=1),1)
	UPDATE Parametros
	SET ProximoNumeroValeSalida=@NumeroValeSalida+1
END

INSERT INTO ValesSalida
(
 NumeroValeSalida,
 FechaValeSalida,
 IdObra,
 Observaciones,
 IdCentroCosto,
 Aprobo,
 NumeroValePreimpreso,
 Cumplido,
 EnviarEmail,
 IdValeSalidaOriginal,
 IdOrigenTransmision,
 FechaImportacionTransmision,
 IdUsuarioAnulo,
 FechaAnulacion,
 MotivoAnulacion,
 CircuitoFirmasCompleto,
 IdUsuarioDioPorCumplido,
 FechaDioPorCumplido,
 MotivoDioPorCumplido
)
VALUES
(
 @NumeroValeSalida,
 @FechaValeSalida,
 @IdObra,
 @Observaciones,
 @IdCentroCosto,
 @Aprobo,
 @NumeroValePreimpreso,
 @Cumplido,
 @EnviarEmail,
 @IdValeSalidaOriginal,
 @IdOrigenTransmision,
 @FechaImportacionTransmision,
 @IdUsuarioAnulo,
 @FechaAnulacion,
 @MotivoAnulacion,
 @CircuitoFirmasCompleto,
 @IdUsuarioDioPorCumplido,
 @FechaDioPorCumplido,
 @MotivoDioPorCumplido
)
SELECT @IdValeSalida=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdValeSalida)
