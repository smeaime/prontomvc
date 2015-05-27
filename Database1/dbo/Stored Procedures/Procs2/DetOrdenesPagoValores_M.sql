CREATE Procedure [dbo].[DetOrdenesPagoValores_M]

@IdDetalleOrdenPagoValores int,
@IdOrdenPago int,
@IdTipoValor int,
@NumeroValor numeric(12,0),
@NumeroInterno int,
@FechaVencimiento Datetime,
@IdBanco int,
@Importe numeric(18,2),
@IdValor int,
@IdCuentaBancaria int,
@IdBancoChequera int,
@IdCaja int,
@ChequesALaOrdenDe varchar(100),
@NoALaOrden varchar(2),
@Anulado varchar(2),
@IdUsuarioAnulo int,
@FechaAnulacion datetime,
@MotivoAnulacion varchar(30),
@IdTarjetaCredito int

AS

UPDATE DetalleOrdenesPagoValores
SET 
 IdOrdenPago=@IdOrdenPago,
 IdTipoValor=@IdTipoValor,
 NumeroValor=@NumeroValor,
 NumeroInterno=@NumeroInterno,
 FechaVencimiento=@FechaVencimiento,
 IdBanco=@IdBanco,
 Importe=@Importe,
 IdValor=@IdValor,
 IdCuentaBancaria=@IdCuentaBancaria,
 IdBancoChequera=@IdBancoChequera,
 IdCaja=@IdCaja,
 ChequesALaOrdenDe=@ChequesALaOrdenDe,
 NoALaOrden=@NoALaOrden,
 Anulado=@Anulado,
 IdUsuarioAnulo=@IdUsuarioAnulo,
 FechaAnulacion=@FechaAnulacion,
 MotivoAnulacion=@MotivoAnulacion,
 IdTarjetaCredito=@IdTarjetaCredito
WHERE (IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores)

RETURN(@IdDetalleOrdenPagoValores)