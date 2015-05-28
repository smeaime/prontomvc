
CREATE PROCEDURE [dbo].[DetRecibos_TXPrimero]

AS

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
	@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdMonedaPesos int, @IdMonedaDolar int

SET @IdMonedaPesos=(Select IdMoneda From Parametros Where IdParametro=1)
SET @IdMonedaDolar=(Select IdMonedaDolar From Parametros Where IdParametro=1)
SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00011111133'
SET @vector_T='0000E421100'

SELECT TOP 1 
 DetRec.IdDetalleRecibo,
 DetRec.IdRecibo,
 DetRec.IdImputacion,
 Case When DetRec.IdImputacion=-1 Then 'PA' Else TiposComprobante.DescripcionAB End as [Comp.],
 Case When Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta 
	 Then Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
	When Cta.IdTipoComp=@IdTipoComprobanteDevoluciones 
	 Then Devoluciones.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)
	When Cta.IdTipoComp=@IdTipoComprobanteNotaDebito 
	 Then NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)
	When Cta.IdTipoComp=@IdTipoComprobanteNotaCredito 
	 Then NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)
	When Cta.IdTipoComp=@IdTipoComprobanteRecibo 
	 Then Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	Else Substring('00000000',1,8-Len(Convert(varchar,Cta.NumeroComprobante)))+Convert(varchar,Cta.NumeroComprobante)
 End as [Numero],
-- Cta.NumeroComprobante as [Numero],
 Cta.Fecha,
 Case When Recibos.IdMoneda=@IdMonedaDolar Then Cta.ImporteTotalDolar*TiposComprobante.Coeficiente Else Cta.ImporteTotal*TiposComprobante.Coeficiente End as [ImporteTotal],
 Case When Recibos.IdMoneda=@IdMonedaDolar Then Cta.SaldoDolar*TiposComprobante.Coeficiente Else Cta.Saldo*TiposComprobante.Coeficiente End as [Saldo],
 DetRec.Importe,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRecibos DetRec
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetRec.IdRecibo
LEFT OUTER JOIN CuentasCorrientesDeudores Cta ON Cta.IdCtaCte=DetRec.IdImputacion
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Cta.IdTipoComp
