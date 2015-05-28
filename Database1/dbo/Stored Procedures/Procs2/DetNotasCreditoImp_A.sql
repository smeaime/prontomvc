CREATE Procedure [dbo].[DetNotasCreditoImp_A]

@IdDetalleNotaCreditoImputaciones int  output,
@IdNotaCredito int,
@IdImputacion int,
@Importe money

AS 

DECLARE @LiberarCartasDePorte varchar(2), @IdTipoComprobanteFacturaVenta int, @IdFactura int

SET @LiberarCartasDePorte=IsNull((Select Top 1 LiberarCartasDePorte From NotasCredito Where IdNotaCredito=@IdNotaCredito),'')
IF @LiberarCartasDePorte='SI' and IsNull(@IdImputacion,0)>0
    BEGIN
	SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
	SET @IdFactura=Isnull((Select Top 1 IdComprobante From CuentasCorrientesDeudores Where IdCtaCte=@IdImputacion and IdTipoComp=@IdTipoComprobanteFacturaVenta),-1)
	UPDATE CartasDePorte SET IdFacturaImputada=Null WHERE IsNull(IdFacturaImputada,0)=@IdFactura
    END

INSERT INTO [DetalleNotasCreditoImputaciones]
(
 IdNotaCredito,
 IdImputacion,
 Importe
)
VALUES
(
 @IdNotaCredito,
 @IdImputacion,
 @Importe
)

SELECT @IdDetalleNotaCreditoImputaciones=@@identity

RETURN(@IdDetalleNotaCreditoImputaciones)