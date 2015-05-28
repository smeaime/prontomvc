CREATE PROCEDURE [dbo].[InformesContables_TX_IVACompras_Modelo2]

@Desde datetime,
@Hasta datetime,
@ImpuestosInternosMasHijas varchar(2),
@IdCuentasAdicionalesImpuestosInternos varchar(1000)

AS

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IvaCompras_DesglosarNOGRAVADOS varchar(2), @IdCuentaImpuestosInternos int, @AgenteRetencionIVA varchar(2)

SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)
SET @IvaCompras_DesglosarNOGRAVADOS=IsNull((Select IvaCompras_DesglosarNOGRAVADOS From Parametros Where IdParametro=1),'NO')
SET @IdCuentaImpuestosInternos=IsNull((Select IdCuentaImpuestosInternos From Parametros Where IdParametro=1),0)
SET @AgenteRetencionIVA=IsNull((Select AgenteRetencionIVA From Parametros Where IdParametro=1),'NO')

DECLARE @IdCtaAdicCol1 int, @IdCtaAdicCol2 int, @IdCtaAdicCol3 int, @IdCtaAdicCol4 int, @IdCtaAdicCol5 int,
	@IdTipoCuentaGrupo1 int, @IdTipoCuentaGrupo2 int, @IdTipoCuentaGrupo3 int, @IdTipoCuentaGrupo4 int, @IdTipoCuentaGrupo5 int

SET @IdCtaAdicCol1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)
SET @IdTipoCuentaGrupo1=IsNull((Select IdTipoCuentaGrupo From Cuentas Where IdCuenta=@IdCtaAdicCol1),0)
SET @IdTipoCuentaGrupo2=IsNull((Select IdTipoCuentaGrupo From Cuentas Where IdCuenta=@IdCtaAdicCol2),0)
SET @IdTipoCuentaGrupo3=IsNull((Select IdTipoCuentaGrupo From Cuentas Where IdCuenta=@IdCtaAdicCol3),0)
SET @IdTipoCuentaGrupo4=IsNull((Select IdTipoCuentaGrupo From Cuentas Where IdCuenta=@IdCtaAdicCol4),0)
SET @IdTipoCuentaGrupo5=IsNull((Select IdTipoCuentaGrupo From Cuentas Where IdCuenta=@IdCtaAdicCol5),0)


CREATE TABLE #Auxiliar0	
			(
			 IdCuenta INTEGER,
			 IdCuentaMadre INTEGER
			)
INSERT INTO #Auxiliar0 
 SELECT Cuentas.IdCuenta, Null
 FROM Cuentas 
 WHERE Cuentas.IdCuenta=@IdCuentaImpuestosInternos or 
	Patindex('%('+Convert(varchar,Cuentas.IdCuenta)+')%', @IdCuentasAdicionalesImpuestosInternos)<>0
IF @ImpuestosInternosMasHijas='SI'
	INSERT INTO #Auxiliar0 
	 SELECT Cuentas.IdCuenta, IsNull(CuentasGastos.IdCuentaMadre,-1)
	 FROM Cuentas 
	 LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto
	 WHERE IsNull(CuentasGastos.IdCuentaMadre,-1)=@IdCuentaImpuestosInternos or 
		Patindex('%('+Convert(varchar,IsNull(CuentasGastos.IdCuentaMadre,-1))+')%', 
				@IdCuentasAdicionalesImpuestosInternos)<>0


