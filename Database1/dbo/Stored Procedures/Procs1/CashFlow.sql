CREATE Procedure [dbo].[CashFlow]

@FechaDesde datetime,
@Dts varchar(100) 

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

TRUNCATE TABLE _TempCuboCashFlow

/*	DEUDORES	*/

INSERT INTO _TempCuboCashFlow
 SELECT 
  '1. INGRESOS DEUDORES',
  Null,
  Null,
  CtaCte.IdCliente,
  Clientes.RazonSocial,
  Case When TiposComprobante.Coeficiente=-1 
	Then Dateadd(d,-1,@FechaDesde)
	Else IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha)
  End,
  IsNull(CtaCte.Saldo,0)*TiposComprobante.Coeficiente,
  'Cliente : '+Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS+' - '+Convert(varchar,CtaCte.Fecha,103)+' '+
   Case When CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Facturas.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))	
	When CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Devoluciones.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))	
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasDebito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))	
	When CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasCredito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))	
	When CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
	 Then TiposComprobante.DescripcionAb+' '+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-','')+
		IsNull(Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo),
			Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante))	 Else TiposComprobante.DescripcionAb+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
   End
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 WHERE IsNull(CtaCte.Saldo,0)<>0

/*	ACREEDORES	*/

INSERT INTO _TempCuboCashFlow
 SELECT 
  '3. EGRESOS ACREEDORES',
  CtaCte.IdProveedor,
  Proveedores.RazonSocial,
  Null,
  Null,
  Case When TiposComprobante.Coeficiente=-1 
	Then Dateadd(d,-1,@FechaDesde)
	Else IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha)
  End,
  IsNull(CtaCte.Saldo,0)*TiposComprobante.Coeficiente*-1,
  'Proveedor : '+Proveedores.RazonSocial+' - '+
  Case When cp.FechaRecepcion is not null
	Then 'Ref. : '+Convert(varchar,cp.NumeroReferencia)+' '+Convert(varchar,cp.FechaRecepcion,103)+' '+TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
	Else Convert(varchar,CtaCte.Fecha,103)+' '+TiposComprobante.Descripcion+' '+
		Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
  End
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON CtaCte.IdComprobante=cp.IdComprobanteProveedor and CtaCte.IdTipoComp=cp.IdTipoComprobante
 WHERE IsNull(CtaCte.Saldo,0)<>0

/*	VALORES INGRESOS	*/

INSERT INTO _TempCuboCashFlow
 SELECT 
  '2. INGRESOS VALORES',
  Null,
  Null,
  Valores.IdCliente,
  IsNull(Clientes.RazonSocial,'RE Otros conceptos'),
  Case When (Valores.FechaValor Is Null or Valores.FechaValor<=@FechaDesde) And Valores.Importe>=0
	Then Convert(datetime,@FechaDesde,103)
	Else Valores.FechaValor
  End,
  Valores.Importe,
  Convert(varchar,Recibos.FechaRecibo,103)+' '+'Cliente : '+IsNull(Clientes.RazonSocial,'RE Otros conceptos')+' - RE '+
	IsNull(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-','')+
	IsNull(Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo),
		Substring('00000000',1,8-Len(Convert(varchar,Valores.NumeroComprobante)))+Convert(varchar,Valores.NumeroComprobante)) 
 FROM Valores
 LEFT OUTER JOIN DetalleRecibosValores DetRec ON DetRec.IdDetalleReciboValores=Valores.IdDetalleReciboValores
 LEFT OUTER JOIN Recibos ON DetRec.IdRecibo=Recibos.IdRecibo
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Recibos.IdCliente
 WHERE Valores.Estado is null and Valores.IdTipoValor=6 and Valores.IdTipoComprobante=2 and IsNull(Valores.Anulado,'NO')<>'SI'

/*	VALORES EGRESOS		*/

INSERT INTO _TempCuboCashFlow
 SELECT 
  '4. EGRESOS VALORES',
  Valores.IdProveedor,
  IsNull(Proveedores.RazonSocial,'OP Otros conceptos'),
  Null,
  Null,
  Case When (Valores.FechaValor Is Null or Valores.FechaValor<=@FechaDesde) And Valores.Importe>=0
	Then Convert(datetime,@FechaDesde,103)
	Else Valores.FechaValor
  End,
  Valores.Importe*-1,
  Convert(varchar,OrdenesPago.FechaOrdenPago,103)+' '+'Proveedor : '+IsNull(Proveedores.RazonSocial,'OP Otros conceptos')+' - OP '+
	IsNull(Substring('0000000000',1,10-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago),
	Substring('00000000',1,8-Len(Convert(varchar,Valores.NumeroOrdenPago)))+Convert(varchar,Valores.NumeroOrdenPago)) 
 FROM Valores
 LEFT OUTER JOIN DetalleOrdenesPagoValores DetOpe ON DetOpe.IdDetalleOrdenPagoValores=Valores.IdDetalleReciboValores
 LEFT OUTER JOIN OrdenesPago ON DetOpe.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=OrdenesPago.IdProveedor
 WHERE Valores.Estado is null and Valores.IdTipoValor=6 and IsNull(Valores.Anulado,'NO')<>'SI' and Valores.IdTipoComprobante=17 and Valores.FechaValor>@FechaDesde

SET NOCOUNT OFF

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts