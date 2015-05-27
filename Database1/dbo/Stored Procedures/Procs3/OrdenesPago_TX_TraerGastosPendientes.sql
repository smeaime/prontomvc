CREATE Procedure [dbo].[OrdenesPago_TX_TraerGastosPendientes]

@IdOrdenPago int,
@IdMonedaOrdenPago int,
@IdCuentaFF int,
@NumeroRendicionFF int = Null,
@NumerosRendicionFF varchar(1000) = Null

AS

SET @NumeroRendicionFF=IsNull(@NumeroRendicionFF,-1)
SET @NumerosRendicionFF=IsNull(@NumerosRendicionFF,'')

DECLARE @IdMonedaPesos int, @IdMonedaDolar int, @vector_X varchar(30), @vector_T varchar(30)

SET @IdMonedaPesos=(Select Top 1 IdMoneda From Parametros Where IdParametro=1)
SET @IdMonedaDolar=(Select Top 1 IdMonedaDolar From Parametros Where IdParametro=1)
SET @vector_X='011111111111111115133'
SET @vector_T='002532441111199914200'

SELECT 
 cp.IdComprobanteProveedor, 
 tc.Descripcion as [Tipo comp.],
 cp.NumeroReferencia as [Nro.interno],
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,18) as [Numero],
 (Select Cuentas.Descripcion From Cuentas Where cp.IdCuenta = Cuentas.IdCuenta) as [Cuenta], 
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaVencimiento as [Fecha vto.],
 Convert(varchar,Obras.NumeroObra)+' '+Obras.Descripcion as [Obra],
 Case 	When cp.IdMoneda=@IdMonedaOrdenPago 
	 Then cp.TotalBruto*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente) 
	When @IdMonedaOrdenPago=@IdMonedaPesos
	 Then cp.TotalBruto*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda
	When @IdMonedaOrdenPago=@IdMonedaDolar
	 Then Case When cp.CotizacionDolar<>0 Then cp.TotalBruto*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda/cp.CotizacionDolar Else 0 End
	Else 0
 End as [Subtotal],
 Case 	When cp.IdMoneda=@IdMonedaOrdenPago 
	 Then cp.TotalIva1*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)
	When @IdMonedaOrdenPago=@IdMonedaPesos
	 Then cp.TotalIva1*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda
	When @IdMonedaOrdenPago=@IdMonedaDolar
	 Then Case When cp.CotizacionDolar<>0 Then cp.TotalIva1*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda/cp.CotizacionDolar Else 0 End
	Else 0
 End as [IVA 1],
 Case 	When cp.IdMoneda=@IdMonedaOrdenPago 
	 Then cp.TotalIva2*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)
	When @IdMonedaOrdenPago=@IdMonedaPesos
	 Then cp.TotalIva2*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda
	When @IdMonedaOrdenPago=@IdMonedaDolar
	 Then Case When cp.CotizacionDolar<>0 Then cp.TotalIva2*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda/cp.CotizacionDolar Else 0 End
	Else 0
 End as [IVA 2],
 Case 	When cp.IdMoneda=@IdMonedaOrdenPago 
	 Then cp.TotalBonificacion*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)
	When @IdMonedaOrdenPago=@IdMonedaPesos
	 Then cp.TotalBonificacion*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda
	When @IdMonedaOrdenPago=@IdMonedaDolar
	 Then Case When cp.CotizacionDolar<>0 Then cp.TotalBonificacion*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda/cp.CotizacionDolar Else 0 End
	Else 0
 End as [Imp.bonif.],
 Case 	When cp.IdMoneda=@IdMonedaOrdenPago 
	 Then cp.TotalComprobante*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)
	When @IdMonedaOrdenPago=@IdMonedaPesos
	 Then cp.TotalComprobante*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda
	When @IdMonedaOrdenPago=@IdMonedaDolar
	 Then Case When cp.CotizacionDolar<>0 Then cp.TotalComprobante*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)*cp.CotizacionMoneda/cp.CotizacionDolar Else 0 End
	Else 0
 End as [Total],
 cp.IdComprobanteProveedor as [IdComp], 
 Case When cp.IdOrdenPago=@IdOrdenPago Then 'SI' Else 'NO' End as [Asignada],
 cp.IdComprobanteProveedor as [IdAux], 
 Cuentas.Descripcion as [Cuenta],
 cp.Observaciones, 
 cp.NumeroRendicionFF as [Nro.Rend.], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ComprobantesProveedores cp
LEFT OUTER JOIN TiposComprobante tc ON  cp.IdTipoComprobante = tc.IdTipoComprobante
LEFT OUTER JOIN Obras ON  cp.IdObra = Obras.IdObra
LEFT OUTER JOIN Cuentas ON  cp.IdCuenta = Cuentas.IdCuenta
WHERE IsNull(cp.Confirmado,'SI')<>'NO' and cp.IdProveedor is null and 
	(cp.IdOrdenPago=@IdOrdenPago or cp.IdOrdenPago is null) and 
	(@IdCuentaFF=-1 or IsNull(cp.IdCuenta,0)=@IdCuentaFF) and 
	(@NumeroRendicionFF=-1 or IsNull(cp.NumeroRendicionFF,0)=@NumeroRendicionFF or Patindex('%('+Convert(varchar,IsNull(cp.NumeroRendicionFF,0))+')%', @NumerosRendicionFF)<>0) 
ORDER BY cp.FechaComprobante,cp.NumeroReferencia