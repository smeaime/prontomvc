CREATE Procedure [dbo].[CtasCtesD_TX_PorIdConDatos]

@IdCtaCte int = Null

AS 

SET NOCOUNT ON

SET @IdCtaCte=IsNull(@IdCtaCte,-1)

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdClienteAProcesar int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where Parametros.IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdClienteAProcesar=-1

SET NOCOUNT OFF

SELECT 
 CtaCte.IdCtaCte as [IdCtaCte],
 CtaCte.IdImputacion as [IdImputacion],
 CtaCte.IdTipoComp as [IdTipoComp],
 CtaCte.IdComprobante as [IdComprobante],
 CtaCte.IdCliente as [IdCliente],
 Clientes.RazonSocial as [Cliente],
 TiposComprobante.DescripcionAB as [Tipo],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
	 Then IsNull(Facturas.TipoABC+'-','')+
			IsNull(Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-','')+
			IsNull(Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
				Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
	 Then IsNull(Devoluciones.TipoABC+'-','')+
			IsNull(Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-','')+
			IsNull(Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion),
				Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
	 Then IsNull(NotasDebito.TipoABC+'-','')+
			IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-','')+
			IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
				Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
	 Then IsNull(NotasCredito.TipoABC+'-','')+
			IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-','')+
			IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito),
				Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
	 Then IsNull(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-','')+
			IsNull(Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo),
				Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))
	 Else Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
 End as [Numero],
 CtaCte.Fecha as [Fecha],
 CtaCte.FechaVencimiento as [FechaVencimiento],
 CtaCte.CotizacionMoneda as [CotizacionMoneda],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.ImporteTotal Else CtaCte.ImporteTotal*-1 End as [ImporteTotal],
 Case When TiposComprobante.Coeficiente=1 Then CtaCte.Saldo Else CtaCte.Saldo*-1 End as [Saldo],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta 
	 Then Substring(Convert(varchar(1000),Facturas.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones 
	 Then Substring(Convert(varchar(1000),Devoluciones.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito 
	 Then Substring(Convert(varchar(1000),NotasDebito.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito 
	 Then Substring(Convert(varchar(1000),NotasCredito.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo 
	 Then Substring(Convert(varchar(1000),Recibos.Observaciones COLLATE Modern_Spanish_CI_AS),1,1000)
	 Else Null
 End as [Observaciones]
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=IsNull(Facturas.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,0)))
WHERE (@IdCtaCte=-1 or CtaCte.IdCtaCte=@IdCtaCte)
