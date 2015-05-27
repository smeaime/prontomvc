CREATE Procedure [dbo].[Valores_TXFecha1]

@Desde datetime,
@Hasta datetime,
@Tipo varchar(2) = Null,
@IdBanco int = Null

AS

SET @Tipo=IsNull(@Tipo,'TT')
SET @IdBanco=IsNull(@IdBanco,-1)

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111111111111111133'
SET @vector_T='0093454303115422442555555424500'

SELECT 
 Valores.IdValor,
 Case When  Valores.IdTipoValor is null and  Valores.Estado='G' Then 'GS' Else tp1.DescripcionAb End as [Tipo],
 Valores.IdValor as [IdAux],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.NumeroValor as [Numero],
 Valores.CuitLibrador as [Cuit librador],
 Valores.FechaValor as [Fecha Vto.],
 Valores.Importe as [Importe],
 Monedas.Abreviatura as [Mon.],
 b1.Nombre as [Banco origen],
 Valores.Estado as [Estado],
 tp2.DescripcionAb as [Comp.],
 Valores.NumeroComprobante as [Nro.Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 IsNull(Clientes.RazonSocial,c1.Descripcion) as [Cliente / Cuenta],
 b2.Nombre as [Banco deposito],
 Valores.NumeroDeposito as [Nro.Deposito],
 Valores.FechaDeposito as [Fecha Deposito],
 Proveedores.RazonSocial as [Proveedor pagado],
 Valores.NumeroOrdenPago as [Nro.pago],
 Valores.FechaOrdenPago as [Fec.pago],
 c2.Descripcion as [Cuenta salida],
 Valores.NumeroSalida as [Nro.salida],
 Valores.FechaSalida as [Fec.salida],
 Valores.Anulado as [Anulado],
 Valores.Rechazado as [Rechazado],
 E1.Nombre as [Anulo / Rechazo],
 Valores.FechaAnulacion as [Fecha anulacion / rechazo],
 Valores.MotivoAnulacion as [Motivo anulacion / rechazo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN Empleados E1 ON Valores.IdUsuarioAnulo=E1.IdEmpleado
LEFT OUTER JOIN TiposComprobante tp1 ON Valores.IdTipoValor=tp1.IdTipoComprobante
LEFT OUTER JOIN TiposComprobante tp2 ON Valores.IdTipoComprobante=tp2.IdTipoComprobante
LEFT OUTER JOIN Bancos b1 ON Valores.IdBanco=b1.IdBanco
LEFT OUTER JOIN Bancos b2 ON Valores.IdBancoDeposito=b2.IdBanco
LEFT OUTER JOIN DetalleAsientos ON Valores.IdDetalleAsiento=DetalleAsientos.IdDetalleAsiento
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores = dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN DetalleRecibosValores drv ON Valores.IdDetalleReciboValores = drv.IdDetalleReciboValores
LEFT OUTER JOIN DetalleRecibosCuentas drc ON Valores.IdDetalleReciboCuentas = drc.IdDetalleReciboCuentas
LEFT OUTER JOIN Recibos ON IsNull(drv.IdRecibo,drc.IdRecibo) = Recibos.IdRecibo
LEFT OUTER JOIN Cuentas c1 ON IsNull(OrdenesPago.IdCuenta,Recibos.IdCuenta) = c1.IdCuenta
LEFT OUTER JOIN Cuentas c2 ON Valores.IdCuenta=c2.IdCuenta
WHERE Valores.FechaComprobante between @Desde and DATEADD(n,1439,@Hasta) and 
	Valores.IdTipoValor=6 and 
	(@Tipo='TT' or 
	 (@Tipo='IN' and Valores.IdTipoComprobante<>17 and 
	  (@IdBanco=-1 or IsNull(Valores.IdBancoDeposito,0)=@IdBanco)) or 
	 (@Tipo='EG' and Valores.IdTipoComprobante=17 and 
	  (@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco)))
ORDER BY Valores.FechaValor,Valores.NumeroInterno