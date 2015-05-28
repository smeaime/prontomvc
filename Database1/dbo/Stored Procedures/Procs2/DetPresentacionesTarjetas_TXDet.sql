CREATE PROCEDURE [dbo].[DetPresentacionesTarjetas_TXDet]

@IdPresentacionTarjeta int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001111111133'
SET @vector_T='00793442GF00'

SELECT
 Det.IdDetallePresentacionTarjeta,
 Det.IdPresentacionTarjeta,
 Valores.NumeroTarjetaCredito as [Nro.Tarjeta],
 Det.IdValor as [IdValor],
 Valores.NumeroValor as [Nro.Cupon],
 Valores.CantidadCuotas as [Cant.Cuotas],
 Valores.FechaValor as [Fecha],
 Valores.Importe as [Importe],
 IsNull(IsNull(Clientes.RazonSocial,Proveedores.RazonSocial),Facturas.Cliente) as [Entidad],
 Case When Recibos.IdRecibo is not null Then IsNull(tc.DescripcionAb+' ','')+Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	When OrdenesPago.IdOrdenPago is not null Then IsNull(tc.DescripcionAb+' ','')+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)
	When Facturas.IdFactura is not null Then IsNull(tc.DescripcionAb+' ','')+Facturas.TipoABC+'-'+
				Substring('0000',1,4-Len(Convert(varchar,IsNull(Facturas.PuntoVenta,0))))+Convert(varchar,IsNull(Facturas.PuntoVenta,0))+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
 End as [Comprobante origen],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePresentacionesTarjetas Det
LEFT OUTER JOIN PresentacionesTarjetas ON Det.IdPresentacionTarjeta=PresentacionesTarjetas.IdPresentacionTarjeta
LEFT OUTER JOIN Valores ON Det.IdValor=Valores.IdValor
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=Valores.IdTipoComprobante
LEFT OUTER JOIN DetalleRecibosValores drv ON Valores.IdDetalleReciboValores = drv.IdDetalleReciboValores
LEFT OUTER JOIN DetalleRecibosCuentas drc ON Valores.IdDetalleReciboCuentas = drc.IdDetalleReciboCuentas
LEFT OUTER JOIN Recibos ON IsNull(drv.IdRecibo,drc.IdRecibo) = Recibos.IdRecibo
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores = dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Valores.IdFactura and Valores.IdTipoComprobante=1
WHERE (Det.IdPresentacionTarjeta = @IdPresentacionTarjeta)
ORDER BY Valores.FechaValor, Valores.NumeroTarjetaCredito