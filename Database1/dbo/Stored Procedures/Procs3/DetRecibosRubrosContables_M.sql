CREATE Procedure [dbo].[DetRecibosRubrosContables_M]

@IdDetalleReciboRubrosContables int,
@IdRecibo int,
@IdRubroContable int,
@Importe numeric(18,2),
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@IdReciboOriginal int,
@IdDetalleReciboRubrosContablesOriginal int,
@FechaImportacionTransmision datetime

AS

UPDATE DetalleRecibosRubrosContables
SET 
 IdRecibo=@IdRecibo,
 IdRubroContable=@IdRubroContable,
 Importe=@Importe,
 EnviarEmail=@EnviarEmail,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdReciboOriginal=@IdReciboOriginal,
 IdDetalleReciboRubrosContablesOriginal=@IdDetalleReciboRubrosContablesOriginal,
 FechaImportacionTransmision=@FechaImportacionTransmision
WHERE (IdDetalleReciboRubrosContables=@IdDetalleReciboRubrosContables)

RETURN(@IdDetalleReciboRubrosContables)