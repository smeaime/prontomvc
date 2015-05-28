
CREATE procedure [dbo].[REP_CTAPRO_SEL]

AS

DECLARE @IdTipoCuentaGrupoIVA int,@IdMonedaPesos int,@IdCuentaPercepcionIVACompras int
SET @IdTipoCuentaGrupoIVA=IsNull((Select Parametros.IdTipoCuentaGrupoIVA
				  From Parametros Where Parametros.IdParametro=1),0)
SET @IdMonedaPesos=IsNull((Select Parametros.IdMoneda
				  From Parametros Where Parametros.IdParametro=1),0)
SET @IdCuentaPercepcionIVACompras=IsNull((Select Parametros.IdCuentaPercepcionIVACompras
				  		From Parametros Where Parametros.IdParametro=1),0)

Select 
	cp.idcomprobanteproveedor,
	cp.REP_CTAPRO_INS as [REP_CTAPRO_INS],
	IsNull((Select Top 1 Prov.CodigoEmpresa 
		From Proveedores Prov 
		Where Prov.IdProveedor=cp.IdProveedor),'') as [PROVEEDOR],
	Substring('000000000000',1,12-Len(Convert(varchar,cp.NumeroReferencia)))+
		Convert(varchar,cp.NumeroReferencia) as [CABEZA],
	IsNull(cp.InformacionAuxiliar,(Select Top 1 TP.InformacionAuxiliar 
					From TiposComprobante TP 
					Where TP.IdTipoComprobante=cp.IdTipoComprobante)) as [CODCABEZA],
	cp.Letra as [LETRA],
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2) as [NROREAL],
	IsNull((Select Top 1 CC.CodigoCondicion 
		From [Condiciones Compra] CC 
		Where CC.IdCondicionCompra=cp.IdCondicionCompra),'') as [CONDCOMPRA],
	Case When cp.IdMoneda=@IdMonedaPesos Then 'L' Else 'E' End as [MONEDAIMP],
	cp.FechaRecepcion as [FECCONTAB],
	cp.FechaComprobante as [FECEMISION],
	cp.FechaVencimiento as [FECVENC],

	cp.TotalComprobante * cp.CotizacionMoneda as [TOTALML],
	IsNull((Select Sum(Case When dcp.ImporteIVA1<>0	Then dcp.Importe Else 0	End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor),0) * cp.CotizacionMoneda as [GRAVT1ML],
	IsNull((Select Sum(
			Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
					dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				Then dcp.Importe
				Else 0
			End)
		From DetalleComprobantesProveedores dcp 
		Left Outer Join Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			Not Exists(Select Top 1 Pc.IdCuentaPercepcionIBrutos
					From Provincias Pc
					Where IsNull(Pc.IdCuentaPercepcionIBrutos,0)=dcp.IdCuenta)),0) * 
		cp.CotizacionMoneda as [NOGRAVT1ML],
	IsNull((Select Sum(Case When IsNull(dcp.IdCuentaIvaCompras1,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA1 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			IsNull(	Case When cp.IdCodigoIva is not null Then cp.IdCodigoIva
					When Prov.IdCodigoIva is not null Then Prov.IdCodigoIva
					When cp.IdProveedorEventual is not null 
						Then (Select Top 1 P.IdCodigoIva From Proveedores P
							Where P.IdProveedor=cp.IdProveedorEventual)
				End ,0)=1),0) * cp.CotizacionMoneda as [IVAT1ML],
	IsNull((Select Sum(Case When IsNull(dcp.IdCuentaIvaCompras1,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA1 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			IsNull(	Case When cp.IdCodigoIva is not null Then cp.IdCodigoIva
					When Prov.IdCodigoIva is not null Then Prov.IdCodigoIva
					When cp.IdProveedorEventual is not null 
						Then (Select Top 1 P.IdCodigoIva From Proveedores P
							Where P.IdProveedor=cp.IdProveedorEventual)
				End ,0)<>1),0) * cp.CotizacionMoneda as [IVANOIT1ML],
	IsNull((Select Sum(
			Case When dcp.ImporteIVA1=0 and 
					(dcp.ImporteIVA2<>0 or dcp.ImporteIVA3<>0 or dcp.ImporteIVA4<>0 or 
					 dcp.ImporteIVA5<>0 or dcp.ImporteIVA6<>0 or dcp.ImporteIVA7<>0 or 
					 dcp.ImporteIVA8<>0 or dcp.ImporteIVA9<>0 or dcp.ImporteIVA10<>0)
				Then dcp.Importe 
				Else 0 
			End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor),0) * 
		cp.CotizacionMoneda as [GRAVT2ML],
	IsNull((Select Sum(
			Case When Cuentas.IdTipoCuentaGrupo is not null and 
					Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA and 
					dcp.IdCuenta<>@IdCuentaPercepcionIVACompras
				Then dcp.Importe
				Else 0
			End + 
			Case When IsNull(dcp.IdCuentaIvaCompras2,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA2 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras3,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA3 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras4,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA4 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras5,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA5 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras6,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA6 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras7,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA7 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras8,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA8 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras9,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA9 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras10,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA10 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Left Outer Join Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			IsNull(	Case When cp.IdCodigoIva is not null Then cp.IdCodigoIva
					When Prov.IdCodigoIva is not null Then Prov.IdCodigoIva
					When cp.IdProveedorEventual is not null 
						Then (Select Top 1 P.IdCodigoIva From Proveedores P
							Where P.IdProveedor=cp.IdProveedorEventual)
				End ,0)=1),0) * cp.CotizacionMoneda as [IVAT2ML],
	IsNull((Select Sum(
			Case When Cuentas.IdTipoCuentaGrupo is not null and 
					Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA and 
					dcp.IdCuenta<>@IdCuentaPercepcionIVACompras
				Then dcp.Importe
				Else 0
			End + 
			Case When IsNull(dcp.IdCuentaIvaCompras2,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA2 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras3,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA3 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras4,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA4 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras5,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA5 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras6,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA6 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras7,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA7 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras8,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA8 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras9,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA9 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras10,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA10 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Left Outer Join Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			IsNull(	Case When cp.IdCodigoIva is not null Then cp.IdCodigoIva
					When Prov.IdCodigoIva is not null Then Prov.IdCodigoIva
					When cp.IdProveedorEventual is not null 
						Then (Select Top 1 P.IdCodigoIva From Proveedores P
							Where P.IdProveedor=cp.IdProveedorEventual)
				End ,0)<>1),0) * cp.CotizacionMoneda as [IVANOIT2ML],
	IsNull((Select Sum(
			Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
					dcp.ImporteIVA1<>0 or dcp.ImporteIVA2<>0 or dcp.ImporteIVA3<>0 and 
					dcp.ImporteIVA4<>0 or dcp.ImporteIVA5<>0 or dcp.ImporteIVA6<>0 and 
					dcp.ImporteIVA7<>0 or dcp.ImporteIVA8<>0 or dcp.ImporteIVA9<>0 and 
					dcp.ImporteIVA10<>0
				Then dcp.Importe
				Else 0
			End)  
		From DetalleComprobantesProveedores dcp 
		Left Outer Join Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor),0) * 
		cp.CotizacionMoneda as [GRAVGANML],
	IsNull((Select Sum(dcp.Importe)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			Exists(Select Top 1 Pc.IdCuentaPercepcionIBrutos
				From Provincias Pc
				Where IsNull(Pc.IdCuentaPercepcionIBrutos,0)=dcp.IdCuenta)),0) * 
		cp.CotizacionMoneda as [PERCIBML],
	IsNull((Select Sum(Case When @IdCuentaPercepcionIVACompras=dcp.IdCuenta Then dcp.Importe Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras1,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA1 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras2,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA2 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras3,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA3 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras4,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA4 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras5,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA5 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras6,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA6 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras7,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA7 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras8,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA8 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras9,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA9 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras10,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA10 Else 0 End)
  		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor),0) * cp.CotizacionMoneda as [PERCIVAML],
	cp.TotalBonificacion * cp.CotizacionMoneda as [BONIFICML],
	cp.TotalComprobante * cp.CotizacionMoneda as [SALDOML],

	cp.TotalComprobante as [TOTALME],
	IsNull((Select Sum(Case When dcp.ImporteIVA1<>0	Then dcp.Importe Else 0	End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor),0) as [GRAVT1ME],
	IsNull((Select Sum(
			Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
					dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				Then dcp.Importe
				Else 0
			End)
		From DetalleComprobantesProveedores dcp 
		Left Outer Join Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			Not Exists(Select Top 1 Pc.IdCuentaPercepcionIBrutos
					From Provincias Pc
					Where IsNull(Pc.IdCuentaPercepcionIBrutos,0)=dcp.IdCuenta)),0) as [NOGRAVT1ME],
	IsNull((Select Sum(Case When IsNull(dcp.IdCuentaIvaCompras1,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA1 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			IsNull(	Case When cp.IdCodigoIva is not null Then cp.IdCodigoIva
					When Prov.IdCodigoIva is not null Then Prov.IdCodigoIva
					When cp.IdProveedorEventual is not null 
						Then (Select Top 1 P.IdCodigoIva From Proveedores P
							Where P.IdProveedor=cp.IdProveedorEventual)
				End ,0)=1),0) as [IVAT1ME],
	IsNull((Select Sum(Case When IsNull(dcp.IdCuentaIvaCompras1,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA1 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			IsNull(	Case When cp.IdCodigoIva is not null Then cp.IdCodigoIva
					When Prov.IdCodigoIva is not null Then Prov.IdCodigoIva
					When cp.IdProveedorEventual is not null 
						Then (Select Top 1 P.IdCodigoIva From Proveedores P
							Where P.IdProveedor=cp.IdProveedorEventual)
				End ,0)<>1),0) as [IVANOIT1ME],
	IsNull((Select Sum(
			Case When dcp.ImporteIVA1=0 and 
					(dcp.ImporteIVA2<>0 or dcp.ImporteIVA3<>0 or dcp.ImporteIVA4<>0 or 
					 dcp.ImporteIVA5<>0 or dcp.ImporteIVA6<>0 or dcp.ImporteIVA7<>0 or 
					 dcp.ImporteIVA8<>0 or dcp.ImporteIVA9<>0 or dcp.ImporteIVA10<>0)
				Then dcp.Importe 
				Else 0 
			End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor),0) as [GRAVT2ME],
	IsNull((Select Sum(
			Case When Cuentas.IdTipoCuentaGrupo is not null and 
					Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA and 
					dcp.IdCuenta<>@IdCuentaPercepcionIVACompras
				Then dcp.Importe
				Else 0
			End + 
			Case When IsNull(dcp.IdCuentaIvaCompras2,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA2 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras3,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA3 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras4,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA4 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras5,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA5 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras6,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA6 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras7,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA7 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras8,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA8 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras9,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA9 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras10,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA10 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Left Outer Join Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			IsNull(	Case When cp.IdCodigoIva is not null Then cp.IdCodigoIva
					When Prov.IdCodigoIva is not null Then Prov.IdCodigoIva
					When cp.IdProveedorEventual is not null 
						Then (Select Top 1 P.IdCodigoIva From Proveedores P
							Where P.IdProveedor=cp.IdProveedorEventual)
				End ,0)=1),0) as [IVAT2ME],
	IsNull((Select Sum(
			Case When Cuentas.IdTipoCuentaGrupo is not null and 
					Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA and 
					dcp.IdCuenta<>@IdCuentaPercepcionIVACompras
				Then dcp.Importe
				Else 0
			End + 
			Case When IsNull(dcp.IdCuentaIvaCompras2,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA2 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras3,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA3 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras4,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA4 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras5,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA5 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras6,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA6 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras7,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA7 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras8,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA8 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras9,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA9 Else 0 End + 
			Case When IsNull(dcp.IdCuentaIvaCompras10,0)<>@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA10 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Left Outer Join Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			IsNull(	Case When cp.IdCodigoIva is not null Then cp.IdCodigoIva
					When Prov.IdCodigoIva is not null Then Prov.IdCodigoIva
					When cp.IdProveedorEventual is not null 
						Then (Select Top 1 P.IdCodigoIva From Proveedores P
							Where P.IdProveedor=cp.IdProveedorEventual)
				End ,0)<>1),0) as [IVANOIT2ME],
	IsNull((Select Sum(
			Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
					dcp.ImporteIVA1<>0 or dcp.ImporteIVA2<>0 or dcp.ImporteIVA3<>0 and 
					dcp.ImporteIVA4<>0 or dcp.ImporteIVA5<>0 or dcp.ImporteIVA6<>0 and 
					dcp.ImporteIVA7<>0 or dcp.ImporteIVA8<>0 or dcp.ImporteIVA9<>0 and 
					dcp.ImporteIVA10<>0
				Then dcp.Importe
				Else 0
			End)  
		From DetalleComprobantesProveedores dcp 
		Left Outer Join Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor),0) as [GRAVGANME],
	IsNull((Select Sum(dcp.Importe)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			Pcia.IdCuentaPercepcionIBrutos=dcp.IdCuenta),0) as [PERCIBME],
	IsNull((Select Sum(dcp.Importe)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and 
			Exists(Select Top 1 Pc.IdCuentaPercepcionIBrutos
				From Provincias Pc
				Where IsNull(Pc.IdCuentaPercepcionIBrutos,0)=dcp.IdCuenta)),0) as [PERCIBME],
	IsNull((Select Sum(Case When @IdCuentaPercepcionIVACompras=dcp.IdCuenta Then dcp.Importe Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras1,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA1 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras2,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA2 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras3,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA3 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras4,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA4 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras5,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA5 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras6,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA6 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras7,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA7 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras8,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA8 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras9,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA9 Else 0 End + 
			 Case When IsNull(dcp.IdCuentaIvaCompras10,0)=@IdCuentaPercepcionIVACompras Then dcp.ImporteIVA10 Else 0 End)
		From DetalleComprobantesProveedores dcp 
		Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor),0) as [PERCIVAME],
	cp.TotalBonificacion as [BONIFICME],
	cp.TotalComprobante as [SALDOME],
	cp.CotizacionMoneda as [COTIZACION],
	Case When cp.IdProveedor is not null
		Then Prov.RazonSocial
		Else (Select Top 1 P.RazonSocial From Proveedores P
			Where P.IdProveedor=cp.IdProveedorEventual)
	End as [RAZSOCIAL],
	Case When cp.IdProveedor is not null
		Then Prov.CUIT
		Else (Select Top 1 P.CUIT From Proveedores P
			Where P.IdProveedor=cp.IdProveedorEventual)
	End as [CUIT],

	IsNull(trg.InformacionAuxiliar,'0') as [CODRETGAN],
	cp.FechaIngreso as [FECALTA],
	IsNull((Select Top 1 Emp.InformacionAuxiliar
		From Empleados Emp Where Emp.IdEmpleado=cp.IdUsuarioIngreso),0) as [USUARIO],
	cp.FechaModifico as [FECMOD],
	IsNull((Select Top 1 Emp.InformacionAuxiliar
		From Empleados Emp Where Emp.IdEmpleado=cp.IdUsuarioModifico),0) as [USRMOD],
	Case When IsNull(cp.BienesOServicios,'')='B' Then '01'
		When IsNull(cp.BienesOServicios,'')='S' Then '02'
		Else '00'
	End as [OPERACION],

	cp.FechaVencimientoCAI as [VTOCAI],
	cp.NumeroCAI as [CAI],
	cp.Observaciones as [CONCEPTO],
	cp.NumeroDespacho as [DESPACHO],
	IsNull((Select Top 1 ca.Codigo
		From CodigosAduana ca Where ca.IdCodigoAduana=cp.IdCodigoAduana),0) as [ADUANA],
	cp.FechaDespachoAPlaza as [FECHADESP],
	IsNull((Select Top 1 cd.Codigo
		From CodigosDestinacion cd Where cd.IdCodigoDestinacion=cp.IdCodigoDestinacion),0) as [DESTINACION],

	Case When Prov.IdImpuestoDirectoSUSS=1 Then cp.PorcentajeParaSUSS Else 0 End as [RETSERVPOR],
	Case When Prov.IdImpuestoDirectoSUSS=1 Then cp.GravadoParaSUSS Else 0 End as [RETSERV],
	Case When Prov.IdImpuestoDirectoSUSS=2 Then cp.PorcentajeParaSUSS Else 0 End as [RETLIMPPOR],
	Case When Prov.IdImpuestoDirectoSUSS=2 Then cp.GravadoParaSUSS Else 0 End as [RETLIMP],
	Case When Prov.IdImpuestoDirectoSUSS>=3 Then cp.PorcentajeParaSUSS Else 0 End as [RETCONSPOR],
	Case When Prov.IdImpuestoDirectoSUSS>=3 Then cp.GravadoParaSUSS Else 0 End as [RETCONS],
	Case when TiposComprobante.VaAlLibro is not null
		Then 'N'
		Else 'C'
	End as [FISCAL],
	cp.FondoReparo as [BONIFICML1]

From ComprobantesProveedores cp
Left Outer Join Proveedores Prov ON cp.IdProveedor = Prov.IdProveedor
Left Outer Join Provincias Pcia ON Prov.IdProvincia = Pcia.IdProvincia
Left Outer Join TiposRetencionGanancia trg ON cp.IdTipoRetencionGanancia = trg.IdTipoRetencionGanancia
Left Outer Join ImpuestosDirectos ON Prov.IdImpuestoDirectoSUSS = ImpuestosDirectos.IdImpuestoDirecto
Left Outer Join TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
Where cp.REP_CTAPRO_INS = 'Y' or cp.REP_CTAPRO_UPD = 'Y'
