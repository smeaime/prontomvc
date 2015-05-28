CREATE Procedure [dbo].[DetRecibosRubrosContables_A]

@IdDetalleReciboRubrosContables int  output,
@IdRecibo int,
@IdRubroContable int,
@Importe numeric(18,2),
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@IdReciboOriginal int,
@IdDetalleReciboRubrosContablesOriginal int,
@FechaImportacionTransmision datetime

AS

INSERT INTO [DetalleRecibosRubrosContables]
(
 IdRecibo,
 IdRubroContable,
 Importe,
 EnviarEmail,
 IdOrigenTransmision,
 IdReciboOriginal,
 IdDetalleReciboRubrosContablesOriginal,
 FechaImportacionTransmision
)
VALUES
(
 @IdRecibo,
 @IdRubroContable,
 @Importe,
 @EnviarEmail,
 @IdOrigenTransmision,
 @IdReciboOriginal,
 @IdDetalleReciboRubrosContablesOriginal,
 @FechaImportacionTransmision
)

SELECT @IdDetalleReciboRubrosContables=@@identity

RETURN(@IdDetalleReciboRubrosContables)