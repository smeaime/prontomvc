
CREATE Procedure [dbo].[CtasCtesD_TX_Imputacion]

@IdCtaCte int

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
	@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

SET NOCOUNT OFF

SELECT Cta.*, Vendedores.Nombre as [Vendedor], TiposComprobante.Coeficiente as [Coeficiente], TiposComprobante.DescripcionAb as [DescripcionAb], 
	Case When Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta and Facturas.NumeroFactura is not null
		 Then Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
		When Cta.IdTipoComp=@IdTipoComprobanteDevoluciones and Devoluciones.NumeroDevolucion is not null
		 Then Devoluciones.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)
		When Cta.IdTipoComp=@IdTipoComprobanteNotaDebito and NotasDebito.NumeroNotaDebito is not null
		 Then NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)
		When Cta.IdTipoComp=@IdTipoComprobanteNotaCredito and NotasCredito.NumeroNotaCredito is not null
		 Then NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)
		When Cta.IdTipoComp=@IdTipoComprobanteRecibo and Recibos.NumeroRecibo is not null
		 Then Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
			Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
		Else Substring('0000000000',1,10-Len(Convert(varchar,Cta.NumeroComprobante)))+Convert(varchar,Cta.NumeroComprobante)
	End as [Comprobante]
FROM CuentasCorrientesDeudores Cta 
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteRecibo
LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=IsNull(Facturas.IdVendedor,IsNull(Devoluciones.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,Recibos.IdVendedor))))
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Cta.IdTipoComp
WHERE (IdCtaCte=@IdCtaCte)
