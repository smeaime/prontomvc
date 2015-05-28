
CREATE Procedure [dbo].[DiferenciasCambio_TX_ParaCalculoIndividual]

@IdImputacion int,
@Cotizacion Numeric(18,4),
@Pagado Numeric(18,4),
@IdMonedaPago int

AS

SELECT
 Round(ComprobantesProveedores.TotalComprobante * 
	ComprobantesProveedores.CotizacionMoneda / 
	ComprobantesProveedores.CotizacionDolar,2) as [Imp.u$s Fact.],
 ComprobantesProveedores.CotizacionDolar as [Cot.u$s vta.],
 Round(@Pagado/@Cotizacion,2) as [Imp.u$s pagado],
 @Cotizacion as [Cot.u$s pago],
 @Cotizacion-ComprobantesProveedores.CotizacionDolar as [Dif.Cot.u$s],
 Case When @IdMonedaPago=1
	Then Round(@Pagado/@Cotizacion,2) * (@Cotizacion-ComprobantesProveedores.CotizacionDolar) *
			 (@Cotizacion/ComprobantesProveedores.CotizacionDolar) / @Cotizacion 
	Else Round(@Pagado/@Cotizacion,2) * (@Cotizacion-ComprobantesProveedores.CotizacionDolar) / @Cotizacion 
 End as [Dif.cambio u$s],
 Case When @IdMonedaPago=1
	Then Round(@Pagado/@Cotizacion,2) * (@Cotizacion-ComprobantesProveedores.CotizacionDolar) *
			(@Cotizacion/ComprobantesProveedores.CotizacionDolar) 
	Else Round(@Pagado/@Cotizacion,2) * (@Cotizacion-ComprobantesProveedores.CotizacionDolar)
 End as [Dif.cambio $],
 @Cotizacion as [Cot.u$s dia]
FROM CuentasCorrientesAcreedores
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesAcreedores.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores ON ComprobantesProveedores.IdComprobanteProveedor=CuentasCorrientesAcreedores.IdComprobante
WHERE CuentasCorrientesAcreedores.IdCtaCte=@IdImputacion and 
	  ComprobantesProveedores.IdComprobanteProveedor is not null and 
	  ComprobantesProveedores.CotizacionDolar is not null and 
	  ComprobantesProveedores.CotizacionDolar<>0
