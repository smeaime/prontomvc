﻿CREATE PROCEDURE [dbo].[ComprobantesProveedores_TXFecha]

@Desde datetime,
@Hasta datetime,
@IdUsuario int

AS

SET NOCOUNT ON

DECLARE @vector_X varchar(50), @vector_T varchar(50), @IdUsuarioFF int

SET @IdUsuarioFF=IsNull((Select Top 1 E.IdEmpleado From Empleados E Where E.IdEmpleado=@IdUsuario and E.IdCuentaFondoFijo is not null),-1)

CREATE TABLE #Auxiliar1 (IdComprobanteProveedor INTEGER, IdCuenta INTEGER)
INSERT INTO #Auxiliar1 
 SELECT cp.IdComprobanteProveedor, (Select Top 1 dcp.IdCuenta From DetalleComprobantesProveedores dcp Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor)
 FROM ComprobantesProveedores cp
 WHERE (cp.FechaRecepcion Between @Desde And @Hasta) and (cp.Confirmado is null or cp.Confirmado<>'NO')

SET NOCOUNT OFF

SET @vector_X='01111111111111111111111111111111111133'
SET @vector_T='00936344412210121111111023126263222800'

SELECT 
 cp.IdComprobanteProveedor, 
 TiposComprobante.Descripcion as [Tipo comp.],
 cp.IdComprobanteProveedor as [IdAux ], 
 cp.NumeroReferencia as [Nro.interno],
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],
 Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
	When cp.IdCuenta is not null Then 'F.fijo' 
	When cp.IdCuentaOtros is not null Then 'Otros' 
	Else Null
 End as [Tipo],
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha recep.],
 cp.FechaVencimiento as [Fecha vto.],
 IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [Cod.Prov.], 
 IsNull(P1.RazonSocial,C1.Descripcion) as [Proveedor / Cuenta], 
 P2.RazonSocial as [Proveedor FF],
 OrdenesPago.NumeroOrdenPago as [Vale],
 IsNull(diva1.Descripcion,IsNull(diva2.Descripcion,diva3.Descripcion)) as [Condicion IVA], 
 Case When Obras.NumeroObra is not null Then Obras.NumeroObra --Convert(varchar,Obras.NumeroObra)+' '+Obras.Descripcion as [Obra],
	Else (Select Top 1 o.NumeroObra From DetalleComprobantesProveedores dcp 
		Left Outer Join Obras o On o.IdObra=dcp.IdObra
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and dcp.IdObra is not null)
 End as [Obra],
 C2.Descripcion as [Cuenta contable],
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
 Monedas.Abreviatura as [Mon.],
 cp.CotizacionDolar as [Cotiz. dolar],
 Provincias.Nombre as [Provincia destino],
 cp.Observaciones,
 E1.Nombre as [Ingreso],
 cp.FechaIngreso as [Fecha ingreso],
 E2.Nombre  as [Modifico],
 cp.FechaModifico as [Fecha modif.],
 Case 	When DestinoPago='A' Then 'ADM'
	When DestinoPago='O' Then 'OBRA'
	Else Null
 End as [Dest.Pago],
 cp.NumeroRendicionFF as [Nro.Rend.FF],
 (Select Top 1 DetObra.Destino
	From DetalleComprobantesProveedores dcp 
	Left Outer Join DetalleObrasDestinos DetObra On DetObra.IdDetalleObraDestino=dcp.IdDetalleObraDestino
	Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and dcp.IdDetalleObraDestino is not null) as [Etapa],
 (Select Top 1 por.Descripcion
	From DetalleComprobantesProveedores Det 
	Left Outer Join PresupuestoObrasRubros por On por.IdPresupuestoObraRubro=Det.IdPresupuestoObraRubro
	Where Det.IdComprobanteProveedor=cp.IdComprobanteProveedor and Det.IdPresupuestoObraRubro is not null) as [Rubro],
 cp.CircuitoFirmasCompleto as [Circuito de firmas completo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ComprobantesProveedores cp
LEFT OUTER JOIN Proveedores P1 ON cp.IdProveedor = P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor
LEFT OUTER JOIN Cuentas C1 ON IsNull(cp.IdCuenta,cp.IdCuentaOtros) = C1.IdCuenta
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Obras ON cp.IdObra = Obras.IdObra
LEFT OUTER JOIN OrdenesPago ON cp.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN Monedas ON cp.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Provincias ON cp.IdProvinciaDestino = Provincias.IdProvincia
LEFT OUTER JOIN DescripcionIva diva1 ON cp.IdCodigoIva = diva1.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva2 ON P1.IdCodigoIva = diva2.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva3 ON P2.IdCodigoIva = diva3.IdCodigoIva
LEFT OUTER JOIN Empleados E1 ON cp.IdUsuarioIngreso = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON cp.IdUsuarioModifico = E2.IdEmpleado
LEFT OUTER JOIN #Auxiliar1 ON cp.IdComprobanteProveedor = #Auxiliar1.IdComprobanteProveedor
LEFT OUTER JOIN Cuentas C2 ON #Auxiliar1.IdCuenta = C2.IdCuenta
WHERE (cp.FechaRecepcion Between @Desde And @Hasta) and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(@IdUsuarioFF=-1 or @IdUsuarioFF=cp.IdUsuarioIngreso)
ORDER BY cp.FechaRecepcion,cp.NumeroReferencia

DROP TABLE #Auxiliar1