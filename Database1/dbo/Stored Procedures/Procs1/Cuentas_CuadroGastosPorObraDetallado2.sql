CREATE Procedure [dbo].[Cuentas_CuadroGastosPorObraDetallado2]

@FechaDesde datetime,
@FechaHasta datetime,
@Dts varchar(200),
@IncluirCierre varchar(2),
@IdObra int = Null

AS 

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
	@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int, @ModeloContableSinApertura varchar(2)

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @ModeloContableSinApertura=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ModeloContableSinApertura'),'NO')

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Subdiarios.IdComprobante,
  SUM(
  Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
		IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
		 Then Subdiarios.Debe
	When Subdiarios.Debe is null and Subdiarios.Haber is not null and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
		IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
		 Then Subdiarios.Haber * -1
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
		IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
		 Then Subdiarios.Debe - Subdiarios.Haber
	 Else 0
  End)
 FROM Subdiarios 
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=Subdiarios.IdCuenta)))
 GROUP BY Subdiarios.IdComprobante


CREATE TABLE #Auxiliar2 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProvinciaDestino INTEGER,
			 PorcentajeProvinciaDestino NUMERIC(12,5),
			 PorcentajeGeneral NUMERIC(12,5)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdComprobanteProveedor) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT 
  dcp.IdComprobanteProveedor,
  Case When cp.IdProveedor is not null
	Then Case When dcp.IdProvinciaDestino1 is null or dcp.IdProvinciaDestino1=0 Then Proveedores.IdProvincia Else dcp.IdProvinciaDestino1 End
	Else Case When dcp.IdProvinciaDestino1 is null or dcp.IdProvinciaDestino1=0
			Then (Select Top 1 P.IdProvincia From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
			Else dcp.IdProvinciaDestino1
		 End
  End,
  dcp.PorcentajeProvinciaDestino1,
  Case When IsNull(#Auxiliar1.Importe,0)<>0 
	Then IsNull(dcp.PorcentajeProvinciaDestino1,100) * 
		((dcp.Importe*cp.CotizacionMoneda) / Case When IsNull(cp.TotalIvaNoDiscriminado,0)<>0 Then 1+(IsNull(dcp.IvaComprasPorcentaje1,0)/100) Else 1 End / Abs(#Auxiliar1.Importe))
	Else 100 
  End
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor  
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta=Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=dcp.IdCuenta))) and 
	(IsNull(dcp.PorcentajeProvinciaDestino1,0)<>0 or (dcp.PorcentajeProvinciaDestino1 is null and dcp.PorcentajeProvinciaDestino2 is null))

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  Case When cp.IdProveedor is not null
	Then Case When dcp.IdProvinciaDestino2 is null or dcp.IdProvinciaDestino2=0 Then Proveedores.IdProvincia Else dcp.IdProvinciaDestino2 End
	Else Case When dcp.IdProvinciaDestino2 is null or dcp.IdProvinciaDestino2=0
			Then (Select Top 1 P.IdProvincia From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual)
			Else dcp.IdProvinciaDestino2
		 End
  End,
  dcp.PorcentajeProvinciaDestino2,
  Case When IsNull(#Auxiliar1.Importe,0)<>0 
	Then IsNull(dcp.PorcentajeProvinciaDestino2,100) * 
			((dcp.Importe*cp.CotizacionMoneda) / Case When IsNull(cp.TotalIvaNoDiscriminado,0)<>0 Then 1+(IsNull(dcp.IvaComprasPorcentaje1,0)/100) Else 1 End / #Auxiliar1.Importe)
	Else 100 
  End
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor  
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta=Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=dcp.IdCuenta))) and 
	IsNull(dcp.PorcentajeProvinciaDestino2,0)<>0


CREATE TABLE #Auxiliar3 
			(
			 IdComprobanteProveedor INTEGER,
			 PorcentajeGeneral NUMERIC(12,5)
			)
INSERT INTO #Auxiliar3 
 SELECT #Auxiliar2.IdComprobanteProveedor, SUM(#Auxiliar2.PorcentajeGeneral)
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdComprobanteProveedor

