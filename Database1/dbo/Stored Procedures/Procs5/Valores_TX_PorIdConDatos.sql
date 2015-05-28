CREATE Procedure [dbo].[Valores_TX_PorIdConDatos]

@IdValor int,
@IdReciboAModificar int = Null

AS 

SET @IdReciboAModificar=IsNull(@IdReciboAModificar,-1)

SELECT 
 Valores.*,
 TarjetasCredito.Nombre as [Tarjeta],
 IsNull(IsNull(Clientes.RazonSocial,Proveedores.RazonSocial),Facturas.Cliente) as [Entidad],
 Case When Recibos.IdRecibo is not null Then IsNull(tc1.DescripcionAb+' ','')+Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	When OrdenesPago.IdOrdenPago is not null Then IsNull(tc1.DescripcionAb+' ','')+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)
	When Facturas.IdFactura is not null Then IsNull(tc1.DescripcionAb+' ','')+Facturas.TipoABC+'-'+
				Substring('0000',1,4-Len(Convert(varchar,IsNull(Facturas.PuntoVenta,0))))+Convert(varchar,IsNull(Facturas.PuntoVenta,0))+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
 End as [ComprobanteOrigen],
 R1.NumeroRecibo as [ReciboAsignado],
 (Select PresentacionesTarjetas.NumeroPresentacion From DetallePresentacionesTarjetas dpt 
  Left Outer Join PresentacionesTarjetas On PresentacionesTarjetas.IdPresentacionTarjeta=dpt.IdPresentacionTarjeta
  Where dpt.IdValor=Valores.IdValor) as [NumeroPresentacion],
 tc1.DescripcionAb as [TipoComprobante],
 tc2.DescripcionAb as [Tipo],
 Bancos.Nombre as [Banco]
FROM Valores
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN TiposComprobante tc1 ON tc1.IdTipoComprobante=Valores.IdTipoComprobante
LEFT OUTER JOIN TiposComprobante tc2 ON tc2.IdTipoComprobante=Valores.IdTipoValor
LEFT OUTER JOIN DetalleRecibosValores drv ON Valores.IdDetalleReciboValores = drv.IdDetalleReciboValores
LEFT OUTER JOIN DetalleRecibosCuentas drc ON Valores.IdDetalleReciboCuentas = drc.IdDetalleReciboCuentas
LEFT OUTER JOIN Recibos ON IsNull(drv.IdRecibo,drc.IdRecibo) = Recibos.IdRecibo
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores = dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Valores.IdFactura and Valores.IdTipoComprobante=1
LEFT OUTER JOIN TarjetasCredito ON TarjetasCredito.IdTarjetaCredito=Valores.IdTarjetaCredito
LEFT OUTER JOIN Recibos R1 ON Valores.IdReciboAsignado = R1.IdRecibo
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
WHERE Valores.IdValor=@IdValor or (@IdReciboAModificar>0 and IsNull(Valores.IdReciboAsignado,0)=@IdReciboAModificar)