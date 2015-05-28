
CREATE Procedure [dbo].[DiferenciasCambio_TX_PorPagosGeneradas]

AS 

DECLARE @Cotizacion Numeric(12,4)
SET @Cotizacion=(Select Top 1 CotizacionLibre From Cotizaciones
			Where 	Year(Cotizaciones.Fecha)=Year(GETDATE()) And 
				Month(Cotizaciones.Fecha)=Month(GETDATE()) And 
				Day(Cotizaciones.Fecha)=Day(GETDATE()) And 
				Cotizaciones.IdMoneda=(Select IdMonedaDolar From Parametros Where IdParametro=1))

DECLARE @vector_X varchar(30),@vector_T varchar(30),@Marca varchar(2)
SET @vector_X='011111111111111111111133'
SET @vector_T='029204344444444422666900'
SET @Marca='NO'

SELECT 
 DiferenciasCambio.IdDiferenciaCambio as [IdDiferenciaCambio],
 Proveedores.CodigoEmpresa as [Codigo],
 DiferenciasCambio.IdDiferenciaCambio as [IdAux],
 Proveedores.RazonSocial as [Proveedor],
 'OP ' + Substring('00000000',1,8-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago) as [Orden de pago],
 op.FechaOrdenPago as [Fecha pago],
 Substring(TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,30) as [Comprobante],
 cp.FechaComprobante as [Fecha comp.],
 Round(cp.TotalComprobante*cp.CotizacionMoneda/cp.CotizacionDolar,2) as [Imp.u$s Comp.],
 cp.CotizacionDolar as [Cot.u$s vta.],
 Round(dop.Importe*op.CotizacionMoneda/op.CotizacionDolar,2) as [Imp.u$s pagado],
 op.CotizacionDolar as [Cot.u$s pago],
 op.CotizacionDolar-cp.CotizacionDolar as [Dif.Cot.u$s],
 Case When op.IdMoneda=1
	Then Round(dop.Importe*op.CotizacionMoneda/op.CotizacionDolar,2) * 
			(op.CotizacionDolar-cp.CotizacionDolar) * (op.CotizacionDolar/cp.CotizacionDolar) / op.CotizacionDolar 
	Else Round(dop.Importe*op.CotizacionMoneda/op.CotizacionDolar,2) * 
			(op.CotizacionDolar-cp.CotizacionDolar) / op.CotizacionDolar 
 End as [Dif.cambio u$s],
 Case When op.IdMoneda=1
	Then Round(dop.Importe*op.CotizacionMoneda/op.CotizacionDolar,2) * 
			(op.CotizacionDolar-cp.CotizacionDolar) * (op.CotizacionDolar/cp.CotizacionDolar) 
	Else Round(dop.Importe*op.CotizacionMoneda/op.CotizacionDolar,2) * (op.CotizacionDolar-cp.CotizacionDolar)
 End as [Dif.cambio $],
 @Cotizacion as [Cot.u$s dia],
 Case 	When DiferenciasCambio.Estado is null or DiferenciasCambio.Estado='NO'
	 Then 'NO'
	Else DiferenciasCambio.Estado
 End as [Generado],
 @Marca as [Marcado],
 (Select tc.DescripcionAb From TiposComprobante tc Where tc.IdTipoComprobante=DiferenciasCambio.IdTipoComprobanteGenerado) as [Tipo comp.gen.],
 (Select cp1.NumeroReferencia From ComprobantesProveedores cp1 Where cp1.IdComprobanteProveedor=DiferenciasCambio.IdComprobanteGenerado) as [Nro.comp.gen.],
 (Select cp1.FechaComprobante From ComprobantesProveedores cp1 Where cp1.IdComprobanteProveedor=DiferenciasCambio.IdComprobanteGenerado) as [Fecha comp.gen.],
 op.IdProveedor,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DiferenciasCambio 
LEFT OUTER JOIN DetalleOrdenesPago dop ON dop.IdDetalleOrdenPago=DiferenciasCambio.IdRegistroOrigen And DiferenciasCambio.IdTipoComprobante=17
LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=dop.IdOrdenPago
LEFT OUTER JOIN CuentasCorrientesAcreedores ON CuentasCorrientesAcreedores.IdCtaCte=dop.IdImputacion
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CuentasCorrientesAcreedores.IdComprobante
LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
WHERE DiferenciasCambio.Estado is not null And 
	 DiferenciasCambio.IdTipoComprobante=17 And 
	 TiposComprobante.CalculaDiferenciaCambio='SI' And 
	 (op.CotizacionDolar-cp.CotizacionDolar) is not null And
	 (op.CotizacionDolar-cp.CotizacionDolar)<>0
ORDER by op.FechaOrdenPago,op.NumeroOrdenPago
