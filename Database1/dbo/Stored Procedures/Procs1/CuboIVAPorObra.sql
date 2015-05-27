CREATE PROCEDURE [dbo].[CuboIVAPorObra]

@FechaDesde datetime,
@FechaHasta datetime,
@Dts varchar(200)

AS

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdCtaAdicCol1 int, @IdCtaAdicCol2 int, @IdCtaAdicCol3 int, @IdCtaAdicCol4 int, @IdCtaAdicCol5 int

SET @IdTipoCuentaGrupoIVA=IsNull((Select Parametros.IdTipoCuentaGrupoIVA From Parametros Where Parametros.IdParametro=1),0)
SET @IdCtaAdicCol1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar0 
			(
			 Tipo VARCHAR(2),
			 IdComprobante INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar0 
 SELECT 
  'FA',
  dfoc.IdFactura,
  OrdenesCompra.IdObra
 FROM DetalleFacturasOrdenesCompra dfoc
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura = dfoc.IdFactura
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE OrdenesCompra.IdObra is not null and 
	(Fac.FechaFactura between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Fac.Anulada is null or Fac.Anulada<>'SI')

 UNION ALL

 SELECT 
  'FA',
  DetFacRem.IdFactura,
  DetalleRemitos.IdObra
 FROM DetalleFacturasRemitos DetFacRem
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura = DetFacRem.IdFactura
 LEFT OUTER JOIN DetalleRemitos ON DetFacRem.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
 WHERE DetalleRemitos.IdObra is not null and 
	(Fac.FechaFactura between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Fac.Anulada is null or Fac.Anulada<>'SI')

 UNION ALL

 SELECT 
  'FA',
  Fac.IdFactura,
  Fac.IdObra
 FROM Facturas Fac 
 WHERE Fac.IdObra is not null and 
	(Fac.FechaFactura between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Fac.Anulada is null or Fac.Anulada<>'SI') 

 UNION ALL

 SELECT 
  'CD',
  DetDev.IdDevolucion,
  DetDev.IdObra
 FROM DetalleDevoluciones DetDev
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion = DetDev.IdDevolucion
 WHERE DetDev.IdObra is not null and 
	(Dev.FechaDevolucion between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Dev.Anulada is null or Dev.Anulada<>'SI')

 UNION ALL

 SELECT 
  'ND',
  Deb.IdNotaDebito,
  Deb.IdObra
 FROM NotasDebito Deb
 WHERE Deb.IdObra is not null and 
	(Deb.FechaNotaDebito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and
	(Deb.Anulada is null or Deb.Anulada<>'SI') and Deb.CtaCte='SI'

 UNION ALL

 SELECT 
  'NC',
  Cre.IdNotaCredito,
  OrdenesCompra.IdObra
 FROM DetalleNotasCreditoOrdenesCompra dcoc
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito = dcoc.IdNotaCredito
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dcoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE OrdenesCompra.IdObra is not null and 
	(Cre.FechaNotaCredito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI') and Cre.CtaCte='SI'

CREATE TABLE #Auxiliar1 
			(
			 Tipo VARCHAR(2),
			 IdComprobante INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Tipo,
  IdComprobante,
  MAX(IdObra)
 FROM #Auxiliar0
 GROUP BY Tipo,IdComprobante


TRUNCATE TABLE _TempCuboIVAPorObra

INSERT INTO _TempCuboIVAPorObra 

 SELECT 
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  '1.VENTAS',
  '('+Convert(varchar,Year(Fac.FechaFactura))+
	Substring('00',1,2-Len(Convert(varchar,Month(Fac.FechaFactura))))+Convert(varchar,Month(Fac.FechaFactura))+
	Substring('00',1,2-Len(Convert(varchar,Day(Fac.FechaFactura))))+Convert(varchar,Day(Fac.FechaFactura))+') '+
  'FAC '+Fac.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura)+' '+
	'del '+Convert(varchar,Fac.FechaFactura,103)+' '+'Cliente : '+IsNull(Clientes.RazonSocial,''),
  Case 	When Fac.TipoABC='E' Then 0
	Else (Fac.ImporteIva1 + Fac.ImporteIva2 + IsNull(Fac.IvaNoDiscriminado,0)) * IsNull(Fac.CotizacionMoneda,0)
  End
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='FA' and #Auxiliar1.IdComprobante=Fac.IdFactura
 LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
 WHERE (Fac.FechaFactura between @FechaDesde and @FechaHasta) and 
	(Fac.Anulada is null or Fac.Anulada<>'SI')

 UNION ALL

 SELECT 
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  '1.VENTAS',
  '('+Convert(varchar,Year(Dev.FechaDevolucion))+
	Substring('00',1,2-Len(Convert(varchar,Month(Dev.FechaDevolucion))))+Convert(varchar,Month(Dev.FechaDevolucion))+
	Substring('00',1,2-Len(Convert(varchar,Day(Dev.FechaDevolucion))))+Convert(varchar,Day(Dev.FechaDevolucion))+') '+
  'DEV '+Dev.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion)+' '+
	'del '+Convert(varchar,Dev.FechaDevolucion,103)+' '+'Cliente : '+IsNull(Clientes.RazonSocial,''),
  Case 	When Dev.TipoABC='B' 
	 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
		Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
		(1+(Dev.PorcentajeIva1/100)) * (Dev.PorcentajeIva1/100) * 
		Dev.CotizacionMoneda * -1
	When Dev.TipoABC='E' 
	 Then 0
	Else (Dev.ImporteIva1 + Dev.ImporteIva2) * Dev.CotizacionMoneda * -1
  End
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Dev.IdCliente
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='CD' and #Auxiliar1.IdComprobante=Dev.IdDevolucion
 LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
 WHERE (Dev.FechaDevolucion between @FechaDesde and @FechaHasta) and 
	(Dev.Anulada is null or Dev.Anulada<>'SI')

 UNION ALL

 SELECT 
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  '1.VENTAS',
  '('+Convert(varchar,Year(Deb.FechaNotaDebito))+
	Substring('00',1,2-Len(Convert(varchar,Month(Deb.FechaNotaDebito))))+Convert(varchar,Month(Deb.FechaNotaDebito))+
	Substring('00',1,2-Len(Convert(varchar,Day(Deb.FechaNotaDebito))))+Convert(varchar,Day(Deb.FechaNotaDebito))+') '+
  'DEB '+Deb.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito)+' '+
	'del '+Convert(varchar,Deb.FechaNotaDebito,103)+' '+'Cliente : '+IsNull(Clientes.RazonSocial,''),
  Case 	When Deb.TipoABC='B' 
	 Then (Select Sum(DetND.Importe) From DetalleNotasDebito DetND
		Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * (Deb.PorcentajeIva1/100) * Deb.CotizacionMoneda
	When Deb.TipoABC='E' 
	 Then 0
	Else (Deb.ImporteIva1 + Deb.ImporteIva2) * Deb.CotizacionMoneda
  End
 FROM NotasDebito Deb
 LEFT OUTER JOIN Clientes ON Deb.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='ND' and #Auxiliar1.IdComprobante=Deb.IdNotaDebito
 LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
 WHERE (Deb.FechaNotaDebito between @FechaDesde and @FechaHasta) and 
	(Deb.Anulada is null or Deb.Anulada<>'SI')  and 
	(Deb.CtaCte is null or Deb.CtaCte='SI')

 UNION ALL

 SELECT 
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  '1.VENTAS',
  '('+Convert(varchar,Year(Cre.FechaNotaCredito))+
	Substring('00',1,2-Len(Convert(varchar,Month(Cre.FechaNotaCredito))))+Convert(varchar,Month(Cre.FechaNotaCredito))+
	Substring('00',1,2-Len(Convert(varchar,Day(Cre.FechaNotaCredito))))+Convert(varchar,Day(Cre.FechaNotaCredito))+') '+
  'CRE '+Cre.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito)+' '+
	'del '+Convert(varchar,Cre.FechaNotaCredito,103)+' '+'Cliente : '+IsNull(Clientes.RazonSocial,''),
  Case When Cre.TipoABC='B' 
	Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
		Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
		(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * 
		Cre.CotizacionMoneda * -1
	When Cre.TipoABC='E' 
	 Then 0
	Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda * -1
  End
 FROM NotasCredito Cre
 LEFT OUTER JOIN Clientes ON Cre.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='NC' and #Auxiliar1.IdComprobante=Cre.IdNotaCredito
 LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
 WHERE (Cre.FechaNotaCredito between @FechaDesde and @FechaHasta) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI')  and 
	(Cre.CtaCte is null or Cre.CtaCte='SI')

 UNION ALL

 SELECT 
  Case 	When DetCP.IdObra is not null Then (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra)
	When Cuentas.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra)
	When cp.IdObra is not null Then (Select Obras.NumeroObra From Obras Where cp.IdObra=Obras.IdObra)
	 Else ' NO IMPUTABLE'
  End,
  '2.COMPRAS',
  '('+Convert(varchar,Year(cp.FechaRecepcion))+
	Substring('00',1,2-Len(Convert(varchar,Month(cp.FechaRecepcion))))+Convert(varchar,Month(cp.FechaRecepcion))+
	Substring('00',1,2-Len(Convert(varchar,Day(cp.FechaRecepcion))))+Convert(varchar,Day(cp.FechaRecepcion))+') '+
  'Ref. '+Convert(varchar,cp.NumeroReferencia)+' '+
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2)+' '+	'del '+Convert(varchar,cp.FechaRecepcion,103)+' '+
	'Proveedor : '+
	Case When cp.IdProveedor is not null
		Then IsNull(Proveedores.RazonSocial,'')
		Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
	End,
  (IsNull(DetCP.ImporteIVA1,0)+IsNull(DetCP.ImporteIVA2,0)+IsNull(DetCP.ImporteIVA3,0)+
   IsNull(DetCP.ImporteIVA4,0)+IsNull(DetCP.ImporteIVA5,0)+IsNull(DetCP.ImporteIVA6,0)+
   IsNull(DetCP.ImporteIVA7,0)+IsNull(DetCP.ImporteIVA8,0)+IsNull(DetCP.ImporteIVA9,0)+
   IsNull(DetCP.ImporteIVA10,0)) * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
	(cp.FechaRecepcion between @FechaDesde and @FechaHasta) and 
	(cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT 
  Case 	When DetCP.IdObra is not null Then (Select Obras.NumeroObra From Obras Where DetCP.IdObra=Obras.IdObra)
	When Cuentas.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra)
	When cp.IdObra is not null Then (Select Obras.NumeroObra From Obras Where cp.IdObra=Obras.IdObra)
	 Else ' NO IMPUTABLE'
  End,
  '2.COMPRAS',
  '('+Convert(varchar,Year(cp.FechaRecepcion))+
	Substring('00',1,2-Len(Convert(varchar,Month(cp.FechaRecepcion))))+Convert(varchar,Month(cp.FechaRecepcion))+
	Substring('00',1,2-Len(Convert(varchar,Day(cp.FechaRecepcion))))+Convert(varchar,Day(cp.FechaRecepcion))+') '+
  'Ref. '+Convert(varchar,cp.NumeroReferencia)+' '+
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2)+' '+'del '+Convert(varchar,cp.FechaRecepcion,103)+' '+
	'Proveedor : '+
	Case When cp.IdProveedor is not null
		Then IsNull(Proveedores.RazonSocial,'')
		Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
	End,
  DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
 FROM DetalleComprobantesProveedores DetCP 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
	(cp.FechaRecepcion between @FechaDesde and @FechaHasta) and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	IsNull(Cuentas.IdTipoCuentaGrupo,0)=@IdTipoCuentaGrupoIVA 
