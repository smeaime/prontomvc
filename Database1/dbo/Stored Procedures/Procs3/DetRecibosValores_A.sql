CREATE Procedure [dbo].[DetRecibosValores_A]

@IdDetalleReciboValores int  output,
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

INSERT INTO [DetalleRecibosValores]
(
 IdRecibo,
 IdTipoValor,
 NumeroValor,
 NumeroInterno,
 FechaVencimiento,
 IdBanco,
 Importe,
 IdCuentaBancariaTransferencia,
 IdBancoTransferencia,
 NumeroTransferencia,
 IdTipoCuentaGrupo,
 IdCuenta,
 IdCaja,
 CuitLibrador,
 IdTarjetaCredito,
 NumeroTarjetaCredito,
 NumeroAutorizacionTarjetaCredito,
 CantidadCuotas,
 EnviarEmail,
 IdOrigenTransmision,
 IdReciboOriginal,
 IdDetalleReciboValoresOriginal,
 FechaImportacionTransmision,
 FechaExpiracionTarjetaCredito
)
VALUES 
(
 @IdRecibo,
 @IdTipoValor,
 @NumeroValor,
 @NumeroInterno,
 @FechaVencimiento,
 @IdBanco,
 @Importe,
 @IdCuentaBancariaTransferencia,
 @IdBancoTransferencia,
 @NumeroTransferencia,
 @IdTipoCuentaGrupo,
 @IdCuenta,
 @IdCaja,
 @CuitLibrador,
 @IdTarjetaCredito,
 @NumeroTarjetaCredito,
 @NumeroAutorizacionTarjetaCredito,
 @CantidadCuotas,
 @EnviarEmail,
 @IdOrigenTransmision,
 @IdReciboOriginal,
 @IdDetalleReciboValoresOriginal,
 @FechaImportacionTransmision,
 @FechaExpiracionTarjetaCredito
)

SELECT @IdDetalleReciboValores=@@identity

RETURN(@IdDetalleReciboValores)