CREATE TABLE #Auxiliar1
			(
			 A_IdComprobante INTEGER,
			 A_Coeficiente INTEGER,
			 A_MostrarTodo INTEGER,
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 2),
			 A_NetoNoGravadoImpInt NUMERIC(18, 2),
			 A_NetoGravado NUMERIC(18, 2),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 2),
			 A_IdCondicionIVA INTEGER,
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2),
			 A_NetoGravadoPorTasa NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	1,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				IsNull(Cuentas.CodigoAgrupacionAuxiliar,0)<>1 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and 
				(cp.Letra='C' or 
				 (dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0) and IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva)=1 and 
				  Exists(Select Top 1 dcp1.IdCuenta From DetalleComprobantesProveedores dcp1 
							Where dcp1.IdComprobanteProveedor=dcp.IdComprobanteProveedor and dcp1.IdCuenta=dcp.IdCuenta and dcp1.IdDetalleComprobanteProveedor<>dcp.IdDetalleComprobanteProveedor))))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then dcp.Importe*cp.CotizacionMoneda 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and IsNull(Cuentas.CodigoAgrupacionAuxiliar,0)<>1 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then dcp.Importe*cp.CotizacionMoneda 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and IsNull(Cuentas.CodigoAgrupacionAuxiliar,0)<>1 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and 
			dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0) and 
			IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva)=1 and 
			Exists(Select Top 1 dcp1.IdCuenta From DetalleComprobantesProveedores dcp1 
				 Where dcp1.IdComprobanteProveedor=dcp.IdComprobanteProveedor and 
					dcp1.IdCuenta=dcp.IdCuenta and 
					dcp1.IdDetalleComprobanteProveedor<>dcp.IdDetalleComprobanteProveedor)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then dcp.Importe*cp.CotizacionMoneda 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				IsNull(Cuentas.CodigoAgrupacionAuxiliar,0)<>1  
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else dcp.Importe*cp.CotizacionMoneda  
			End
		Else 0
	End,
	0,
	0,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When (dcp.IdCuenta=@IdCtaAdicCol1 or IsNull(Cuentas.CodigoAgrupacionAuxiliar,0)=1) and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	0
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		(cp.Confirmado is null or cp.Confirmado<>'NO')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje1,
	dcp.ImporteIVA1*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA1<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje2,
	dcp.ImporteIVA2*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA2<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje3,
	dcp.ImporteIVA3*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA3<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje4,
	dcp.ImporteIVA4*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA4<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje5,
	dcp.ImporteIVA5*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA5<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje6,
	dcp.ImporteIVA6*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA6<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje7,
	dcp.ImporteIVA7*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA7<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje8,
	dcp.ImporteIVA8*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA8<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje9,
	dcp.ImporteIVA9*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA9<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	dcp.IVAComprasPorcentaje10,
	dcp.ImporteIVA10*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	dcp.Importe*cp.CotizacionMoneda  
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA10<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	Case When dcp.IVAComprasPorcentajeDirecto is not null 
		Then dcp.IVAComprasPorcentajeDirecto
		Else 0
	End,
	dcp.Importe*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	0
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(Cuentas.IdTipoCuentaGrupo is not null and Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA) and 
		(dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
		 dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
		 dcp.IdCuenta<>@IdCtaAdicCol5) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	3,
	0,
	0,
	0,
	0,
	IsNull(dcp.IVAComprasPorcentajeDirecto,0),
	0,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	0
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		(Cuentas.IdTipoCuentaGrupo is not null and Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA) and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(dcp.IdCuenta=@IdCtaAdicCol1 or dcp.IdCuenta=@IdCtaAdicCol2 or 
		 dcp.IdCuenta=@IdCtaAdicCol3 or dcp.IdCuenta=@IdCtaAdicCol4 or 
		 dcp.IdCuenta=@IdCtaAdicCol5) and IsNull(dcp.IVAComprasPorcentajeDirecto,0)<>0 and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	cp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	2,
	0,
	0,
	0,
	0,
	Case When cp.PorcentajeIVAAplicacionAjuste is not null 
		Then cp.PorcentajeIVAAplicacionAjuste
		Else 0
	End,
	cp.AjusteIVA*cp.CotizacionMoneda,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	0
 FROM ComprobantesProveedores cp 
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		cp.FechaRecepcion between @Desde and @hasta and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		cp.AjusteIVA is not null and cp.AjusteIVA<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')


