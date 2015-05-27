CREATE Procedure [dbo].[DetOrdenesPagoValores_A]

@IdDetalleOrdenPagoValores int  output,
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

BEGIN TRAN
   BEGIN
	DECLARE @NumeroValor1 numeric(12,0)
	SET @NumeroValor1=@NumeroValor
	IF IsNull(@IdBancoChequera,0)>0 and IsNull(@NumeroValor,0)>0
		WHILE Exists(Select Top 1 dopv.IdOrdenPago From DetalleOrdenesPagoValores dopv 
				Left Outer Join OrdenesPago On OrdenesPago.IdOrdenPago=dopv.IdOrdenPago
				Where IsNull(dopv.IdBancoChequera,0)=@IdBancoChequera and IsNull(dopv.NumeroValor,0)=@NumeroValor1 and IsNull(OrdenesPago.Anulada,'NO')<>'SI')
			SET @NumeroValor1=@NumeroValor1+1
	IF @NumeroValor<>@NumeroValor1
	   BEGIN
		SET @NumeroValor=@NumeroValor1
		UPDATE BancoChequeras SET ProximoNumeroCheque=@NumeroValor1+1 WHERE IdBancoChequera=@IdBancoChequera
	   END
   END

INSERT INTO [DetalleOrdenesPagoValores]
(
 IdOrdenPago,
 IdTipoValor,
 NumeroValor,
 NumeroInterno,
 FechaVencimiento,
 IdBanco,
 Importe,
 IdValor,
 IdCuentaBancaria,
 IdBancoChequera,
 IdCaja,
 ChequesALaOrdenDe,
 NoALaOrden,
 Anulado,
 IdUsuarioAnulo,
 FechaAnulacion,
 MotivoAnulacion,
 IdTarjetaCredito
)
VALUES
(
 @IdOrdenPago,
 @IdTipoValor,
 @NumeroValor,
 @NumeroInterno,
 @FechaVencimiento,
 @IdBanco,
 @Importe,
 @IdValor,
 @IdCuentaBancaria,
 @IdBancoChequera,
 @IdCaja,
 @ChequesALaOrdenDe,
 @NoALaOrden,
 @Anulado,
 @IdUsuarioAnulo,
 @FechaAnulacion,
 @MotivoAnulacion,
 @IdTarjetaCredito
)

SELECT @IdDetalleOrdenPagoValores=@@identity
IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleOrdenPagoValores)