CREATE PROCEDURE [dbo].[InformesContables_TX_IVAComprasDetallado]

@Desde datetime,
@Hasta datetime,
@ImpuestosInternosMasHijas varchar(2),
@IdCuentasAdicionalesImpuestosInternos varchar(1000)

AS

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IvaCompras_DesglosarNOGRAVADOS varchar(2), @IdCuentaImpuestosInternos int, @IdComprobanteAEmitir int, 
		@IdCuentaAdicionalIVACompras1 int, @IdCuentaAdicionalIVACompras2 int, @IdCuentaAdicionalIVACompras3 int, @IdCuentaAdicionalIVACompras4 int, @IdCuentaAdicionalIVACompras5 int

SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)
SET @IvaCompras_DesglosarNOGRAVADOS=IsNull((Select IvaCompras_DesglosarNOGRAVADOS From Parametros Where IdParametro=1),'NO')
SET @IdCuentaImpuestosInternos=IsNull((Select IdCuentaImpuestosInternos From Parametros Where IdParametro=1),0)
SET @IdCuentaAdicionalIVACompras1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
SET @IdCuentaAdicionalIVACompras2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
SET @IdCuentaAdicionalIVACompras3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
SET @IdCuentaAdicionalIVACompras4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
SET @IdCuentaAdicionalIVACompras5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)
SET @IdComprobanteAEmitir=-1

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
 WHERE Cuentas.IdCuenta=@IdCuentaImpuestosInternos or Patindex('%('+Convert(varchar,Cuentas.IdCuenta)+')%', @IdCuentasAdicionalesImpuestosInternos)<>0
IF @ImpuestosInternosMasHijas='SI'
	INSERT INTO #Auxiliar0 
	 SELECT Cuentas.IdCuenta, IsNull(CuentasGastos.IdCuentaMadre,-1)
	 FROM Cuentas 
	 LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto
	 WHERE IsNull(CuentasGastos.IdCuentaMadre,-1)=@IdCuentaImpuestosInternos or Patindex('%('+Convert(varchar,IsNull(CuentasGastos.IdCuentaMadre,-1))+')%', @IdCuentasAdicionalesImpuestosInternos)<>0