CREATE TABLE #Auxiliar2 
			(
			 A_IdComprobante INTEGER,
			 A_MostrarTodo INTEGER,
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 2),
			 A_NetoNoGravadoImpInt NUMERIC(18, 2),
			 A_NetoGravado NUMERIC(18, 2),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 2),
			 A_IdCondicionIVA INTEGER,
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2),
			 A_NetoGravadoPorTasa NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
	#Auxiliar1.A_IdComprobante,
	#Auxiliar1.A_MostrarTodo,
	SUM(#Auxiliar1.A_NetoNoGravado*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_NetoNoGravadoComprobantesC*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_NetoNoGravadoImpInt*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_NetoGravado*#Auxiliar1.A_Coeficiente),
	#Auxiliar1.A_Tasa,
	SUM(#Auxiliar1.A_IVA*#Auxiliar1.A_Coeficiente),
	MAX(Isnull(#Auxiliar1.A_IdCondicionIVA,1)),
	SUM(#Auxiliar1.A_CtaAdicCol1*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol2*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol3*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol4*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol5*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_NetoGravadoPorTasa*#Auxiliar1.A_Coeficiente)
 FROM #Auxiliar1 GROUP BY #Auxiliar1.A_IdComprobante,#Auxiliar1.A_Tasa,#Auxiliar1.A_MostrarTodo

CREATE TABLE #Auxiliar3 
			(
			 A_IdComprobante INTEGER,
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT 
	#Auxiliar2.A_IdComprobante,
	SUM(#Auxiliar2.A_NetoNoGravado+#Auxiliar2.A_NetoNoGravadoComprobantesC+
		#Auxiliar2.A_NetoNoGravadoImpInt+#Auxiliar2.A_NetoGravado+#Auxiliar2.A_IVA+
		#Auxiliar2.A_CtaAdicCol1+#Auxiliar2.A_CtaAdicCol2+#Auxiliar2.A_CtaAdicCol3+
		#Auxiliar2.A_CtaAdicCol4+#Auxiliar2.A_CtaAdicCol5)
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.A_IdComprobante


CREATE TABLE #Auxiliar 
			(
			 A_IdComprobante INTEGER,
			 A_KFecha DATETIME,
			 A_KTipoComprobante VARCHAR(6),
			 A_KTipoComprobante1 VARCHAR(2),
			 A_KMostrarTodo INTEGER,			 A_Fecha DATETIME,
			 A_FechaComprobante DATETIME,
			 A_Proveedor VARCHAR(100),
			 A_TipoComprobante VARCHAR(6),
			 A_Comprobante VARCHAR(30),
			 A_CondicionIVA VARCHAR(50),
			 A_Cuit VARCHAR(13),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 2),
			 A_NetoNoGravadoImpInt NUMERIC(18, 2),
			 A_NetoGravado NUMERIC(18, 2),
			 A_Tasa NUMERIC(6, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2),
			 A_ControlTotal NUMERIC(18, 2),
			 A_IdCondicionIVA INTEGER,
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2),
			 A_NumeroCAI VARCHAR(20)
			)
INSERT INTO #Auxiliar 
 SELECT 
	#Auxiliar2.A_IdComprobante,
	cp.FechaRecepcion,
	'1'+TiposComprobante.DescripcionAb,
	'CP',
	#Auxiliar2.A_MostrarTodo,
	cp.FechaRecepcion,
	cp.FechaComprobante,
	Case 	When cp.IdProveedor is not null Then Proveedores.RazonSocial
		When cp.IdProveedorEventual is not null 
		 Then (Select Top 1 P.RazonSocial From Proveedores P
			Where P.IdProveedor=cp.IdProveedorEventual)
		When cp.IdCuentaOtros is not null 
		 Then (Select Top 1 C.Descripcion From Cuentas C
			Where C.IdCuenta=cp.IdCuentaOtros)
		Else Null
	End,
	TiposComprobante.DescripcionAb,
	TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2),
	DescripcionIva.Descripcion,
			/*
			Case When cp.IdProveedor is not null
				Then DescripcionIva.Descripcion
				Else (Select Top 1 di.Descripcion From DescripcionIva di
					Left Outer Join Proveedores P On di.IdCodigoIva=P.IdCodigoIva
					Where P.IdProveedor=cp.IdProveedorEventual)
			End
			*/
	Case When cp.IdProveedor is not null
		Then Proveedores.Cuit
		Else IsNull((Select Top 1 P.Cuit From Proveedores P
				Where P.IdProveedor=cp.IdProveedorEventual),cp.Cuit)
	End,
	#Auxiliar2.A_NetoNoGravado,
	#Auxiliar2.A_NetoNoGravadoComprobantesC,
	#Auxiliar2.A_NetoNoGravadoImpInt,
	#Auxiliar2.A_NetoGravado,
	#Auxiliar2.A_Tasa,
	#Auxiliar2.A_IVA,
	cp.TotalComprobante*cp.CotizacionMoneda*TiposComprobante.Coeficiente,
	#Auxiliar3.A_Total,
	#Auxiliar2.A_IdCondicionIVA,
	#Auxiliar2.A_CtaAdicCol1,
	#Auxiliar2.A_CtaAdicCol2,
	#Auxiliar2.A_CtaAdicCol3,
	#Auxiliar2.A_CtaAdicCol4,
	#Auxiliar2.A_CtaAdicCol5,
	IsNull(cp.NumeroCAI,IsNull(cp.NumeroCAE,''))
 FROM #Auxiliar2
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = #Auxiliar2.A_IdComprobante
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN #Auxiliar3 ON cp.IdComprobanteProveedor = #Auxiliar3.A_IdComprobante
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=#Auxiliar2.A_IdCondicionIVA
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		(cp.Confirmado is null or cp.Confirmado<>'NO')
UNION ALL 

 SELECT 
	das.IdDetalleAsiento,
	Asientos.FechaAsiento,
	'5AS',
	'AS',
	1,
	Asientos.FechaAsiento,
	Asientos.FechaAsiento,
	'Asiento',
	'AS',
	'ASI '+Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+
		Convert(varchar,Asientos.NumeroAsiento)+' '+
		'Comp.:'+Substring('00000000',1,8-Len(Convert(varchar,das.NumeroComprobante)))+
		Convert(varchar,das.NumeroComprobante),
	'S/D',
	das.Cuit,
	Case When das.IdCuenta<>@IdCtaAdicCol1 and das.IdCuenta<>@IdCtaAdicCol2 and 
			das.IdCuenta<>@IdCtaAdicCol3 and das.IdCuenta<>@IdCtaAdicCol4 and 
			das.IdCuenta<>@IdCtaAdicCol5 and 
			not (@IvaCompras_DesglosarNOGRAVADOS='SI' and das.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0))
		Then (Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
			From DetalleAsientos 
			Where DetalleAsientos.IdAsiento=das.IdAsiento and 
				DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
				DetalleAsientos.FechaComprobante=das.FechaComprobante and 
				DetalleAsientos.TipoImporte='N')
		Else 0
	End,
	0,
	Case When das.IdCuenta<>@IdCtaAdicCol1 and das.IdCuenta<>@IdCtaAdicCol2 and 
			das.IdCuenta<>@IdCtaAdicCol3 and das.IdCuenta<>@IdCtaAdicCol4 and 
			das.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and das.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then (Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
			From DetalleAsientos 
			Where DetalleAsientos.IdAsiento=das.IdAsiento and 
				DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
				DetalleAsientos.FechaComprobante=das.FechaComprobante and 
				DetalleAsientos.TipoImporte='N')
		Else 0
	End,
	Case When das.IdCuenta<>@IdCtaAdicCol1 and das.IdCuenta<>@IdCtaAdicCol2 and 
			das.IdCuenta<>@IdCtaAdicCol3 and das.IdCuenta<>@IdCtaAdicCol4 and 
			das.IdCuenta<>@IdCtaAdicCol5 
		Then (Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
			From DetalleAsientos 
			Where DetalleAsientos.IdAsiento=das.IdAsiento and 
				DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
				DetalleAsientos.FechaComprobante=das.FechaComprobante and 
				DetalleAsientos.TipoImporte='G')
		Else 0
	End,
	IsNull(das.PorcentajeIVA,0),
	IsNull(das.Debe,0)-IsNull(das.Haber,0),
	(Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
	 From DetalleAsientos 
	 Where DetalleAsientos.IdAsiento=das.IdAsiento and 
		DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
		DetalleAsientos.FechaComprobante=das.FechaComprobante and 
		(DetalleAsientos.TipoImporte='I' or DetalleAsientos.TipoImporte='N' or 
		 DetalleAsientos.TipoImporte='G')),
	(Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
	 From DetalleAsientos 
	 Where DetalleAsientos.IdAsiento=das.IdAsiento and 
		DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
		DetalleAsientos.FechaComprobante=das.FechaComprobante and 
		(DetalleAsientos.TipoImporte='I' or DetalleAsientos.TipoImporte='N' or 
		 DetalleAsientos.TipoImporte='G')),
	Null,
	Case When das.IdCuenta=@IdCtaAdicCol1 
		Then (Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
			From DetalleAsientos 
			Where DetalleAsientos.IdAsiento=das.IdAsiento and 
				DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
				DetalleAsientos.FechaComprobante=das.FechaComprobante and 
				(DetalleAsientos.TipoImporte='N' or DetalleAsientos.TipoImporte='G'))
		Else 0
	End,
	Case When das.IdCuenta=@IdCtaAdicCol2 
		Then (Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
			From DetalleAsientos 
			Where DetalleAsientos.IdAsiento=das.IdAsiento and 
				DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
				DetalleAsientos.FechaComprobante=das.FechaComprobante and 
				(DetalleAsientos.TipoImporte='N' or DetalleAsientos.TipoImporte='G'))
		Else 0
	End,
	Case When das.IdCuenta=@IdCtaAdicCol3 
		Then (Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
			From DetalleAsientos 
			Where DetalleAsientos.IdAsiento=das.IdAsiento and 
				DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
				DetalleAsientos.FechaComprobante=das.FechaComprobante and 
				(DetalleAsientos.TipoImporte='N' or DetalleAsientos.TipoImporte='G'))
		Else 0
	End,
	Case When das.IdCuenta=@IdCtaAdicCol4 
		Then (Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
			From DetalleAsientos 
			Where DetalleAsientos.IdAsiento=das.IdAsiento and 
				DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
				DetalleAsientos.FechaComprobante=das.FechaComprobante and 
				(DetalleAsientos.TipoImporte='N' or DetalleAsientos.TipoImporte='G'))
		Else 0
	End,
	Case When das.IdCuenta=@IdCtaAdicCol5 
		Then (Select Sum(IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)) 
			From DetalleAsientos 
			Where DetalleAsientos.IdAsiento=das.IdAsiento and 
				DetalleAsientos.NumeroComprobante=das.NumeroComprobante and 
				DetalleAsientos.FechaComprobante=das.FechaComprobante and 
				(DetalleAsientos.TipoImporte='N' or DetalleAsientos.TipoImporte='G'))
		Else 0
	End,
	Null FROM DetalleAsientos das 
 LEFT OUTER JOIN Asientos ON Asientos.IdAsiento=das.IdAsiento
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=das.IdCuenta
 WHERE Asientos.FechaAsiento between @Desde and DATEADD(n,1439,@hasta) and 
	Asientos.IdCuentaSubdiario is null and das.Libro='C' and das.TipoImporte='I' 

UNION ALL 

 SELECT 
	Valores.IdValor,
	Valores.FechaComprobante,
	'1'+TiposComprobante.DescripcionAb,
	'VA',
	1,
	Valores.FechaComprobante,
	Valores.FechaComprobante,
	Bancos.Nombre,
	TiposComprobante.DescripcionAb,
	TiposComprobante.DescripcionAb+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+
		Convert(varchar,Valores.NumeroComprobante),
	DescripcionIva.Descripcion,
	Bancos.Cuit,
	Case When Valores.IdCuentaContable<>@IdCtaAdicCol1 and Valores.IdCuentaContable<>@IdCtaAdicCol2 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol3 and Valores.IdCuentaContable<>@IdCtaAdicCol4 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol5 and 
			not (@IvaCompras_DesglosarNOGRAVADOS='SI' and Valores.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0))
		Then 	Case When Iva=0 
				Then Importe * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) 
				Else 0 
			End
		Else 0
	End,
	0,
	Case When Valores.IdCuentaContable<>@IdCtaAdicCol1 and Valores.IdCuentaContable<>@IdCtaAdicCol2 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol3 and Valores.IdCuentaContable<>@IdCtaAdicCol4 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and Valores.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case When Iva=0 
				Then Importe * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) 
				Else 0 
			End
		Else 0
	End,
	Case When Valores.IdCuentaContable<>@IdCtaAdicCol1 and Valores.IdCuentaContable<>@IdCtaAdicCol2 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol3 and Valores.IdCuentaContable<>@IdCtaAdicCol4 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol5 
		Then 	Case When Iva=0 
				Then 0 
				Else (Importe-iva) * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) 
			End
		Else 0
	End,
	IsNull(PorcentajeIva,0),
	Case When IsNull(Valores.IdCuentaIVA,-1)<>@IdCtaAdicCol1 and IsNull(Valores.IdCuentaIVA,-1)<>@IdCtaAdicCol2 and 
			IsNull(Valores.IdCuentaIVA,-1)<>@IdCtaAdicCol3 and IsNull(Valores.IdCuentaIVA,-1)<>@IdCtaAdicCol4 and 
			IsNull(Valores.IdCuentaIVA,-1)<>@IdCtaAdicCol5 
		Then Iva * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1)
		Else 0
	End,
	Importe * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1),
	0,
	Bancos.IdCodigoIva,
	Case When IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol1 
		Then (Importe-iva) * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) 
		Else 0 
	End + 
	Case When IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol1 
		Then Iva * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1)
		Else 0
	End,
	Case When IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol2 
		Then (Importe-iva) * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) 
		Else 0 
	End + 
	Case When IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol2 
		Then Iva * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1)
		Else 0
	End,
	Case When IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol3 
		Then (Importe-iva) * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) 
		Else 0 
	End + 
	Case When IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol3 
		Then Iva * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1)
		Else 0
	End,
	Case When IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol4 
		Then (Importe-iva) * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) 
		Else 0 
	End + 
	Case When IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol4 
		Then Iva * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1)
		Else 0
	End,
	Case 	When IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol5 
		 Then (Importe-iva) * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1) 
		 Else 0 
	End + 
	Case When IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol5 
		Then Iva * TiposComprobante.Coeficiente * IsNull(Valores.CotizacionMoneda,1)
		Else 0
	End,
	Null
 FROM Valores  
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Bancos ON Valores.IdBanco = Bancos.IdBanco
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Bancos.IdCodigoIva
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
	(Valores.FechaComprobante between @Desde and @hasta) and (Valores.Estado='G' or Valores.Estado='T') and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.Iva is not null and Valores.Iva<>0

