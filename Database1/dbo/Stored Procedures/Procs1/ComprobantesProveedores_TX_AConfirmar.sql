CREATE  Procedure [dbo].[ComprobantesProveedores_TX_AConfirmar]

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111111111111111133'
SET @vector_T='00936312244411111111023126263200'

SELECT 
 cp.IdComprobanteProveedor, 
 TiposComprobante.Descripcion as [Tipo comprob. a conf.],
 cp.IdComprobanteProveedor as [IdAux ], 
 cp.NumeroReferencia as [Nro.interno],
 Substring(cp.Letra+'-'+Substring('00000',1,5-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],
 Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
	When cp.IdCuenta is not null Then 'F.fijo' 
	When cp.IdCuentaOtros is not null Then 'Otros' 
	Else Null
 End as [Tipo],
 OrdenesPago.NumeroOrdenPago as [Vale],
 Case When cp.IdProveedor is not null 
	Then  	Case When IsNull((Select Proveedores.Confirmado From Proveedores Where cp.IdProveedor = Proveedores.IdProveedor),'SI')='NO'
			Then (Select Proveedores.RazonSocial From Proveedores Where cp.IdProveedor = Proveedores.IdProveedor)+'  (*)'
			Else (Select Proveedores.RazonSocial From Proveedores Where cp.IdProveedor = Proveedores.IdProveedor)
		End
	Else  (Select Cuentas.Descripcion From Cuentas Where IsNull(cp.IdCuenta,cp.IdCuentaOtros) = Cuentas.IdCuenta)
 End as [Proveedor / Cuenta], 
 (Select Proveedores.RazonSocial From Proveedores Where cp.IdProveedorEventual = Proveedores.IdProveedor) as [Proveedor FF],
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha recep.],
 cp.FechaVencimiento as [Fecha vto.],
 Convert(varchar,Obras.NumeroObra)+' '+Obras.Descripcion as [Obra],
 cp.TotalBruto as [Subtotal],
 Case When IsNull(cp.TotalIva1,0)<>0 
	Then IsNull((Select Sum(IsNull(dc.Importe,0)) From DetalleComprobantesProveedores dc 
			Where dc.IdComprobanteProveedor=cp.IdComprobanteProveedor and (IsNull(dc.ImporteIva1,0)<>0 or IsNull(dc.ImporteIva2,0)<>0 or IsNull(dc.ImporteIva3,0)<>0 or IsNull(dc.ImporteIva4,0)<>0 or 
				IsNull(dc.ImporteIva5,0)<>0 or IsNull(dc.ImporteIva6,0)<>0 or IsNull(dc.ImporteIva7,0)<>0 or IsNull(dc.ImporteIva8,0)<>0 or IsNull(dc.ImporteIva9,0)<>0 or IsNull(dc.ImporteIva10,0)<>0)),0)
	Else 0
 End as [Neto gravado],
 cp.TotalIva1 as [IVA 1],
 cp.TotalIva2 as [IVA 2],
 cp.AjusteIVA as [Aj.IVA],
 cp.TotalBonificacion as [Imp.bonif.],
 cp.TotalComprobante as [Total],
 Monedas.Nombre as [Moneda],
 cp.CotizacionDolar as [Cotiz. dolar],
 Provincias.Nombre as [Provincia destino],
 cp.Observaciones,
 (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=cp.IdUsuarioIngreso) as [Ingreso],
 cp.FechaIngreso as [Fecha ingreso],
 (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=cp.IdUsuarioModifico) as [Modifico],
 cp.FechaModifico as [Fecha modif.],
(Select Count(*) From DetalleComprobantesProveedores Where DetalleComprobantesProveedores.IdComprobanteProveedor=cp.IdComprobanteProveedor) as [Cant.Items],
 cp.NumeroRendicionFF as [Nro.Rend.FF],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ComprobantesProveedores cp
LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Obras ON  cp.IdObra = Obras.IdObra
LEFT OUTER JOIN OrdenesPago ON  cp.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN Monedas ON  cp.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Provincias ON  cp.IdProvinciaDestino = Provincias.IdProvincia
WHERE cp.Confirmado is not null and cp.Confirmado='NO'
ORDER BY cp.FechaComprobante,cp.NumeroReferencia