/*  CURSOR  */
DECLARE @IdComprobanteProveedor int, @Corte int, @DiferenciaA100 numeric(12,5)
SET @Corte=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdComprobanteProveedor FROM #Auxiliar2 ORDER BY IdComprobanteProveedor
OPEN Cur
FETCH NEXT FROM Cur INTO @IdComprobanteProveedor
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdComprobanteProveedor
	   BEGIN
		SET @Corte=@IdComprobanteProveedor
		SET @DiferenciaA100=100-IsNull((Select Top 1 #Auxiliar3.PorcentajeGeneral From #Auxiliar3 Where #Auxiliar3.IdComprobanteProveedor=@Corte),0)
		UPDATE #Auxiliar2
		SET PorcentajeGeneral = PorcentajeGeneral+@DiferenciaA100
		WHERE CURRENT OF Cur
	   END
	FETCH NEXT FROM Cur INTO @IdComprobanteProveedor
   END
CLOSE Cur
DEALLOCATE Cur


TRUNCATE TABLE _TempCuadroGastosParaCubo2

INSERT INTO _TempCuadroGastosParaCubo2 
SELECT 
 Case When Cuentas.IdObra is not null Then Cuentas.IdObra
	When cp.IdComprobanteProveedor is not null Then IsNull((Select Top 1 dcp.IdObra From DetalleComprobantesProveedores dcp Where dcp.IdDetalleComprobanteProveedor=Subdiarios.IdDetalleComprobante),0)
	Else IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0)))))
 End,
 Case When Cuentas.IdObra is not null Then Obras.NumeroObra
	When cp.IdComprobanteProveedor is not null 
	 Then (Select Top 1 Ob.NumeroObra From Obras Ob Where ob.IdObra=(Select Top 1 dcp.IdObra From DetalleComprobantesProveedores dcp Where dcp.IdDetalleComprobanteProveedor=Subdiarios.IdDetalleComprobante))
	Else IsNull((Select Top 1 Ob.NumeroObra From Obras Ob Where Ob.IdObra=IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0)))))),'Sin Obra')
 End,
 Case When RubrosContables.IdRubroContable is not null Then RubrosContables.IdRubroContable
	Else IsNull((Select Top 1 cg.IdRubroContable From Cuentas C Left Outer Join CuentasGastos cg On cg.IdCuentaGasto=C.IdCuentaGasto Where cg.IdCuentaMadre=Subdiarios.IdCuenta),0)
 End,
 Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion
	Else IsNull((Select Top 1 rc.Descripcion From Cuentas C 
			Left Outer Join CuentasGastos cg On cg.IdCuentaGasto=C.IdCuentaGasto
			Left Outer Join RubrosContables rc On rc.IdRubroContable=cg.IdRubroContable
			Where cg.IdCuentaMadre=Subdiarios.IdCuenta),'Sin Rubro')
 End,
 Case When Cuentas.IdObra is not null Then Obras.IdUnidadOperativa
	When cp.IdComprobanteProveedor is not null 
	 Then (Select Top 1 Ob.IdUnidadOperativa From Obras Ob Where ob.IdObra=(Select Top 1 dcp.IdObra From DetalleComprobantesProveedores dcp Where dcp.IdDetalleComprobanteProveedor=Subdiarios.IdDetalleComprobante))
	 Else IsNull((Select Top 1 Ob.IdUnidadOperativa From Obras Ob Where Ob.IdObra=IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0)))))),0)
 End,
 Case When Cuentas.IdObra is not null Then UnidadesOperativas.Descripcion
	When cp.IdComprobanteProveedor is not null 
	 Then (Select Top 1 UO.Descripcion From UnidadesOperativas UO
			Where UO.IdUnidadOperativa=(Select Top 1 Ob.IdUnidadOperativa From Obras Ob Where ob.IdObra=(Select Top 1 dcp.IdObra From DetalleComprobantesProveedores dcp Where dcp.IdDetalleComprobanteProveedor=Subdiarios.IdDetalleComprobante)))
	Else IsNull((Select Top 1 UO.Descripcion From UnidadesOperativas UO
			Where UO.IdUnidadOperativa=(Select Top 1 Ob.IdUnidadOperativa From Obras Ob Where Ob.IdObra=IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0))))))),'Sin U.Operativa')
 End,
 Case When Subdiarios.Debe is not null and Subdiarios.Haber is null 
	 Then Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Subdiarios.Debe * IsNull(dfp.Porcentaje,100) / 100 
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Subdiarios.Debe * IsNull(dndp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Subdiarios.Debe * IsNull(dncp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then Subdiarios.Debe * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100 
			Else Subdiarios.Debe
		End
	When Subdiarios.Debe is null and Subdiarios.Haber is not null 
	 Then Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Subdiarios.Haber * -1 * IsNull(dfp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Subdiarios.Haber * -1 * IsNull(dndp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Subdiarios.Haber * -1 * IsNull(dncp.Porcentaje,100) / 100 
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then Subdiarios.Haber * -1 * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100 
			Else Subdiarios.Haber * -1
		End
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null 
	 Then Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dfp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dndp.Porcentaje,100) / 100 
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dncp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100
			Else (Subdiarios.Debe - Subdiarios.Haber)
		End
	 Else 0
 End,
 Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then (Select Provincias.Nombre From Provincias Where Provincias.IdProvincia=dfp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then (Select Provincias.Nombre From Provincias Where Provincias.IdProvincia=Devoluciones.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then (Select Provincias.Nombre From Provincias Where Provincias.IdProvincia=dndp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then (Select Provincias.Nombre From Provincias Where Provincias.IdProvincia=dncp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then (Select Provincias.Nombre From Provincias Where Provincias.IdProvincia=OrdenesPago.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
	 Then (Select Provincias.Nombre From Provincias Where Provincias.IdProvincia=Recibos.IdProvinciaDestino)
	 Else Case When IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES' Then (Select Provincias.Nombre From Provincias Where Provincias.IdProvincia=#Auxiliar2.IdProvinciaDestino)
			When IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS' Then (Select Provincias.Nombre From Provincias Where Provincias.IdProvincia=CuentasBancarias.IdProvincia)
			Else 'Capital Federal'
		  End
 End,
 Case When IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
	 Then Convert(varchar,cp.FechaRecepcion,103)+' '+TiposComprobante.DescripcionAb+' '+
		'(Ref.'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroReferencia)))+Convert(varchar,cp.NumeroReferencia)+') '+
			cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' - '+
			'Prov.: '+
			Case When cp.IdProveedor is not null
				Then Rtrim(IsNull(Proveedores.RazonSocial,''))
				Else Rtrim(IsNull((Select Top 1 P.RazonSocial From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual),''))
			End
--  +' - '+'Cta.: '+Convert(varchar,Cuentas.Codigo)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
	 Then Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.DescripcionAb+' '+Facturas.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)+' - '+
		'Cli.: '+Rtrim(IsNull((Select Top 1 Clientes.RazonSocial From Clientes Where Clientes.IdCliente=Facturas.IdCliente),''))
--  +' - '+'Cta.: '+Convert(varchar,Cuentas.Codigo)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
	 Then Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.DescripcionAb+' '+Devoluciones.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)+' - '+
		'Cli.: '+Rtrim(IsNull((Select Top 1 Clientes.RazonSocial From Clientes Where Clientes.IdCliente=Devoluciones.IdCliente),''))
-- +' - '+'Cta.: '+Convert(varchar,Cuentas.Codigo)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
	 Then Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.DescripcionAb+' '+NotasDebito.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)+' - '+
		'Cli.: '+Rtrim(IsNull((Select Top 1 Clientes.RazonSocial From Clientes Where Clientes.IdCliente=NotasDebito.IdCliente),''))
--  +' - '+'Cta.: '+Convert(varchar,Cuentas.Codigo)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
	 Then Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.DescripcionAb+' '+NotasCredito.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)+' - '+
		'Cli.: '+Rtrim(IsNull((Select Top 1 Clientes.RazonSocial From Clientes Where Clientes.IdCliente=NotasCredito.IdCliente),''))
--  +' - '+'Cta.: '+Convert(varchar,Cuentas.Codigo)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
	 Then Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.DescripcionAb+' '+
		Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
		Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)+' - '+
		'Cli.: '+Rtrim(IsNull((Select Top 1 Clientes.RazonSocial From Clientes Where Clientes.IdCliente=Recibos.IdCliente),''))