--and (DetCP.IdCuenta<>@IdCtaAdicCol1 and DetCP.IdCuenta<>@IdCtaAdicCol2 and DetCP.IdCuenta<>@IdCtaAdicCol3 and DetCP.IdCuenta<>@IdCtaAdicCol4 and DetCP.IdCuenta<>@IdCtaAdicCol5)

 UNION ALL

 SELECT 
  Case 	When cp.IdObra is not null Then (Select Obras.NumeroObra From Obras Where cp.IdObra=Obras.IdObra)
	 Else IsNull((Select Obras.NumeroObra From Obras 
			Where Obras.IdObra=(Select Top 1 DetCP.IdObra From DetalleComprobantesProveedores DetCP 
						Where DetCP.IdComprobanteProveedor=cp.IdComprobanteProveedor and DetCP.IdObra is not null)),' NO IMPUTABLE')
  End,
  '2.COMPRAS',
  '('+Convert(varchar,Year(cp.FechaRecepcion))+
	Substring('00',1,2-Len(Convert(varchar,Month(cp.FechaRecepcion))))+Convert(varchar,Month(cp.FechaRecepcion))+
	Substring('00',1,2-Len(Convert(varchar,Day(cp.FechaRecepcion))))+Convert(varchar,Day(cp.FechaRecepcion))+') '+
  'Ref. '+Convert(varchar,cp.NumeroReferencia)+' '+
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2)+' '+	'del '+Convert(varchar,cp.FechaRecepcion,103)+' '+
	'Proveedor : '+
	Case When cp.IdProveedor is not null
		Then IsNull(Proveedores.RazonSocial,'')
		Else (Select Top 1 IsNull(P.RazonSocial,'') From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
	End,
  cp.AjusteIVA * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
	(cp.FechaRecepcion between @FechaDesde and @FechaHasta) and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	IsNull(cp.AjusteIVA,0)<>0

 UNION ALL

 SELECT 
  Case 	When das.IdObra is not null Then (Select Obras.NumeroObra From Obras Where das.IdObra=Obras.IdObra)
	When Cuentas.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Cuentas.IdObra=Obras.IdObra)
	 Else ' NO IMPUTABLE'
  End,
  '2.COMPRAS',
  '('+Convert(varchar,Year(Asientos.FechaAsiento))+
	Substring('00',1,2-Len(Convert(varchar,Month(Asientos.FechaAsiento))))+Convert(varchar,Month(Asientos.FechaAsiento))+
	Substring('00',1,2-Len(Convert(varchar,Day(Asientos.FechaAsiento))))+Convert(varchar,Day(Asientos.FechaAsiento))+') '+
  'ASI '+Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+
	Convert(varchar,Asientos.NumeroAsiento)+' '+
	'Comp.:'+Substring('00000000',1,8-Len(Convert(varchar,das.NumeroComprobante)))+Convert(varchar,das.NumeroComprobante)+' '+
	'del '+Convert(varchar,Asientos.FechaAsiento,103),
  (IsNull(das.Debe,0)-IsNull(das.Haber,0)) * -1
 FROM DetalleAsientos das 
 LEFT OUTER JOIN Asientos ON Asientos.IdAsiento=das.IdAsiento
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=das.IdCuenta
 WHERE Asientos.FechaAsiento between @FechaDesde and DATEADD(n,1439,@FechaHasta) and 
	Asientos.IdCuentaSubdiario is null and das.Libro='C' and das.TipoImporte='I' 

 UNION ALL

 SELECT 
  Case 	When Valores.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Valores.IdObra=Obras.IdObra)
	 Else ' NO IMPUTABLE'
  End,
  '2.COMPRAS',
  '('+Convert(varchar,Year(Valores.FechaGasto))+
	Substring('00',1,2-Len(Convert(varchar,Month(Valores.FechaGasto))))+Convert(varchar,Month(Valores.FechaGasto))+
	Substring('00',1,2-Len(Convert(varchar,Day(Valores.FechaGasto))))+Convert(varchar,Day(Valores.FechaGasto))+') '+
  TiposComprobante.DescripcionAb+' '+
	Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+Convert(varchar,Valores.NumeroComprobante)+' '+
	'del '+Convert(varchar,Valores.FechaGasto,103),
  Iva * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) * -1
 FROM Valores  
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
	(Valores.FechaGasto between @FechaDesde and @FechaHasta) and 
	Valores.Estado='G' and IsNull(Valores.Iva,0)<>0 and IsNull(Valores.Anulado,'NO')<>'SI'


UPDATE _TempCuboIVAPorObra
SET Obra=' NO IMPUTABLE'
WHERE Obra IS NULL

DELETE FROM _TempCuboIVAPorObra
WHERE IVA=0

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF