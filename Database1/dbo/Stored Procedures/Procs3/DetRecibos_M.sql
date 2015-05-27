


CREATE Procedure [dbo].[DetRecibos_M]
@IdDetalleRecibo int,
@IdRecibo int,
@IdImputacion int,
@Importe numeric(18,2),
@SaldoParteEnDolaresAnterior numeric(18,2),
@PagadoParteEnDolares numeric(18,2),
@NuevoSaldoParteEnDolares numeric(18,2),
@SaldoParteEnPesosAnterior numeric(18,2),
@PagadoParteEnPesos numeric(18,2),
@NuevoSaldoParteEnPesos numeric(18,2),
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@IdReciboOriginal int,
@IdDetalleReciboOriginal int,
@FechaImportacionTransmision datetime
AS
UPDATE DetalleRecibos
SET 
 IdRecibo=@IdRecibo,
 IdImputacion=@IdImputacion,
 Importe=@Importe,
 SaldoParteEnDolaresAnterior=@SaldoParteEnDolaresAnterior,
 PagadoParteEnDolares=@PagadoParteEnDolares,
 NuevoSaldoParteEnDolares=@NuevoSaldoParteEnDolares,
 SaldoParteEnPesosAnterior=@SaldoParteEnPesosAnterior,
 PagadoParteEnPesos=@PagadoParteEnPesos,
 NuevoSaldoParteEnPesos=@NuevoSaldoParteEnPesos,
 EnviarEmail=@EnviarEmail,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdReciboOriginal=@IdReciboOriginal,
 IdDetalleReciboOriginal=@IdDetalleReciboOriginal,
 FechaImportacionTransmision=@FechaImportacionTransmision
WHERE (IdDetalleRecibo=@IdDetalleRecibo)
RETURN(@IdDetalleRecibo)


