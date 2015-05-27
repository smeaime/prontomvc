CREATE Procedure [dbo].[NotasCredito_TX_ImputacionesACartasDePorte]

@IdImputacion int

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdFactura int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdFactura=Isnull((Select Top 1 IdComprobante From CuentasCorrientesDeudores Where IdCtaCte=@IdImputacion and IdTipoComp=@IdTipoComprobanteFacturaVenta),-1)

SET NOCOUNT OFF

SELECT IdCartaDePorte FROM CartasDePorte WHERE IsNull(IdFacturaImputada,0)=@IdFactura
