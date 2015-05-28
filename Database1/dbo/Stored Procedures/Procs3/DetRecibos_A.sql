


CREATE Procedure [dbo].[DetRecibos_A]
@IdDetalleRecibo int  output,
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
Insert into [DetalleRecibos]
(
 IdRecibo,
 IdImputacion,
 Importe,
 SaldoParteEnDolaresAnterior,
 PagadoParteEnDolares,
 NuevoSaldoParteEnDolares,
 SaldoParteEnPesosAnterior,
 PagadoParteEnPesos,
 NuevoSaldoParteEnPesos,
 EnviarEmail,
 IdOrigenTransmision,
 IdReciboOriginal,
 IdDetalleReciboOriginal,
 FechaImportacionTransmision
)
Values
(
 @IdRecibo,
 @IdImputacion,
 @Importe,
 @SaldoParteEnDolaresAnterior,
 @PagadoParteEnDolares,
 @NuevoSaldoParteEnDolares,
 @SaldoParteEnPesosAnterior,
 @PagadoParteEnPesos,
 @NuevoSaldoParteEnPesos,
 @EnviarEmail,
 @IdOrigenTransmision,
 @IdReciboOriginal,
 @IdDetalleReciboOriginal,
 @FechaImportacionTransmision
)
Select @IdDetalleRecibo=@@identity
Return(@IdDetalleRecibo)