--  +' - '+'Cta.: '+Convert(varchar,Cuentas.Codigo)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
	 Then Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.DescripcionAb+' ('+OrdenesPago.Tipo COLLATE Modern_Spanish_CI_AS+') '+
		Substring('0000000000',1,10-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)+' - '+
		'Prov.: '+Rtrim(IsNull((Select Top 1 P.RazonSocial From Proveedores P Where P.IdProveedor=OrdenesPago.IdProveedor),''))
--  +' - '+'Cta.: '+Convert(varchar,Cuentas.Codigo)
	 Else Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.DescripcionAb+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,Subdiarios.NumeroComprobante)))+Convert(varchar,Subdiarios.NumeroComprobante)+' - '+
		'Cta.: '+Convert(varchar,Cuentas.Codigo)
 End, 
 Convert(varchar,Year(Subdiarios.FechaComprobante))+'/'+Substring('00',1,2-len(Convert(varchar,Month(Subdiarios.FechaComprobante))))+Convert(varchar,Month(Subdiarios.FechaComprobante))+' '+
	 Case When Month(Subdiarios.FechaComprobante)=1 Then 'Enero'
		When Month(Subdiarios.FechaComprobante)=2 Then 'Febrero'
		When Month(Subdiarios.FechaComprobante)=3 Then 'Marzo'
		When Month(Subdiarios.FechaComprobante)=4 Then 'Abril'
		When Month(Subdiarios.FechaComprobante)=5 Then 'Mayo'
		When Month(Subdiarios.FechaComprobante)=6 Then 'Junio'
		When Month(Subdiarios.FechaComprobante)=7 Then 'Julio'
		When Month(Subdiarios.FechaComprobante)=8 Then 'Agosto'
		When Month(Subdiarios.FechaComprobante)=9 Then 'Setiembre'
		When Month(Subdiarios.FechaComprobante)=10 Then 'Octubre'
		When Month(Subdiarios.FechaComprobante)=11 Then 'Noviembre'
		When Month(Subdiarios.FechaComprobante)=12 Then 'Diciembre'
	 End,
 IsNull(ap.Descripcion,'S/D')
