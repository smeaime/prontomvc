
CREATE Procedure [dbo].[Subcontratos_TX_HojaRutaPorNumeroCertificado]

@NumeroSubcontrato int,
@AmpliacionSubcontrato int = Null,
@NumeroCertificado int = Null

AS 

SET NOCOUNT ON

DECLARE @IdProveedor int, @IdCuentaSubcontratosAcopio int, @IdCuentaDevolucionAnticipoAProveedores int, @IdDetalleSubcontratoDatos int, 
	@Factura varchar(20), @IdMonedaPesos int, @IdMonedaDolar int, @IdMoneda int

SET @IdProveedor=IsNull((Select Top 1 IdProveedor From SubcontratosDatos Where NumeroSubcontrato=@NumeroSubcontrato),0)
SET @AmpliacionSubcontrato=IsNull(@AmpliacionSubcontrato,-1)
SET @NumeroCertificado=IsNull(@NumeroCertificado,-1)
SET @IdCuentaSubcontratosAcopio=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaSubcontratosAcopio'),0)
SET @IdCuentaDevolucionAnticipoAProveedores=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaDevolucionAnticipoAProveedores'),0)
SET @IdDetalleSubcontratoDatos=IsNull((Select Top 1 dsd.IdDetalleSubcontratoDatos From DetalleSubcontratosDatos dsd 
					Left Outer Join SubcontratosDatos sd On sd.IdSubcontratoDatos=dsd.IdSubcontratoDatos
					Where sd.NumeroSubcontrato=@NumeroSubcontrato and dsd.NumeroCertificado=@NumeroCertificado),0)
SET @Factura=IsNull((Select Top 1 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
					Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
			From DetalleComprobantesProveedores dcp
			Left Outer Join ComprobantesProveedores cp On dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
			Where dcp.IdDetalleSubcontratoDatos=@IdDetalleSubcontratoDatos),'')
SET @IdMoneda=IsNull((Select IdMoneda From SubcontratosDatos Where NumeroSubcontrato=@NumeroSubcontrato),1)
SET @IdMonedaPesos=IsNull((Select IdMoneda From Parametros Where IdParametro=1),1)
SET @IdMonedaDolar=IsNull((Select IdMonedaDolar From Parametros Where IdParametro=1),2)

CREATE TABLE #Auxiliar1 
			(
			 AnticipoAnterior NUMERIC(18,2),
			 Anticipo NUMERIC(18,2),
			 DevolucionAnticipoAnterior NUMERIC(18,2),
			 DevolucionAnticipo NUMERIC(18,2)
			)
CREATE TABLE #Auxiliar2 
			(
			 AnticipoAnterior NUMERIC(18,2),
			 Anticipo NUMERIC(18,2),
			 DevolucionAnticipoAnterior NUMERIC(18,2),
			 DevolucionAnticipo NUMERIC(18,2),
			 OtrosDescuentosAnterior NUMERIC(18,2)
			)

INSERT INTO #Auxiliar1 
 SELECT Case When IsNull(dcp.PorcentajeAnticipo,0)<>0 and IsNull(dcp.Importe,0)>0 and IsNull(dsd.NumeroCertificado,0)<@NumeroCertificado
		Then IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1) / 
				Case When @IdMoneda=@IdMonedaDolar Then IsNull(cp.CotizacionDolar,1) Else 1 End
		Else Null
	End,
	Case When IsNull(dcp.PorcentajeAnticipo,0)<>0 and IsNull(dcp.Importe,0)>0 and IsNull(dsd.NumeroCertificado,0)=@NumeroCertificado
		Then IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1) / 
				Case When @IdMoneda=@IdMonedaDolar Then IsNull(cp.CotizacionDolar,1) Else 1 End
		Else Null
	End,
	Case When ((IsNull(dcp.IdPedidoAnticipo,0)<>0 and IsNull(dcp.Importe,0)<0) or (tc.Coeficiente=-1 and dcp.IdCuenta=@IdCuentaDevolucionAnticipoAProveedores)) and IsNull(dsd.NumeroCertificado,0)<@NumeroCertificado
		Then IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1) / 
				Case When @IdMoneda=@IdMonedaDolar Then IsNull(cp.CotizacionDolar,1) Else 1 End
		Else Null
	End,
	Case When ((IsNull(dcp.IdPedidoAnticipo,0)<>0 and IsNull(dcp.Importe,0)<0) or (tc.Coeficiente=-1 and dcp.IdCuenta=@IdCuentaDevolucionAnticipoAProveedores)) and IsNull(dsd.NumeroCertificado,0)=@NumeroCertificado
		Then IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1) / 
				Case When @IdMoneda=@IdMonedaDolar Then IsNull(cp.CotizacionDolar,1) Else 1 End
		Else Null
	End
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON IsNull(cp.IdProveedor,cp.IdProveedorEventual)=Proveedores.IdProveedor
 LEFT OUTER JOIN DetalleSubcontratosDatos dsd ON dsd.IdDetalleSubcontratoDatos=dcp.IdDetalleSubcontratoDatos
 WHERE IsNull(cp.Confirmado,'SI')<>'NO' and IsNull(dcp.NumeroSubcontrato,0)=@NumeroSubcontrato and 
	(@AmpliacionSubcontrato=-1 or 
	 (@AmpliacionSubcontrato=0 and IsNull(dcp.AmpliacionSubcontrato,'')<>'SI') or 
	 (@AmpliacionSubcontrato=1 and IsNull(dcp.AmpliacionSubcontrato,'')='SI'))

INSERT INTO #Auxiliar2 
 SELECT Sum(IsNull(AnticipoAnterior,0)), Sum(IsNull(Anticipo,0)), Sum(IsNull(DevolucionAnticipoAnterior,0)), Sum(IsNull(DevolucionAnticipo,0)), 0
 FROM #Auxiliar1

UPDATE #Auxiliar2
SET OtrosDescuentosAnterior=IsNull((Select Sum(IsNull(OtrosDescuentos,0)) From DetalleSubcontratosDatos dsd
					Left Outer Join SubcontratosDatos sd On sd.IdSubcontratoDatos=dsd.IdSubcontratoDatos
					Where sd.NumeroSubcontrato=@NumeroSubcontrato and IsNull(dsd.NumeroCertificado,0)<@NumeroCertificado),0)

SET NOCOUNT OFF

SELECT #Auxiliar2.*, @Factura as [Factura] FROM #Auxiliar2

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
