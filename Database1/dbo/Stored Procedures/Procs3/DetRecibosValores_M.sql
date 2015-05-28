CREATE Procedure [dbo].[DetRecibosValores_M]

@IdDetalleReciboValores int,
@IdRecibo int,
@IdTipoValor int,
@NumeroValor numeric(12,0),
@NumeroInterno int,
@FechaVencimiento Datetime,
@IdBanco int,
@Importe money,
@IdCuentaBancariaTransferencia int,
@IdBancoTransferencia int,
@NumeroTransferencia int,
@IdTipoCuentaGrupo int,
@IdCuenta int,
@IdCaja int,
@CuitLibrador varchar(13),
@IdTarjetaCredito int,
@NumeroTarjetaCredito varchar(20),
@NumeroAutorizacionTarjetaCredito int,
@CantidadCuotas int,
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@IdReciboOriginal int,
@IdDetalleReciboValoresOriginal int,
@FechaImportacionTransmision datetime,
@FechaExpiracionTarjetaCredito varchar(5)

AS

UPDATE DetalleRecibosValores
SET 
 IdRecibo=@IdRecibo,
 IdTipoValor=@IdTipoValor,
 NumeroValor=@NumeroValor,
 NumeroInterno=@NumeroInterno,
 FechaVencimiento=@FechaVencimiento,
 IdBanco=@IdBanco,
 Importe=@Importe,
 IdCuentaBancariaTransferencia=@IdCuentaBancariaTransferencia,
 IdBancoTransferencia=@IdBancoTransferencia,
 NumeroTransferencia=@NumeroTransferencia,
 IdTipoCuentaGrupo=@IdTipoCuentaGrupo,
 IdCuenta=@IdCuenta,
 IdCaja=@IdCaja,
 CuitLibrador=@CuitLibrador,
 IdTarjetaCredito=@IdTarjetaCredito,
 NumeroTarjetaCredito=@NumeroTarjetaCredito,
 NumeroAutorizacionTarjetaCredito=@NumeroAutorizacionTarjetaCredito,
 CantidadCuotas=@CantidadCuotas,
 EnviarEmail=@EnviarEmail,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdReciboOriginal=@IdReciboOriginal,
 IdDetalleReciboValoresOriginal=@IdDetalleReciboValoresOriginal,
 FechaImportacionTransmision=@FechaImportacionTransmision,
 FechaExpiracionTarjetaCredito=@FechaExpiracionTarjetaCredito
WHERE (IdDetalleReciboValores=@IdDetalleReciboValores)

RETURN(@IdDetalleReciboValores)