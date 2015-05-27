CREATE Procedure [dbo].[CtasCtesD_TXParaImputar_Dolares]

@IdCliente int

As 

Declare @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteDevoluciones int,
	@IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int

Set @IdTipoComprobanteFacturaVenta=(Select Top 1 Parametros.IdTipoComprobanteFacturaVenta
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteDevoluciones=(Select Top 1 Parametros.IdTipoComprobanteDevoluciones
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteNotaDebito=(Select Top 1 Parametros.IdTipoComprobanteNotaDebito
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteNotaCredito=(Select Top 1 Parametros.IdTipoComprobanteNotaCredito
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteRecibo=(Select Top 1 Parametros.IdTipoComprobanteRecibo
					From Parametros Where Parametros.IdParametro=1)

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='000111111115133'
set @vector_T='000114355505900'

Select 
 CtaCte.IdCtaCte,
 CtaCte.IdImputacion,
 CtaCte.IdComprobante,
 TiposComprobante.DescripcionAB as [Comp.],
 CtaCte.NumeroComprobante as [Numero],
 CtaCte.Fecha,
 CASE 
	WHEN CtaCte.IdTipoComp=1 THEN Facturas.NumeroPedido
	ELSE Null
 END as [Pedido],
 CASE 
	WHEN TiposComprobante.Coeficiente=1 THEN CtaCte.ImporteTotalDolar
	ELSE CtaCte.ImporteTotalDolar*-1
 END as [Imp.orig.],
 CASE 
	WHEN TiposComprobante.Coeficiente=1 THEN CtaCte.SaldoDolar
	ELSE CtaCte.SaldoDolar*-1
 END as [Saldo Comp.],
 CtaCte.SaldoTrs,
 CtaCte.Marca as [*],
 Case 	When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta 
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
 End as [Observaciones],
 (Select Top 1 ccd.Fecha From CuentasCorrientesDeudores ccd Where ccd.IdCtaCte=CtaCte.IdImputacion) as [FechaImputacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesDeudores CtaCte
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
WHERE (CtaCte.IdCliente=@IdCliente)
ORDER BY CtaCte.IdImputacion,CtaCte.Fecha