CREATE TABLE #Auxiliar1
			(
			 A_IdComprobante INTEGER,
			 A_Coeficiente INTEGER,
			 A_IdObra INTEGER,
			 A_IdCuenta INTEGER,
			 A_NetoNoGravado NUMERIC(18, 3),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 3),
			 A_NetoNoGravadoImpInt NUMERIC(18, 3),
			 A_NetoGravado NUMERIC(18, 3),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 4),
			 A_IdCondicionIVA INTEGER,
			 A_CtaAdicCol1 NUMERIC(18, 3),
			 A_CtaAdicCol2 NUMERIC(18, 3),
			 A_CtaAdicCol3 NUMERIC(18, 3),
			 A_CtaAdicCol4 NUMERIC(18, 3),
			 A_CtaAdicCol5 NUMERIC(18, 3),
			 A_NetoGravadoPorTasa NUMERIC(18, 3),
			 A_Total NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and 
					 (cp.Letra='C' or 
					  (dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0) and IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva)=1 and 
						Exists(Select Top 1 dcp1.IdCuenta From DetalleComprobantesProveedores dcp1 
								Where dcp1.IdComprobanteProveedor=dcp.IdComprobanteProveedor and dcp1.IdCuenta=dcp.IdCuenta and dcp1.IdDetalleComprobanteProveedor<>dcp.IdDetalleComprobanteProveedor))))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3)
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
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
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	0,
	0,
	0,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		((IsNull(dcp.ImporteIVA1,0)=0 and IsNull(dcp.ImporteIVA2,0)=0 and IsNull(dcp.ImporteIVA3,0)=0 and IsNull(dcp.ImporteIVA4,0)=0 and 
		  IsNull(dcp.ImporteIVA5,0)=0 and IsNull(dcp.ImporteIVA6,0)=0 and IsNull(dcp.ImporteIVA7,0)=0 and IsNull(dcp.ImporteIVA8,0)=0 and 
		  IsNull(dcp.ImporteIVA9,0)=0 and IsNull(dcp.ImporteIVA10,0)=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')) and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		not ((dcp.IdCuenta=@IdCtaAdicCol1 or dcp.IdCuenta=@IdCtaAdicCol2 or 
			 dcp.IdCuenta=@IdCtaAdicCol3 or dcp.IdCuenta=@IdCtaAdicCol4 or 
			 dcp.IdCuenta=@IdCtaAdicCol5) and IsNull(dcp.IVAComprasPorcentajeDirecto,0)<>0) and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir)

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje1,
	Round(dcp.ImporteIVA1*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3), 
	Round((dcp.Importe+dcp.ImporteIVA1)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA1<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje2,
	Round(dcp.ImporteIVA2*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3), 
	Round((dcp.Importe+dcp.ImporteIVA2)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA2<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje3,
	Round(dcp.ImporteIVA3*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3), 
	Round((dcp.Importe+dcp.ImporteIVA3)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA3<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje4,
	Round(dcp.ImporteIVA4*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	Round((dcp.Importe+dcp.ImporteIVA4)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA4<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
				dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje5,
	Round(dcp.ImporteIVA5*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	Round((dcp.Importe+dcp.ImporteIVA5)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA5<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje6,
	Round(dcp.ImporteIVA6*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	Round((dcp.Importe+dcp.ImporteIVA6)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA6<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje7,
	Round(dcp.ImporteIVA7*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	Round((dcp.Importe+dcp.ImporteIVA7)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA7<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje8,
	Round(dcp.ImporteIVA8*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3), 
	Round((dcp.Importe+dcp.ImporteIVA8)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA8<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje9,
	Round(dcp.ImporteIVA9*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	Round((dcp.Importe+dcp.ImporteIVA9)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA9<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	dcp.IVAComprasPorcentaje10,
	Round(dcp.ImporteIVA10*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Round(dcp.Importe*cp.CotizacionMoneda,3), 
	Round((dcp.Importe+dcp.ImporteIVA10)*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		dcp.ImporteIVA10<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	Case When dcp.IVAComprasPorcentajeDirecto is not null 
		Then dcp.IVAComprasPorcentajeDirecto
		Else 0
	End,
	Round(dcp.Importe*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 and IsNull(dcp.IVAComprasPorcentajeDirecto,0)=0
		Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3)
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
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	Case When dcp.IdObra is not null Then dcp.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		When cp.IdObra is not null Then cp.IdObra
		Else Null
	End,
	dcp.IdCuenta,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 and 
				not (@IvaCompras_DesglosarNOGRAVADOS='SI' and (cp.Letra='C' or dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)))
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and cp.Letra='C'
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 and 
			@IvaCompras_DesglosarNOGRAVADOS='SI' and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta<>@IdCtaAdicCol1 and 
				dcp.IdCuenta<>@IdCtaAdicCol2 and dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When (dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
						dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0) or (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')
				 Then 0
				 Else Round(dcp.Importe*cp.CotizacionMoneda,3) 
			End
		Else 0
	End,
	IsNull(dcp.IVAComprasPorcentajeDirecto,0),
	0,
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	Case When dcp.IdCuenta=@IdCtaAdicCol1 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol2 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol3 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol4 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	Case When dcp.IdCuenta=@IdCtaAdicCol5 Then dcp.Importe*cp.CotizacionMoneda Else 0 End,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		(Cuentas.IdTipoCuentaGrupo is not null and Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA) and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(dcp.IdCuenta=@IdCtaAdicCol1 or dcp.IdCuenta=@IdCtaAdicCol2 or 
		 dcp.IdCuenta=@IdCtaAdicCol3 or dcp.IdCuenta=@IdCtaAdicCol4 or 
		 dcp.IdCuenta=@IdCtaAdicCol5) and IsNull(dcp.IVAComprasPorcentajeDirecto,0)<>0 and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

 UNION ALL

 SELECT 
	cp.IdComprobanteProveedor,
	Case When TiposComprobante.Coeficiente is not null 
		Then TiposComprobante.Coeficiente
		Else 1
	End,
	cp.IdObra,
	@IdCtaAdicCol1,
	0,
	0,
	0,
	0,
	Case When cp.PorcentajeIVAAplicacionAjuste is not null 
		Then cp.PorcentajeIVAAplicacionAjuste
		Else 0
	End,
	Round(cp.AjusteIVA*cp.CotizacionMoneda,4),
	IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva),
	0,
	0,
	0,
	0,
	0,
	0,
	Round(cp.AjusteIVA*cp.CotizacionMoneda,3)
 FROM ComprobantesProveedores cp 
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		/* not (cp.IdProveedor is null and cp.TotalIva1=0) and */
		cp.AjusteIVA is not null and cp.AjusteIVA<>0 and 
		(cp.Confirmado is null or cp.Confirmado<>'NO') and 
		(@IdComprobanteAEmitir=-1 or cp.IdComprobanteProveedor=@IdComprobanteAEmitir) and 
		Not (cp.Letra='B' and IsNull(Proveedores.ResolucionAfip3668,'')='SI')

CREATE TABLE #Auxiliar2 
			(
			 A_IdComprobante INTEGER,
			 A_IdObra INTEGER,
			 A_IdCuenta INTEGER,
			 A_NetoNoGravado NUMERIC(18, 3),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 3),
			 A_NetoNoGravadoImpInt NUMERIC(18, 3),
			 A_NetoGravado NUMERIC(18, 3),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 4),
			 A_IdCondicionIVA INTEGER,
			 A_CtaAdicCol1 NUMERIC(18, 3),
			 A_CtaAdicCol2 NUMERIC(18, 3),
			 A_CtaAdicCol3 NUMERIC(18, 3),
			 A_CtaAdicCol4 NUMERIC(18, 3),
			 A_CtaAdicCol5 NUMERIC(18, 3),
			 A_NetoGravadoPorTasa NUMERIC(18, 3),
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
	#Auxiliar1.A_IdComprobante,
	#Auxiliar1.A_IdObra,
	#Auxiliar1.A_IdCuenta,
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
	SUM(#Auxiliar1.A_NetoGravadoPorTasa*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_Total*#Auxiliar1.A_Coeficiente)
 FROM #Auxiliar1 LEFT OUTER JOIN ComprobantesProveedores cp ON #Auxiliar1.A_IdComprobante = cp.IdComprobanteProveedor
 GROUP BY #Auxiliar1.A_IdComprobante, #Auxiliar1.A_Tasa, #Auxiliar1.A_IdObra, #Auxiliar1.A_IdCuenta


-- BUSCAR DIFERENCIAS DE CENTAVOS ENTRE LOS TOTALES POR COMPROBANTE Y EL DESGLOSE POR OBRA CUENTA 
CREATE TABLE #Auxiliar22 
			(
			 A_IdComprobante INTEGER,
			 A_NetoNoGravado NUMERIC(18, 3),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 3),
			 A_NetoNoGravadoImpInt NUMERIC(18, 3),
			 A_NetoGravado NUMERIC(18, 3),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 4),
			 A_CtaAdicCol1 NUMERIC(18, 3),
			 A_CtaAdicCol2 NUMERIC(18, 3),
			 A_CtaAdicCol3 NUMERIC(18, 3),
			 A_CtaAdicCol4 NUMERIC(18, 3),
			 A_CtaAdicCol5 NUMERIC(18, 3),
			 A_NetoGravadoPorTasa NUMERIC(18, 3)
			)
INSERT INTO #Auxiliar22 
 SELECT 
	#Auxiliar1.A_IdComprobante,
	SUM(#Auxiliar1.A_NetoNoGravado*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_NetoNoGravadoComprobantesC*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_NetoNoGravadoImpInt*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_NetoGravado*#Auxiliar1.A_Coeficiente),
	#Auxiliar1.A_Tasa,
	SUM(#Auxiliar1.A_IVA*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol1*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol2*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol3*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol4*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_CtaAdicCol5*#Auxiliar1.A_Coeficiente),
	SUM(#Auxiliar1.A_NetoGravadoPorTasa*#Auxiliar1.A_Coeficiente)
 FROM #Auxiliar1 GROUP BY #Auxiliar1.A_IdComprobante,#Auxiliar1.A_Tasa

CREATE TABLE #Auxiliar3 
			(
			 A_IdComprobante INTEGER,
			 A_NetoGravado NUMERIC(18, 3),
			 A_IVA NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT 
	#Auxiliar22.A_IdComprobante,
	SUM(#Auxiliar22.A_NetoGravado),
	SUM(Round(#Auxiliar22.A_IVA-0.000001,2)),
	SUM(#Auxiliar22.A_NetoNoGravado+#Auxiliar22.A_NetoNoGravadoComprobantesC+
		#Auxiliar22.A_NetoNoGravadoImpInt+#Auxiliar22.A_NetoGravado+#Auxiliar22.A_IVA+
		#Auxiliar22.A_CtaAdicCol1+#Auxiliar22.A_CtaAdicCol2+#Auxiliar22.A_CtaAdicCol3+
		#Auxiliar22.A_CtaAdicCol4+#Auxiliar22.A_CtaAdicCol5)
 FROM #Auxiliar22
 GROUP BY #Auxiliar22.A_IdComprobante

CREATE TABLE #Auxiliar10 
			(
			 A_IdComprobante INTEGER,
			 A_NetoGravado1 NUMERIC(18, 3),
			 A_IVA1 NUMERIC(18, 2),
			 A_Total1 NUMERIC(18, 2),
			 A_NetoGravado2 NUMERIC(18, 3),
			 A_IVA2 NUMERIC(18, 2),
			 A_Total2 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar10 
 SELECT 
	#Auxiliar3.A_IdComprobante,
	SUM(#Auxiliar3.A_NetoGravado),
	SUM(#Auxiliar3.A_IVA),
	SUM(#Auxiliar3.A_Total),
	0, 0, 0
 FROM #Auxiliar3 GROUP BY #Auxiliar3.A_IdComprobante

 UNION ALL

 SELECT 
	#Auxiliar2.A_IdComprobante,
	0, 0, 0, 
	SUM(#Auxiliar2.A_NetoGravado),
	SUM(Round(#Auxiliar2.A_IVA-0.000001,2)),
	SUM(#Auxiliar2.A_Total)
 FROM #Auxiliar2 GROUP BY #Auxiliar2.A_IdComprobante

CREATE TABLE #Auxiliar11 
			(
			 A_IdComprobante INTEGER,
			 A_NetoGravado1 NUMERIC(18, 3),
			 A_IVA1 NUMERIC(18, 4),
			 A_Total1 NUMERIC(18, 2),
			 A_NetoGravado2 NUMERIC(18, 3),
			 A_IVA2 NUMERIC(18, 4),
			 A_Total2 NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (A_IdComprobante) ON [PRIMARY]
INSERT INTO #Auxiliar11 
 SELECT 
	#Auxiliar10.A_IdComprobante,
	SUM(#Auxiliar10.A_NetoGravado1),
	SUM(#Auxiliar10.A_IVA1),
	SUM(#Auxiliar10.A_Total1),
	SUM(#Auxiliar10.A_NetoGravado2),
	SUM(#Auxiliar10.A_IVA2),
	SUM(#Auxiliar10.A_Total2)
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.A_IdComprobante

DELETE #Auxiliar11 
WHERE A_NetoGravado1=A_NetoGravado2 and A_IVA1=A_IVA2 and A_Total1=A_Total2

/*  CURSOR  */
DECLARE @A_IdComprobante int, @A_IVA1 numeric(18,4), @A_Total1 numeric(18,2), @A_IVA2 numeric(18,4), 
	@A_Total2 numeric(18,2), @A_IdObra int, @A_IdCuenta int, @A_Tasa numeric(18,2), 
	@A_NetoGravado1 numeric(18,2), @A_NetoGravado2 numeric(18,2)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT A_IdComprobante, A_NetoGravado1, A_IVA1, A_Total1, A_NetoGravado2, A_IVA2, A_Total2
		FROM #Auxiliar11
		ORDER BY A_IdComprobante
OPEN Cur
FETCH NEXT FROM Cur INTO @A_IdComprobante, @A_NetoGravado1, @A_IVA1, @A_Total1, 
			 @A_NetoGravado2, @A_IVA2, @A_Total2
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @A_IdObra=IsNull((Select top 1 A_IdObra From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_IVA,0)<>0),0)
	SET @A_IdCuenta=IsNull((Select top 1 A_IdCuenta From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_IVA,0)<>0),0)
	SET @A_Tasa=IsNull((Select top 1 A_Tasa From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_IVA,0)<>0),0)
	UPDATE #Auxiliar2
	SET A_IVA = A_IVA+(@A_IVA1-@A_IVA2)
	WHERE A_IdComprobante=@A_IdComprobante and A_IdObra=@A_IdObra and A_IdCuenta=@A_IdCuenta and 
		A_Tasa=@A_Tasa and (@A_IVA1-@A_IVA2)<>0 and IsNull(A_IVA,0)<>0

	SET @A_IdObra=IsNull((Select top 1 A_IdObra From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_Total,0)<>0),0)
	SET @A_IdCuenta=IsNull((Select top 1 A_IdCuenta From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_Total,0)<>0),0)
	SET @A_Tasa=IsNull((Select top 1 A_Tasa From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_Total,0)<>0),0)
	UPDATE #Auxiliar2
	SET A_Total = A_Total+(@A_Total1-@A_Total2)
	WHERE A_IdComprobante=@A_IdComprobante and A_IdObra=@A_IdObra and A_IdCuenta=@A_IdCuenta and 
		A_Tasa=@A_Tasa and (@A_Total1-@A_Total2)<>0 and IsNull(A_Total,0)<>0

	SET @A_IdObra=IsNull((Select top 1 A_IdObra From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_NetoGravado,0)<>0),0)
	SET @A_IdCuenta=IsNull((Select top 1 A_IdCuenta From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_NetoGravado,0)<>0),0)
	SET @A_Tasa=IsNull((Select top 1 A_Tasa From #Auxiliar2 
				Where A_IdComprobante=@A_IdComprobante and IsNull(A_NetoGravado,0)<>0),0)
	UPDATE #Auxiliar2
	SET A_NetoGravado = A_NetoGravado+(@A_NetoGravado1-@A_NetoGravado2)
	WHERE A_IdComprobante=@A_IdComprobante and A_IdObra=@A_IdObra and A_IdCuenta=@A_IdCuenta and 
		A_Tasa=@A_Tasa and (@A_NetoGravado1-@A_NetoGravado2)<>0 and IsNull(A_NetoGravado,0)<>0
	FETCH NEXT FROM Cur INTO @A_IdComprobante, @A_NetoGravado1, @A_IVA1, @A_Total1, 
				 @A_NetoGravado2, @A_IVA2, @A_Total2
   END
CLOSE Cur
DEALLOCATE Cur
-- FIN

CREATE TABLE #Auxiliar 
			(
			 A_IdComprobante INTEGER,
			 A_KTipoComprobante VARCHAR(6),
			 A_KTipoComprobante1 VARCHAR(2),
			 A_IdObra INTEGER,
			 A_IdCuenta INTEGER,
			 A_BienesOServicios VARCHAR(10),
			 A_Fecha DATETIME,
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
	'1'+TiposComprobante.DescripcionAb,
	'CP',
	#Auxiliar2.A_IdObra,
	#Auxiliar2.A_IdCuenta,
	Case When IsNull(cp.BienesOServicios,'S')='B' Then 'Bienes' Else 'Servicios' End,
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
	Case When cp.IdProveedor is not null
		Then Proveedores.Cuit
		Else (Select Top 1 P.Cuit From Proveedores P
			Where P.IdProveedor=cp.IdProveedorEventual)
	End,
	#Auxiliar2.A_NetoNoGravado,
	#Auxiliar2.A_NetoNoGravadoComprobantesC,
	#Auxiliar2.A_NetoNoGravadoImpInt,
	#Auxiliar2.A_NetoGravado,
	#Auxiliar2.A_Tasa,
	Round(#Auxiliar2.A_IVA-0.000001,2),
	#Auxiliar2.A_Total,
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
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=#Auxiliar2.A_IdCondicionIVA
 WHERE (TiposComprobante.VaAlLibro='SI' or TiposComprobante.VaAlLibro is null) and 
		(cp.FechaRecepcion between @Desde and @hasta) and 
		(cp.Confirmado is null or cp.Confirmado<>'NO')
 UNION ALL 

 SELECT 
	das.IdDetalleAsiento,
	'5AS',
	'AS',
	Case When das.IdObra is not null Then das.IdObra
		When Cuentas.IdObra is not null Then Cuentas.IdObra
		Else Null
	End,
	das.IdCuenta,
	'Servicios',
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
	Asientos.IdCuentaSubdiario is null and das.Libro='C' and das.TipoImporte='I' and 
	@IdComprobanteAEmitir=-1

 UNION ALL 

 SELECT 
	Valores.IdValor,
	'1'+TiposComprobante.DescripcionAb,
	'VA',
	Valores.IdObra,
	@IdCtaAdicCol1,
	'Servicios',
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
	(Valores.FechaComprobante between @Desde and @hasta) and (Valores.Estado='G' or Valores.Estado='T') and 
	Valores.Iva is not null and Valores.Iva<>0 and 
	@IdComprobanteAEmitir=-1

UNION ALL 

 SELECT 
	drc.IdDetalleReciboCuentas,
	'5RE',
	'RE',
	Recibos.IdObra,
	drc.IdCuenta,
	'Servicios',
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
	(IsNull(drc.Debe,0)-IsNull(drc.Haber,0))* IsNull(Recibos.CotizacionMoneda,1),
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
	Null FROM DetalleRecibosCuentas drc 
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=drc.IdRecibo
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Recibos.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=drc.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and DATEADD(n,1439,@hasta) and IsNull(Recibos.Anulado,'NO')<>'SI' and 
	(IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol1 or IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol2 or 
	 IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol3 or IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol4 or 
	 IsNull(drc.IdCuenta,-1)=@IdCtaAdicCol5 ) and 
	@IdComprobanteAEmitir=-1

UNION ALL 

 SELECT 
	dopc.IdDetalleOrdenPagoCuentas,
	'6OP',
	'OP',
	OrdenesPago.IdObra,
	dopc.IdCuenta,
	'Servicios',
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
	(IsNull(dopc.Debe,0)-IsNull(dopc.Haber,0))* IsNull(OrdenesPago.CotizacionMoneda,1) * -1,
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
	 IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol5 ) and 
	IsNull(dopc.Haber,0)<>0 and 
	@IdComprobanteAEmitir=-1

-- Ajustar hasta +- 0.01 de diferencia con el total del comprobante contra el gravado 
-- en comprobantes No en pesos
CREATE TABLE #Auxiliar8 
			(
			 A_IdComprobante INTEGER,
			 A_IdObra INTEGER,
			 A_IdCuenta INTEGER,
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoComprobantesC NUMERIC(18, 2),
			 A_NetoNoGravadoImpInt NUMERIC(18, 2),
			 A_NetoGravado NUMERIC(18, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2),
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2),
			 A_Diferencia NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar8 
 SELECT #Auxiliar.A_IdComprobante, 0, 0, 
	Sum(IsNull(#Auxiliar.A_NetoNoGravado,0)), 
	Sum(IsNull(#Auxiliar.A_NetoNoGravadoComprobantesC,0)), 
	Sum(IsNull(#Auxiliar.A_NetoNoGravadoImpInt,0)), 
	Sum(IsNull(#Auxiliar.A_NetoGravado,0)), Sum(IsNull(#Auxiliar.A_Iva,0)), 
	Sum(IsNull(#Auxiliar.A_Total,0)), Sum(IsNull(#Auxiliar.A_CtaAdicCol1,0)), 
	Sum(IsNull(#Auxiliar.A_CtaAdicCol2,0)), Sum(IsNull(#Auxiliar.A_CtaAdicCol3,0)), 
	Sum(IsNull(#Auxiliar.A_CtaAdicCol4,0)), Sum(IsNull(#Auxiliar.A_CtaAdicCol5,0)), 0
 FROM #Auxiliar
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = #Auxiliar.A_IdComprobante
 WHERE #Auxiliar.A_KTipoComprobante1='CP' and cp.IdMoneda<>1
 GROUP BY #Auxiliar.A_IdComprobante --, #Auxiliar.A_IdObra, #Auxiliar.A_IdCuenta

UPDATE #Auxiliar8
SET A_Diferencia=(A_Total-(A_NetoNoGravado+A_NetoNoGravadoComprobantesC+
				A_NetoNoGravadoImpInt+A_NetoGravado+A_IVA+A_CtaAdicCol1+
				A_CtaAdicCol2+A_CtaAdicCol3+A_CtaAdicCol4+A_CtaAdicCol5))

UPDATE #Auxiliar8
SET A_IdObra=IsNull((Select top 1 A_IdObra From #Auxiliar 
			Where A_IdComprobante=#Auxiliar8.A_IdComprobante and IsNull(A_NetoGravado,0)<>0),0), 
	A_IdCuenta=IsNull((Select top 1 A_IdCuenta From #Auxiliar 
				Where A_IdComprobante=#Auxiliar8.A_IdComprobante and IsNull(A_NetoGravado,0)<>0),0)
WHERE A_Diferencia<>0

UPDATE #Auxiliar
SET A_NetoGravado=A_NetoGravado+IsNull((Select Top 1 A_Diferencia From #Auxiliar8 
					Where #Auxiliar.A_IdComprobante=#Auxiliar8.A_IdComprobante and 
						#Auxiliar.A_IdObra=#Auxiliar8.A_IdObra and 
						#Auxiliar.A_IdCuenta=#Auxiliar8.A_IdCuenta and 
						#Auxiliar8.A_Diferencia<>0),0)
WHERE IsNull(#Auxiliar.A_NetoGravado,0)<>0

UPDATE #Auxiliar2
SET A_NetoGravadoPorTasa=A_NetoGravadoPorTasa+IsNull((Select Top 1 A_Diferencia From #Auxiliar8 
							Where #Auxiliar2.A_IdComprobante=#Auxiliar8.A_IdComprobante and 
								#Auxiliar2.A_IdObra=#Auxiliar8.A_IdObra and 
								#Auxiliar2.A_IdCuenta=#Auxiliar8.A_IdCuenta and 
								#Auxiliar8.A_Diferencia<>0),0)
WHERE IsNull(#Auxiliar2.A_NetoGravadoPorTasa,0)<>0

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
	SUM(Round(#Auxiliar2.A_IVA-0.000001,2)),
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
SET A_Condicion='Otros'WHERE A_Condicion IS NULL

CREATE TABLE #Auxiliar7	
			(
			 A_IdCuenta INTEGER,
			 A_Codigo INTEGER,
			 A_Descripcion VARCHAR(50),
			 A_NombreAnterior VARCHAR(50),
			 A_CodigoAnterior INTEGER
			)
INSERT INTO #Auxiliar7 
 SELECT 
  Cuentas.IdCuenta,
  Cuentas.Codigo,
  Cuentas.Descripcion,
  (Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@Hasta 
	Order By dc.FechaCambio),
  (Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@Hasta 
	Order By dc.FechaCambio)
 FROM Cuentas 

SET NOCOUNT OFF

Declare @vector_X varchar(50),@vector_T varchar(50),@vector_E varchar(500)
Set @vector_X='001111111111666666'
Set @vector_T='001449302222222333'
Set @vector_E=' FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 | FON:8 |'

IF @IdCuentaAdicionalIVACompras1<>0
   BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
   END
ELSE
   BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
   END
IF @IdCuentaAdicionalIVACompras2<>0
   BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
   END
ELSE
   BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
   END
IF @IdCuentaAdicionalIVACompras3<>0
   BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
   END
ELSE
   BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
   END
IF @IdCuentaAdicionalIVACompras4<>0
   BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
   END
ELSE
   BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
   END
IF @IdCuentaAdicionalIVACompras5<>0
   BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
   END
ELSE
   BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
   END
SET @vector_X=@vector_X+'6133'
SET @vector_T=@vector_T+'3900'

SELECT 
	A_IdComprobante as [A_IdComprobante],
	'1' as [Orden],
	A_Proveedor as [Proveedor],
	A_Fecha as [Fecha],
	A_FechaComprobante as [Fec.Comp.],
	A_TipoComprobante as [Tipo],
	A_Comprobante as [Comprobante],
	A_CondicionIVA as [Condicion],
	A_BienesOServicios as [B/S],
	IsNull(#Auxiliar7.A_CodigoAnterior,#Auxiliar7.A_Codigo) as [Codigo],
	IsNull(#Auxiliar7.A_NombreAnterior,#Auxiliar7.A_Descripcion) as [Cuenta],
	Obras.Descripcion as [Obra],
	A_NetoNoGravado as [No Gravados],
	A_NetoNoGravadoComprobantesC as [No Grav.Comp.C],
	A_NetoNoGravadoImpInt as [No Grav.Imp.Int.],
	A_NetoGravado as [Gravados],
	Case When A_Tasa<>0 Then A_Tasa Else Null End as [Tasa],
	Case When A_Iva<>0 Then A_Iva Else Null End as [Iva],
	A_CtaAdicCol1 as [Col1],
	A_CtaAdicCol2 as [Col2],
	A_CtaAdicCol3 as [Col3],
	A_CtaAdicCol4 as [Col4],
	A_CtaAdicCol5 as [Col5],
	A_Total as [Total],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar.A_IdObra
LEFT OUTER JOIN #Auxiliar7 ON #Auxiliar7.A_IdCuenta=#Auxiliar.A_IdCuenta

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	'2' as [Orden],
	Null as [Proveedor],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Tipo],
	Null as [Comprobante],
	Null as [Condicion],
	Null as [B/S],
	Null as [Codigo],
	Null as [Cuenta],
	Null as [Obra],
	Null as [No Gravados],
	Null as [No Grav.Comp.C],
	Null as [No Grav.Imp.Int.],
	Null as [Gravados],
	Null as [Tasa],
	Null as [Iva],
	Null as [Col1],
	Null as [Col2],
	Null as [Col3],
	Null as [Col4],
	Null as [Col5],
	Null as [Total],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	'3' as [Orden],
	'TOTALES GENERALES' as [Proveedor],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Tipo],
	Null as [Comprobante],
	Null as [Condicion],
	Null as [B/S],
	Null as [Codigo],
	Null as [Cuenta],
	Null as [Obra],
	SUM(IsNull(A_NetoNoGravado,0)) as [No Gravados],
	SUM(IsNull(A_NetoNoGravadoComprobantesC,0)) as [No Grav.Comp.C],
	SUM(IsNull(A_NetoNoGravadoImpInt,0)) as [No Grav.Imp.Int.],
	SUM(IsNull(A_NetoGravado,0)) as [Gravados],
	Null as [Tasa],
	SUM(IsNull(A_Iva,0)) as [Iva],
	SUM(IsNull(A_CtaAdicCol1,0)) as [Col1],
	SUM(IsNull(A_CtaAdicCol2,0)) as [Col2],
	SUM(IsNull(A_CtaAdicCol3,0)) as [Col3],
	SUM(IsNull(A_CtaAdicCol4,0)) as [Col4],
	SUM(IsNull(A_CtaAdicCol5,0)) as [Col5],
	SUM(IsNull(A_Total,0)) as [Total],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	'4' as [Orden],
	Null as [Proveedor],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Tipo],
	Null as [Comprobante],
	Null as [Condicion],
	Null as [B/S],
	Null as [Codigo],
	Null as [Cuenta],
	Null as [Obra],
	Null as [No Gravados],
	Null as [No Grav.Comp.C],
	Null as [No Grav.Imp.Int.],
	Null as [Gravados],
	Null as [Tasa],
	Null as [Iva],
	Null as [Col1],
	Null as [Col2],
	Null as [Col3],
	Null as [Col4],
	Null as [Col5],
	Null as [Total],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	'5' as [Orden],
	Null as [Proveedor],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Tipo],
	Null as [Comprobante],
	Null as [B/S],
	Null as [Codigo],
	Null as [Cuenta],
	Null as [Obra],
	'Total tasa '+Convert(varchar,A_Tasa)+' %' as [Condicion],
	Null as [No Gravados],
	Null as [No Grav.Comp.C],
	Null as [No Grav.Imp.Int.],
	SUM(IsNull(A_NetoGravadoPorTasa,0)) as [Gravados],
	Null as [Tasa],
	SUM(IsNull(A_Iva,0)) as [Iva],
	SUM(IsNull(A_CtaAdicCol1,0)) as [Col1],
	SUM(IsNull(A_CtaAdicCol2,0)) as [Col2],
	SUM(IsNull(A_CtaAdicCol3,0)) as [Col3],
	SUM(IsNull(A_CtaAdicCol4,0)) as [Col4],
	SUM(IsNull(A_CtaAdicCol5,0)) as [Col5],
	Null as [Total],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar41
GROUP BY #Auxiliar41.A_Tasa

UNION ALL 

SELECT 
	0 as [A_IdComprobante],
	'6' as [Orden],
	Null as [Proveedor],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Tipo],
	Null as [Comprobante],
	Null as [Condicion],
	Null as [B/S],
	Null as [Codigo],
	Null as [Cuenta],
	Null as [Obra],
	Null as [No Gravados],
	Null as [No Grav.Comp.C],
	Null as [No Grav.Imp.Int.],
	Null as [Gravados],
	Null as [Tasa],
	Null as [Iva],
	Null as [Col1],	Null as [Col2],
	Null as [Col3],
	Null as [Col4],
	Null as [Col5],
	Null as [Total],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X

UNION ALL 

SELECT 

	0 as [A_IdComprobante],
	'7' as [Orden],
	Null as [Proveedor],
	Null as [Fecha],
	Null as [Fec.Comp.],
	Null as [Tipo],
	Null as [Comprobante],
	'Total '+A_Condicion as [Condicion],
	Null as [B/S],
	Null as [Codigo],
	Null as [Cuenta],
	Null as [Obra],
	A_NetoNoGravado as [No Gravados],
	A_NetoNoGravadoComprobantesC as [No Grav.Comp.C],
	A_NetoNoGravadoImpInt as [No Grav.Imp.Int.],
	A_NetoGravado as [Gravados],
	Null as [Tasa],
	Case When A_Iva<>0 Then A_Iva Else Null End as [Iva],
	Null as [Col1],
	Null as [Col2],
	Null as [Col3],
	Null as [Col4],
	Null as [Col5],
	Null as [Total],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar6

ORDER BY [Orden], [Fecha], [Comprobante], [A_IdComprobante], [Tasa], [Fec.Comp.]

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar22
DROP TABLE #Auxiliar41