FROM Subdiarios 
LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable)
LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdComprobanteProveedor=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN DetalleNotasDebitoProvincias dndp ON dndp.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN DetalleNotasCreditoProvincias dncp ON dncp.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
LEFT OUTER JOIN Valores ON Valores.IdValor=Subdiarios.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=Valores.IdCuentaBancaria
LEFT OUTER JOIN [Actividades Proveedores] ap ON ap.IdActividad=Proveedores.IdActividad
WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 

	( (Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 

	  (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 

	  (((Cuentas.IdObra Is Null and NotasDebito.IdObra Is Not Null and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito) or 
	    (Cuentas.IdObra Is Null and NotasCredito.IdObra Is Not Null and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito)) and 
	   Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=Subdiarios.IdCuenta)) or 

	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=Subdiarios.IdCuenta)) ) and 

	(cp.IdComprobanteProveedor is null or (cp.IdComprobanteProveedor is not null and IsNull(cp.TomarEnCuboDeGastos,'SI')='SI'))

UNION ALL

SELECT 
 IsNull(Cuentas.IdObra,IsNull(DetAsi.IdObra,0)),
 IsNull(Obras.NumeroObra,'Sin Obra'),
 IsNull(IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable),0),
 IsNull(RubrosContables.Descripcion,'Sin Rubro'),
 IsNull(Obras.IdUnidadOperativa,0),
 IsNull(UnidadesOperativas.Descripcion,'Sin U.Operativa'),
 Case 	When DetAsi.Debe is not null and DetAsi.Haber is null Then DetAsi.Debe
	When DetAsi.Debe is null and DetAsi.Haber is not null Then DetAsi.Haber * -1
	When DetAsi.Debe is not null and DetAsi.Haber is not null Then DetAsi.Debe - DetAsi.Haber
	 Else 0
 End,
 Provincias.Nombre,
 Convert(varchar,Asientos.FechaAsiento,103)+' AS '+Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento),
 Convert(varchar,Year(Asientos.FechaAsiento))+'/'+Substring('00',1,2-len(Convert(varchar,Month(Asientos.FechaAsiento))))+
	Convert(varchar,Month(Asientos.FechaAsiento))+' '+
	Case When Month(Asientos.FechaAsiento)=1 Then 'Enero'
		When Month(Asientos.FechaAsiento)=2 Then 'Febrero'
		When Month(Asientos.FechaAsiento)=3 Then 'Marzo'
		When Month(Asientos.FechaAsiento)=4 Then 'Abril'
		When Month(Asientos.FechaAsiento)=5 Then 'Mayo'
		When Month(Asientos.FechaAsiento)=6 Then 'Junio'
		When Month(Asientos.FechaAsiento)=7 Then 'Julio'
		When Month(Asientos.FechaAsiento)=8 Then 'Agosto'
		When Month(Asientos.FechaAsiento)=9 Then 'Setiembre'
		When Month(Asientos.FechaAsiento)=10 Then 'Octubre'
		When Month(Asientos.FechaAsiento)=11 Then 'Noviembre'
		When Month(Asientos.FechaAsiento)=12 Then 'Diciembre'
	End,
 'S/D'
FROM DetalleAsientos DetAsi 
LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull(DetAsi.IdObra,Cuentas.IdObra)
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable)
LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=DetAsi.IdProvinciaDestino
WHERE (Asientos.FechaAsiento between @FechaDesde and @FechaHasta) and Asientos.IdCuentaSubdiario is null and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 IsNull(CuentasGastos.IdRubroContable,IsNull(Cuentas.IdRubroContable,0))>0 or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 	
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetAsi.IdCuenta))) and 
	(@IncluirCierre='SI' or 
		(@IncluirCierre='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and (Asientos.FechaAsiento between @FechaDesde and @FechaHasta))))
--						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and Month(Asientos.FechaAsiento)=Month(@FechaHasta) )))

IF @IdObra>0 
	DELETE _TempCuadroGastosParaCubo2 WHERE IdObra<>@IdObra

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3

SET NOCOUNT OFF