UNION ALL 

 SELECT 
	dopc.IdDetalleOrdenPagoCuentas,
	OrdenesPago.FechaOrdenPago,
	'6OP',
	'OP',
	1,
	OrdenesPago.FechaOrdenPago,
	OrdenesPago.FechaOrdenPago,
	Case When Proveedores.RazonSocial is not null
		Then Proveedores.RazonSocial
		Else Convert(varchar(50),IsNull(OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS,''))
	End,
	'OP',
	'OP '+Substring('0000000000',1,10-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
		Convert(varchar,OrdenesPago.NumeroOrdenPago),
	Case When Proveedores.IdCodigoIva is not null
		Then (Select Top 1 DescripcionIva.Descripcion
			From DescripcionIva
			Where DescripcionIva.IdCodigoIva=Proveedores.IdCodigoIva)
		Else ''
	End,
	IsNull(Proveedores.Cuit,'00-00000000-0'),
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Case When dopc.IdCuenta=@IdCtaAdicCol1 
		Then (IsNull(dopc.Debe,0)-IsNull(dopc.Haber,0)) * IsNull(OrdenesPago.CotizacionMoneda,1) * -1
		Else 0
	End,
	Case When dopc.IdCuenta=@IdCtaAdicCol2 
		Then (IsNull(dopc.Debe,0)-IsNull(dopc.Haber,0)) * IsNull(OrdenesPago.CotizacionMoneda,1) * -1
		Else 0
	End,
	Case When dopc.IdCuenta=@IdCtaAdicCol3 
		Then (IsNull(dopc.Debe,0)-IsNull(dopc.Haber,0)) * IsNull(OrdenesPago.CotizacionMoneda,1) * -1
		Else 0
	End,
	Case When dopc.IdCuenta=@IdCtaAdicCol4 
		Then (IsNull(dopc.Debe,0)-IsNull(dopc.Haber,0)) * IsNull(OrdenesPago.CotizacionMoneda,1) * -1
		Else 0
	End,
	Case When dopc.IdCuenta=@IdCtaAdicCol5 
		Then (IsNull(dopc.Debe,0)-IsNull(dopc.Haber,0)) * IsNull(OrdenesPago.CotizacionMoneda,1) * -1
		Else 0
	End,
	Null FROM DetalleOrdenesPagoCuentas dopc 
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopc.IdOrdenPago
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=OrdenesPago.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=dopc.IdCuenta
 WHERE OrdenesPago.FechaOrdenPago between @Desde and DATEADD(n,1439,@hasta) and 
	(IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol1 or IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol2 or 
	 IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol3 or IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol4 or 
	 IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol5 )

IF @AgenteRetencionIVA='SI' 
	INSERT INTO #Auxiliar 
	 SELECT 
		drc.IdDetalleReciboCuentas,
		Recibos.FechaRecibo,
		'5RE',
		'RE',
		1,
		Recibos.FechaRecibo,
		Recibos.FechaRecibo,
		Case When Clientes.RazonSocial is not null
			Then Clientes.RazonSocial
			Else Convert(varchar(50),IsNull(Recibos.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS,''))
		End,
		'RE',
		'RE '+Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+
			Convert(varchar,Recibos.NumeroRecibo),
		Case When Clientes.IdCodigoIva is not null
			Then (Select Top 1 DescripcionIva.Descripcion
				From DescripcionIva
				Where DescripcionIva.IdCodigoIva=Clientes.IdCodigoIva)
			Else (Select Top 1 DescripcionIva.Descripcion
				From DescripcionIva
				Where DescripcionIva.IdCodigoIva=Recibos.IdCodigoIvaOpcional)
		End,
		IsNull(Clientes.Cuit,Recibos.CuitOpcional),
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		Null,
		Case When drc.IdCuenta=@IdCtaAdicCol1 
			Then (IsNull(drc.Debe,0)-IsNull(drc.Haber,0))* IsNull(Recibos.CotizacionMoneda,1)
			Else 0
		End,
		Case When drc.IdCuenta=@IdCtaAdicCol2 
			Then (IsNull(drc.Debe,0)-IsNull(drc.Haber,0))* IsNull(Recibos.CotizacionMoneda,1)
			Else 0
		End,
		Case When drc.IdCuenta=@IdCtaAdicCol3 
			Then (IsNull(drc.Debe,0)-IsNull(drc.Haber,0))* IsNull(Recibos.CotizacionMoneda,1)
			Else 0
		End,
		Case When drc.IdCuenta=@IdCtaAdicCol4 
			Then (IsNull(drc.Debe,0)-IsNull(drc.Haber,0))* IsNull(Recibos.CotizacionMoneda,1)
			Else 0
		End,
		Case When drc.IdCuenta=@IdCtaAdicCol5 
			Then (IsNull(drc.Debe,0)-IsNull(drc.Haber,0))* IsNull(Recibos.CotizacionMoneda,1)
			Else 0
		End,
		Null	
	 FROM DetalleRecibosCuentas drc 
	 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=drc.IdRecibo
	 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Recibos.IdCliente
	 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=drc.IdCuenta
	 WHERE Recibos.FechaRecibo between @Desde and DATEADD(n,1439,@hasta) and IsNull(Recibos.Anulado,'NO')<>'SI' and 
		(IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol1 or IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol2 or 
		 IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol3 or IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol4 or 
		 IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol5 )


CREATE TABLE #Auxiliar4
			(
			 A_Tasa NUMERIC(6, 2),
			 A_Iva NUMERIC(18, 2),			 A_NetoGravadoPorTasa NUMERIC(18, 2),
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT 
	#Auxiliar2.A_Tasa,
	SUM(#Auxiliar2.A_Iva),
	SUM(#Auxiliar2.A_NetoGravadoPorTasa),
	SUM(CASE WHEN @IdTipoCuentaGrupo1=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar2.A_CtaAdicCol1 ELSE 0 END),
	SUM(CASE WHEN @IdTipoCuentaGrupo2=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar2.A_CtaAdicCol2 ELSE 0 END),
	SUM(CASE WHEN @IdTipoCuentaGrupo3=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar2.A_CtaAdicCol3 ELSE 0 END),
	SUM(CASE WHEN @IdTipoCuentaGrupo4=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar2.A_CtaAdicCol4 ELSE 0 END),
	SUM(CASE WHEN @IdTipoCuentaGrupo5=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar2.A_CtaAdicCol5 ELSE 0 END)
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.A_Tasa

 UNION ALL

 SELECT 
	IsNull(#Auxiliar.A_Tasa,0),
	SUM(IsNull(#Auxiliar.A_Iva,0)),
	SUM(IsNull(#Auxiliar.A_NetoGravado,0)),
	SUM(CASE WHEN @IdTipoCuentaGrupo1=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar.A_CtaAdicCol1 ELSE 0 END),
	SUM(CASE WHEN @IdTipoCuentaGrupo2=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar.A_CtaAdicCol2 ELSE 0 END),
	SUM(CASE WHEN @IdTipoCuentaGrupo3=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar.A_CtaAdicCol3 ELSE 0 END),
	SUM(CASE WHEN @IdTipoCuentaGrupo4=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar.A_CtaAdicCol4 ELSE 0 END),
	SUM(CASE WHEN @IdTipoCuentaGrupo5=@IdTipoCuentaGrupoIVA 
		  THEN #Auxiliar.A_CtaAdicCol5 ELSE 0 END)
 FROM #Auxiliar
 WHERE #Auxiliar.A_KTipoComprobante1 IN ('AS','VA','RE','OP')
 GROUP BY #Auxiliar.A_Tasa

CREATE TABLE #Auxiliar41
			(
			 A_Tasa NUMERIC(6, 2),
			 A_Iva NUMERIC(18, 2),			 A_NetoGravadoPorTasa NUMERIC(18, 2),
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar41 
 SELECT 
	#Auxiliar4.A_Tasa,
	SUM(#Auxiliar4.A_Iva),
	SUM(#Auxiliar4.A_NetoGravadoPorTasa),
	SUM(#Auxiliar4.A_CtaAdicCol1),
	SUM(#Auxiliar4.A_CtaAdicCol2),
	SUM(#Auxiliar4.A_CtaAdicCol3),
	SUM(#Auxiliar4.A_CtaAdicCol4),
	SUM(#Auxiliar4.A_CtaAdicCol5)
 FROM #Auxiliar4
 GROUP BY #Auxiliar4.A_Tasa


CREATE TABLE #Auxiliar5
			(
			 A_IdCondicionIVA INTEGER,
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 2),
			 A_NetoNoGravadoImpInt NUMERIC(18, 2),
			 A_NetoGravado NUMERIC(18, 2),			 A_Iva NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar5 
 SELECT 
	IsNull(#Auxiliar.A_IdCondicionIVA,-3),
	IsNull(#Auxiliar.A_NetoNoGravado,0),
	IsNull(#Auxiliar.A_NetoNoGravadoComprobantesC,0),
	IsNull(#Auxiliar.A_NetoNoGravadoImpInt,0),
	IsNull(#Auxiliar.A_NetoGravado,0),
	IsNull(#Auxiliar.A_Iva,0)
 FROM #Auxiliar


CREATE TABLE #Auxiliar6
			(
			 A_IdCondicionIVA INTEGER,
			 A_Condicion VARCHAR(50),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 2),
			 A_NetoNoGravadoImpInt NUMERIC(18, 2),
			 A_NetoGravado NUMERIC(18, 2),
			 A_Iva NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar6 
 SELECT 
	#Auxiliar5.A_IdCondicionIVA,
	Null,
	SUM(#Auxiliar5.A_NetoNoGravado),
	SUM(#Auxiliar5.A_NetoNoGravadoComprobantesC),
	SUM(#Auxiliar5.A_NetoNoGravadoImpInt),
	SUM(#Auxiliar5.A_NetoGravado),
	SUM(#Auxiliar5.A_Iva)
 FROM #Auxiliar5
 GROUP BY #Auxiliar5.A_IdCondicionIVA

UPDATE #Auxiliar6
SET A_Condicion=(Select Top 1 DescripcionIva.Descripcion
		 From DescripcionIva
		 Where DescripcionIva.IdCodigoIVA=#Auxiliar6.A_IdCondicionIVA)

UPDATE #Auxiliar6
SET A_Condicion='Otros'
WHERE A_Condicion IS NULL


SET NOCOUNT OFF

Declare @vector_X varchar(50),@vector_T varchar(50),@vector_E varchar(500)
Set @vector_X='0000111166666133'
Set @vector_T='0000415333333900'
Set @vector_E=' FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 '

SELECT 
	A_IdComprobante as [A_IdComprobante],
	A_Fecha as [A_KFecha],
	A_KTipoComprobante as [A_KTipoComprobante],
	'1' as [Orden],
	A_Fecha as [Fecha],
	A_Proveedor as [Proveedor],
	A_Cuit as [Cuit],	A_Comprobante as [Comprobante],
	MAX(A_Total) as [Total],
	SUM(IsNull(A_NetoGravado,0)) as [Gravados],
	SUM(IsNull(A_NetoNoGravado,0)) as [No Gravados],
	SUM(IsNull(A_Iva,0)) as [Iva],
	Null [Iva n/Ins],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
GROUP BY A_IdComprobante, A_Fecha, A_KTipoComprobante, A_Proveedor, A_Cuit, A_Comprobante

UNION ALL 

SELECT 
	A_IdComprobante as [A_IdComprobante],
	A_Fecha as [A_KFecha],
	A_KTipoComprobante as [A_KTipoComprobante],
	'1' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],	Null as [Comprobante],
	SUM(IsNull(A_CtaAdicCol1,0)) as [Total],
	SUM(IsNull(A_CtaAdicCol2,0)) as [Gravados],
	SUM(IsNull(A_NetoNoGravadoImpInt,0)) as [No Gravados],
	SUM(IsNull(A_CtaAdicCol3,0)) [Iva],
	SUM(IsNull(A_CtaAdicCol4,0)) [Iva n/Ins],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
WHERE IsNull(A_CtaAdicCol1,0)<>0 or IsNull(A_CtaAdicCol2,0)<>0 or 
	IsNull(A_NetoNoGravadoImpInt,0)<>0 or 
	IsNull(A_CtaAdicCol3,0)<>0 or IsNull(A_CtaAdicCol4,0)<>0
GROUP BY A_IdComprobante, A_Fecha, A_KTipoComprobante

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	A_Fecha as [A_KFecha],
	Null as [A_KTipoComprobante],	'3' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	Null as [Total],
	Null as [Gravados],
	Null as [No Gravados],
	Null [Iva],
	Null [Iva n/Ins],
	' LIN:20:= | LIN:50:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:6:= ' as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
GROUP BY A_Fecha

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	A_Fecha as [A_KFecha],
	Null as [A_KTipoComprobante],	'4' as [Orden],
	Null as [Fecha],
	'TOTAL FECHA '+Convert(varchar,A_Fecha,103) as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	SUM(Case When A_KMostrarTodo=1 Then IsNull(A_Total,0) Else 0 End) as [Total],
	SUM(IsNull(A_NetoGravado,0)) as [Gravados],
	SUM(IsNull(A_NetoNoGravado,0)) as [No Gravados],
	SUM(IsNull(A_Iva,0)) as [Iva],
	Null [Iva n/Ins],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
GROUP BY A_Fecha

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	A_Fecha as [A_KFecha],
	Null as [A_KTipoComprobante],	'5' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	SUM(IsNull(A_CtaAdicCol1,0)) as [Total],
	SUM(IsNull(A_CtaAdicCol2,0)) as [Gravados],
	SUM(IsNull(A_NetoNoGravadoImpInt,0)) as [No Gravados],
	SUM(IsNull(A_CtaAdicCol3,0)) as [Iva],
	SUM(IsNull(A_CtaAdicCol4,0)) as [Iva n/Ins],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
GROUP BY A_Fecha

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	A_Fecha as [A_KFecha],
	Null as [A_KTipoComprobante],	'6' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	Null as [Total],
	Null as [Gravados],
	Null as [No Gravados],
	Null [Iva],
	Null [Iva n/Ins],
	' LIN:20:= | LIN:50:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:6:= ' as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
GROUP BY A_Fecha

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	999999 as [A_KFecha],
	Null as [A_KTipoComprobante],
	'7' as [Orden],
	Null as [Fecha],
	'TOTALES GENERALES' as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	SUM(Case When A_KMostrarTodo=1 Then IsNull(A_Total,0) Else 0 End) as [Total],
	SUM(IsNull(A_NetoGravado,0)) as [Gravados],
	SUM(IsNull(A_NetoNoGravado,0)) as [No Gravados],
	SUM(IsNull(A_Iva,0)) as [Iva],
	Null [Iva n/Ins],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	999999 as [A_KFecha],
	Null as [A_KTipoComprobante],
	'8' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	SUM(IsNull(A_CtaAdicCol1,0)) as [Total],
	SUM(IsNull(A_CtaAdicCol2,0)) as [Gravados],
	SUM(IsNull(A_NetoNoGravadoImpInt,0)) as [No Gravados],
	SUM(IsNull(A_CtaAdicCol3,0)) as [Iva],
	SUM(IsNull(A_CtaAdicCol4,0)) as [Iva n/Ins],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	999999 as [A_KFecha],
	Null as [A_KTipoComprobante],	'9' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	Null as [Total],
	Null as [Gravados],
	Null as [No Gravados],
	Null [Iva],
	Null [Iva n/Ins],
	' LIN:20:= | LIN:50:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:6:= ' as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	999999 as [A_KFecha],
	Null as [A_KTipoComprobante],
	'A' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	'Total tasa '+Convert(varchar,A_Tasa)+' %' as [Comprobante],
	Null as [Total],
	SUM(IsNull(A_NetoGravadoPorTasa,0)) as [Gravados],
	Null as [No Gravados],
	SUM(IsNull(A_Iva,0)) as [Iva],	Null as [Iva n/Ins],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar41
WHERE IsNull(A_NetoGravadoPorTasa,0)<>0 or IsNull(A_Iva,0)<>0
GROUP BY #Auxiliar41.A_Tasa

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	999999 as [A_KFecha],
	Null as [A_KTipoComprobante],	'B' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	Null as [Total],
	Null as [Gravados],
	Null as [No Gravados],
	Null [Iva],
	Null [Iva n/Ins],
	' LIN:20:= | LIN:50:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:20:= | LIN:6:= ' as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	999999 as [A_KFecha],
	A_KTipoComprobante1 as [A_KTipoComprobante],	'C' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	'TOTAL '+A_KTipoComprobante1 as [Comprobante],
	SUM(Case When A_KMostrarTodo=1 Then IsNull(A_Total,0) Else 0 End) as [Total],
	SUM(IsNull(A_NetoGravado,0)) as [Gravados],
	SUM(IsNull(A_NetoNoGravado,0)) as [No Gravados],
	SUM(IsNull(A_Iva,0)) as [Iva],
	Null [Iva n/Ins],
	@Vector_E as Vector_E,	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
GROUP BY  A_KTipoComprobante1

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	999999 as [A_KFecha],
	A_KTipoComprobante1 as [A_KTipoComprobante],
	'C' as [Orden],
	Null as [Fecha],	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	SUM(IsNull(A_CtaAdicCol1,0)) as [Total],
	SUM(IsNull(A_CtaAdicCol2,0)) as [Gravados],
	SUM(IsNull(A_NetoNoGravadoImpInt,0)) as [No Gravados],
	SUM(IsNull(A_CtaAdicCol3,0)) as [Iva],
	SUM(IsNull(A_CtaAdicCol4,0)) as [Iva n/Ins],
	' EBH ' as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
GROUP BY  A_KTipoComprobante1

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	999999 as [A_KFecha],
	Null as [A_KTipoComprobante],	'D' as [Orden],
	Null as [Fecha],
	Null as [Proveedor],
	Null as [Cuit],
	Null as [Comprobante],
	Null as [Total],
	Null as [Gravados],
	Null as [No Gravados],
	Null [Iva],
	Null [Iva n/Ins],
	' VAL:1;5;Importe Total;Percep.I.B., VAL:1;6;Neto Gravado;Percep.IVA, '+
		' VAL:1;7;Ex./N.Grav/N.Ins;Imp.Interno, VAL:1;8;IVA;Perc.Aduana, VAL:1;9;IVA N/Ins;Perc.Vale,'+
		' FN3:10, AN2:1;10, AN2:5;12, FN2:5;8, AN2:6;12, FN2:6;8, AN2:7;12, FN2:7;8, '+
		' AN2:8;12, FN2:8;8, AN2:9;6, FN2:9;8, CO2:0 ' as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X

ORDER BY [A_KFecha],[Orden],[A_KTipoComprobante],[A_IdComprobante],[Comprobante] DESC

/*
select * FROM #Auxiliar
order by A_IdComprobante, A_Fecha, A_KTipoComprobante, A_Proveedor, A_Cuit, A_Comprobante
*/

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar41