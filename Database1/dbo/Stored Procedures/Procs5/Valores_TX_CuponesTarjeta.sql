CREATE Procedure [dbo].[Valores_TX_CuponesTarjeta]

@IdTarjetaCredito Int = Null,
@Ambito varchar(1) = Null,
@IdValor int = Null,
@Asignados varchar(1) = Null

AS 

SET @IdTarjetaCredito=IsNull(@IdTarjetaCredito,-1)
SET @Ambito=IsNull(@Ambito,'*')
SET @IdValor=IsNull(@IdValor,-1)
SET @Asignados=IsNull(@Asignados,'*')

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111133'
SET @vector_T='0199624421F20200'

SELECT
 Valores.IdValor as [IdValor],
 TarjetasCredito.Nombre as [Tarjeta],
 Valores.IdValor as [IdAux1],
 Valores.IdTarjetaCredito as [IdTarjetaCredito],
 Valores.NumeroTarjetaCredito as [Nro.Tarjeta],
 Valores.NumeroValor as [Nro.Cupon],
 Valores.CantidadCuotas as [Cant.Cuotas],
 IsNull(Valores.FechaValor,Valores.FechaComprobante) as [Fecha],
 Valores.Importe as [Importe],
 IsNull(IsNull(Clientes.RazonSocial,Proveedores.RazonSocial),Facturas.Cliente) as [Entidad],
 Case When Recibos.IdRecibo is not null Then IsNull(tc.DescripcionAb+' ','')+Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	When OrdenesPago.IdOrdenPago is not null Then IsNull(tc.DescripcionAb+' ','')+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)
	When Facturas.IdFactura is not null Then IsNull(tc.DescripcionAb+' ','')+Facturas.TipoABC+'-'+
				Substring('0000',1,4-Len(Convert(varchar,IsNull(Facturas.PuntoVenta,0))))+Convert(varchar,IsNull(Facturas.PuntoVenta,0))+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
 End as [Comprobante origen],
 Substring('00000000',1,8-Len(Convert(varchar,PresentacionesTarjetas.NumeroPresentacion)))+Convert(varchar,PresentacionesTarjetas.NumeroPresentacion) as [Nro.Presentacion],
 Substring('00000000',1,8-Len(Convert(varchar,R2.NumeroRecibo)))+Convert(varchar,R2.NumeroRecibo) as [Pago asignado],
 Depositos.Descripcion as [Origen],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores
LEFT OUTER JOIN TarjetasCredito ON TarjetasCredito.IdTarjetaCredito=Valores.IdTarjetaCredito
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Valores.IdCliente
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Valores.IdProveedor
LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=Valores.IdTipoComprobante
LEFT OUTER JOIN DetalleRecibosValores drv ON Valores.IdDetalleReciboValores = drv.IdDetalleReciboValores
LEFT OUTER JOIN DetalleRecibosCuentas drc ON Valores.IdDetalleReciboCuentas = drc.IdDetalleReciboCuentas
LEFT OUTER JOIN Recibos ON IsNull(drv.IdRecibo,drc.IdRecibo) = Recibos.IdRecibo
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores = dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Valores.IdFactura and Valores.IdTipoComprobante=1
LEFT OUTER JOIN DetallePresentacionesTarjetas dpt ON dpt.IdDetallePresentacionTarjeta=Valores.IdDetallePresentacionTarjeta
LEFT OUTER JOIN PresentacionesTarjetas ON PresentacionesTarjetas.IdPresentacionTarjeta=dpt.IdPresentacionTarjeta
LEFT OUTER JOIN Recibos R2 ON Valores.IdReciboAsignado = R2.IdRecibo
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito=Valores.IdOrigen
WHERE Valores.IdTarjetaCredito is not null and Valores.IdTipoComprobante<>17 and 
	(@IdTarjetaCredito<0 or IsNull(Valores.IdTarjetaCredito,0) = @IdTarjetaCredito) and 
	(@IdValor<0 or Valores.IdValor = @IdValor) and 
	(@Ambito='*' or (@Ambito='N' and Valores.IdDetallePresentacionTarjeta is null) or (@Ambito='S' and Valores.IdDetallePresentacionTarjeta is not null)) and 
	(@Asignados='*' or (@Asignados='N' and Valores.IdReciboAsignado is null) or (@Asignados='S' and Valores.IdReciboAsignado is not null))  
ORDER BY TarjetasCredito.Nombre, Valores.FechaValor, Valores.NumeroTarjetaCredito