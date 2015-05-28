
CREATE Procedure [dbo].[DiferenciasCambio_TX_ParaCalculoIndividualCobranzas]

@IdImputacion int,
@Cotizacion Numeric(18,4),
@Pagado Numeric(18,4),
@IdMonedaPago int,
@CotizacionMoneda Numeric(18,4)

AS 

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteNotaDebito int, @IdMonedaPesos int

SET @IdTipoComprobanteFacturaVenta=IsNull((Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1),0)
SET @IdTipoComprobanteNotaDebito=IsNull((Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1),0)
SET @IdMonedaPesos=IsNull((Select Top 1 IdMoneda From Parametros Where IdParametro=1),1)

SELECT
 Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
	Then Round(Facturas.ImporteTotal*Facturas.CotizacionMoneda/
		Case When IsNull(Facturas.CotizacionDolar,0)<>0 Then Facturas.CotizacionDolar Else 1000000 End,2) 
	Else Round(NotasDebito.ImporteTotal*NotasDebito.CotizacionMoneda/
		Case When IsNull(NotasDebito.CotizacionDolar,0)<>0 Then NotasDebito.CotizacionDolar Else 1000000 End,2) 
 End as [Imp.u$s Comp.],
 Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
	Then Facturas.CotizacionDolar 
	Else NotasDebito.CotizacionDolar 
 End as [Cot.u$s vta.],
 Round(@Pagado*@CotizacionMoneda / Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) as [Imp.u$s cobrado],
 @Cotizacion as [Cot.u$s cobro],
 Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
	Then @Cotizacion-Facturas.CotizacionDolar
	Else @Cotizacion-NotasDebito.CotizacionDolar
 End as [Dif.Cot.],
 Case When @IdMonedaPago=@IdMonedaPesos 
	Then 	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
			Then Round(@Pagado*@CotizacionMoneda/Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) * 
					(@Cotizacion-Facturas.CotizacionDolar) *
					(@Cotizacion/Case When IsNull(Facturas.CotizacionDolar,0)<>0
								Then Facturas.CotizacionDolar Else 1000000 End) / 
					Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End
			Else Round(@Pagado*@CotizacionMoneda/Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) * 
					(@Cotizacion-NotasDebito.CotizacionDolar) *
					(@Cotizacion/Case When IsNull(NotasDebito.CotizacionDolar,0)<>0
								Then NotasDebito.CotizacionDolar Else 1000000 End) / 
					Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End 
		End
	Else 	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
			Then Round(@Pagado*@CotizacionMoneda/Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) * 
					(@Cotizacion-Facturas.CotizacionDolar) / 
					Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End
			Else Round(@Pagado*@CotizacionMoneda/Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) * 
					(@Cotizacion-NotasDebito.CotizacionDolar) / 
					Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End
		End
 End as [Dif.cambio u$s],
 Case When @IdMonedaPago=@IdMonedaPesos 
	Then 	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
			Then Round(@Pagado*@CotizacionMoneda/
					Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) * 
					(@Cotizacion-Facturas.CotizacionDolar) *
					(@Cotizacion/Case When IsNull(Facturas.CotizacionDolar,0)<>0
								Then Facturas.CotizacionDolar Else 1000000 End) 
			Else Round(@Pagado*@CotizacionMoneda/
					Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) * 
					(@Cotizacion-NotasDebito.CotizacionDolar) *
					(@Cotizacion/Case When IsNull(NotasDebito.CotizacionDolar,0)<>0
								Then NotasDebito.CotizacionDolar Else 1000000 End) 
		End
	Else 	Case When CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta
			Then Round(@Pagado*@CotizacionMoneda/
					Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) * 
					(@Cotizacion-Facturas.CotizacionDolar)
			Else Round(@Pagado*@CotizacionMoneda/
					Case When @Cotizacion<>0 Then @Cotizacion Else 1000000 End,2) * 
					(@Cotizacion-NotasDebito.CotizacionDolar)
		End
 End as [Dif.cambio $],
 @Cotizacion as [Cot.u$s dia]
FROM CuentasCorrientesDeudores
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesDeudores.IdTipoComp
LEFT OUTER JOIN Facturas ON CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteFacturaVenta and 
				Facturas.IdFactura=CuentasCorrientesDeudores.IdComprobante
LEFT OUTER JOIN NotasDebito ON CuentasCorrientesDeudores.IdTipoComp=@IdTipoComprobanteNotaDebito and 
				NotasDebito.IdNotaDebito=CuentasCorrientesDeudores.IdComprobante
WHERE CuentasCorrientesDeudores.IdCtaCte=@IdImputacion
