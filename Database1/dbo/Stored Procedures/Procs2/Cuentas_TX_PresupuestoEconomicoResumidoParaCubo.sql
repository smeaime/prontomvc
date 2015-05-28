
CREATE Procedure [dbo].[Cuentas_TX_PresupuestoEconomicoResumidoParaCubo]

@IdEjercicioContable int,
@Dts varchar(100),
@IncluirCierre varchar(2) = Null

AS 

SET NOCOUNT ON

DECLARE @FechaDesde datetime,@FechaHasta datetime, @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteDevoluciones int,
	@IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int,@IdTipoComprobanteOrdenPago int

SET @IncluirCierre=IsNull(@IncluirCierre,'SI')
SET @FechaDesde=(Select Top 1 FechaInicio From EjerciciosContables Where IdEjercicioContable=@IdEjercicioContable)
SET @FechaHasta=(Select Top 1 FechaFinalizacion From EjerciciosContables Where IdEjercicioContable=@IdEjercicioContable)
SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar10
			(
			 Descripcion VARCHAR(50) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia VARCHAR(20) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia1 VARCHAR(1) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia2 VARCHAR(3) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia3 VARCHAR(6) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia4 VARCHAR(9) COLLATE Modern_Spanish_CI_AS
			)

INSERT INTO #Auxiliar10
 SELECT  
  C.Descripcion,
  C.Jerarquia,
  Substring(C.Jerarquia,1,1),
  Substring(C.Jerarquia,1,3),
  Substring(C.Jerarquia,1,6),
  Substring(C.Jerarquia,1,9)
 FROM Cuentas C 


CREATE TABLE #Auxiliar11
			(
			 Descripcion VARCHAR(50) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia1 VARCHAR(1) COLLATE Modern_Spanish_CI_AS
			)
INSERT INTO #Auxiliar11
 SELECT  
  Null,
  #Auxiliar10.Jerarquia1
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia1

UPDATE #Auxiliar11
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia1=Substring(#Auxiliar11.Jerarquia1,1,1)
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar12
			(
			 Descripcion VARCHAR(50) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia2 VARCHAR(3) COLLATE Modern_Spanish_CI_AS
			)
INSERT INTO #Auxiliar12
 SELECT  
  Null,
  #Auxiliar10.Jerarquia2
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia2

UPDATE #Auxiliar12
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia2=Substring(#Auxiliar12.Jerarquia2,1,3)
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar13
			(
			 Descripcion VARCHAR(50) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia3 VARCHAR(6) COLLATE Modern_Spanish_CI_AS
			)
INSERT INTO #Auxiliar13
 SELECT  
  Null,
  #Auxiliar10.Jerarquia3
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia3

UPDATE #Auxiliar13
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia3=Substring(#Auxiliar13.Jerarquia3,1,6)
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar14
			(
			 Descripcion VARCHAR(50) COLLATE Modern_Spanish_CI_AS,
			 Jerarquia4 VARCHAR(9) COLLATE Modern_Spanish_CI_AS
			)
INSERT INTO #Auxiliar14
 SELECT  
  Null,
  #Auxiliar10.Jerarquia4
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia4

UPDATE #Auxiliar14
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia4=Substring(#Auxiliar14.Jerarquia4,1,9)
		 Order By #Auxiliar10.Jerarquia)


/*	CALCULO DE SALDOS CONTABLES 	*/

CREATE TABLE #Auxiliar2 
			(
			 IdCuentaMadre INTEGER,
			 IdCuentaGasto INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT 
  (Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos
	Where CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto),
  Cuentas.IdCuenta
 FROM Cuentas 
 WHERE Cuentas.IdCuentaGasto IS NOT NULL

CREATE TABLE #Auxiliar1
			(
			 A_IdCuenta INTEGER,
			 A_IdCuenta1 INTEGER,
			 A_Fecha DATETIME,
			 A_Detalle VARCHAR(100),
			 A_Debe NUMERIC(18, 2),
			 A_Haber NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar1 
 SELECT 
  IsNull(#Auxiliar2.IdCuentaMadre,DetAsi.IdCuenta),
  DetAsi.IdCuenta,
  Asientos.FechaAsiento,
  Convert(varchar,Year(Asientos.FechaAsiento))+' '+
	Substring('00',1,2-Len(Convert(varchar,Month(Asientos.FechaAsiento))))+
		Convert(varchar,Month(Asientos.FechaAsiento))+' '+
	Substring('00',1,2-Len(Convert(varchar,Day(Asientos.FechaAsiento))))+
		Convert(varchar,Day(Asientos.FechaAsiento))+' '+
	'AS '+
	Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+
		Convert(varchar,Asientos.NumeroAsiento),
  Case When DetAsi.Debe is not null Then DetAsi.Debe Else 0 End,
  Case When DetAsi.Haber is not null Then DetAsi.Haber Else 0 End
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN TiposComprobante ON DetAsi.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdCuentaGasto=DetAsi.IdCuenta
 WHERE Asientos.IdCuentaSubdiario is null and 
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta and 
	(@IncluirCierre='SI' or 
		(@IncluirCierre='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta))))

 UNION ALL 

 SELECT 
  IsNull(#Auxiliar2.IdCuentaMadre,Sub.IdCuenta),
  Sub.IdCuenta,
  Sub.FechaComprobante,
  Case 	When Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
	 Then Convert(varchar,Year(Facturas.FechaFactura))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(Facturas.FechaFactura))))+
			Convert(varchar,Month(Facturas.FechaFactura))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(Facturas.FechaFactura))))+
			Convert(varchar,Day(Facturas.FechaFactura))+' '+
		TiposComprobante.DescripcionAb+' '+Facturas.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+
			Convert(varchar,Facturas.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+
			Convert(varchar,Facturas.NumeroFactura)+' - '+
		'Cliente : '+IsNull((Select Top 1 Cli.RazonSocial From Clientes Cli
					Where Cli.IdCliente=Facturas.IdCliente),'')
	When Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones
	 Then Convert(varchar,Year(Devoluciones.FechaDevolucion))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(Devoluciones.FechaDevolucion))))+
			Convert(varchar,Month(Devoluciones.FechaDevolucion))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(Devoluciones.FechaDevolucion))))+
			Convert(varchar,Day(Devoluciones.FechaDevolucion))+' '+
		TiposComprobante.DescripcionAb+' '+Devoluciones.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+
			Convert(varchar,Devoluciones.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+
			Convert(varchar,Devoluciones.NumeroDevolucion)+' - '+
		'Cliente : '+IsNull((Select Top 1 Cli.RazonSocial From Clientes Cli
					Where Cli.IdCliente=Devoluciones.IdCliente),'')
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito
	 Then Convert(varchar,Year(NotasDebito.FechaNotaDebito))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(NotasDebito.FechaNotaDebito))))+
			Convert(varchar,Month(NotasDebito.FechaNotaDebito))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(NotasDebito.FechaNotaDebito))))+
			Convert(varchar,Day(NotasDebito.FechaNotaDebito))+' '+
		TiposComprobante.DescripcionAb+' '+NotasDebito.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+
			Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+
			Convert(varchar,NotasDebito.NumeroNotaDebito)+' - '+
		'Cliente : '+IsNull((Select Top 1 Cli.RazonSocial From Clientes Cli
					Where Cli.IdCliente=NotasDebito.IdCliente),'')
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito
	 Then Convert(varchar,Year(NotasCredito.FechaNotaCredito))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(NotasCredito.FechaNotaCredito))))+
			Convert(varchar,Month(NotasCredito.FechaNotaCredito))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(NotasCredito.FechaNotaCredito))))+
			Convert(varchar,Day(NotasCredito.FechaNotaCredito))+' '+
		TiposComprobante.DescripcionAb+' '+NotasCredito.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+
			Convert(varchar,NotasCredito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+
			Convert(varchar,NotasCredito.NumeroNotaCredito)+' - '+
		'Cliente : '+IsNull((Select Top 1 Cli.RazonSocial From Clientes Cli
					Where Cli.IdCliente=NotasCredito.IdCliente),'')
	When Sub.IdTipoComprobante=@IdTipoComprobanteRecibo
	 Then Convert(varchar,Year(Recibos.FechaRecibo))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(Recibos.FechaRecibo))))+
			Convert(varchar,Month(Recibos.FechaRecibo))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(Recibos.FechaRecibo))))+
			Convert(varchar,Day(Recibos.FechaRecibo))+' '+
		'RE '+
		Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+
			Convert(varchar,Recibos.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+
			Convert(varchar,Recibos.NumeroRecibo)+' - '+
		Case 	When Recibos.IdCliente is not null 
			 Then 'Cliente : '+IsNull((Select Top 1 Cli.RazonSocial From Clientes Cli
							Where Cli.IdCliente=Recibos.IdCliente),'')
			When Recibos.IdCuenta is not null 
			 Then 'Cuenta : '+IsNull((Select Top 1 Cta.Descripcion From Cuentas Cta
							Where Cta.IdCuenta=Recibos.IdCuenta),'')
			Else ''
		End
	When Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago
	 Then Convert(varchar,Year(OrdenesPago.FechaOrdenPago))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(OrdenesPago.FechaOrdenPago))))+
			Convert(varchar,Month(OrdenesPago.FechaOrdenPago))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(OrdenesPago.FechaOrdenPago))))+
			Convert(varchar,Day(OrdenesPago.FechaOrdenPago))+' '+
		'OP '+
		Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
			Convert(varchar,OrdenesPago.NumeroOrdenPago)+' - '+
		Case 	When OrdenesPago.IdProveedor is not null 
			 Then 'Proveedor : '+IsNull((Select Top 1 Prv.RazonSocial From Proveedores Prv
							Where Prv.IdProveedor=OrdenesPago.IdProveedor),'')
			When OrdenesPago.IdCuenta is not null 
			 Then 'Cuenta : '+IsNull((Select Top 1 Cta.Descripcion From Cuentas Cta
							Where Cta.IdCuenta=OrdenesPago.IdCuenta),'')
			Else ''
		End
	When IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES'
	 Then Convert(varchar,Year(cp.FechaRecepcion))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(cp.FechaRecepcion))))+
			Convert(varchar,Month(cp.FechaRecepcion))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(cp.FechaRecepcion))))+
			Convert(varchar,Day(cp.FechaRecepcion))+' '+
		TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
			Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
			Convert(varchar,cp.NumeroComprobante2)+' - '+
		'Proveedor : '+IsNull((Select Top 1 Prv.RazonSocial From Proveedores Prv
					Where Prv.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)),'')
	When IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
	 Then Convert(varchar,Year(Valores.FechaComprobante))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(Valores.FechaComprobante))))+
			Convert(varchar,Month(Valores.FechaComprobante))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(Valores.FechaComprobante))))+
			Convert(varchar,Day(Valores.FechaComprobante))+' '+
		TiposComprobante.DescripcionAb+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+
			Convert(varchar,Valores.NumeroComprobante)
	Else Convert(varchar,Year(Sub.FechaComprobante))+' '+
		Substring('00',1,2-Len(Convert(varchar,Month(Sub.FechaComprobante))))+
			Convert(varchar,Month(Sub.FechaComprobante))+' '+
		Substring('00',1,2-Len(Convert(varchar,Day(Sub.FechaComprobante))))+
			Convert(varchar,Day(Sub.FechaComprobante))+' '+
		TiposComprobante.DescripcionAb+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,Sub.NumeroComprobante)))+
			Convert(varchar,Sub.NumeroComprobante)
  End,
  Case When Sub.Debe is not null Then Sub.Debe Else 0 End,
  Case When Sub.Haber is not null Then Sub.Haber Else 0 End
 FROM Subdiarios Sub
 LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdCuentaGasto=Sub.IdCuenta
 LEFT OUTER JOIN TiposComprobante ON Sub.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Sub.IdComprobante and Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Sub.IdComprobante and Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Sub.IdComprobante and Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Sub.IdComprobante and Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Sub.IdComprobante and Sub.IdTipoComprobante=@IdTipoComprobanteRecibo
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Sub.IdComprobante and Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Sub.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES'
 LEFT OUTER JOIN Valores ON Valores.IdValor=Sub.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
 WHERE Sub.FechaComprobante>=@FechaDesde and Sub.FechaComprobante<=@FechaHasta


CREATE TABLE #Auxiliar0
			(
			 IdCuenta INTEGER,
			 IdCuentaOriginal INTEGER,
			 IdTipoCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(50),
			 Jerarquia VARCHAR(60),
			 DescripcionJerarquia1 VARCHAR(60),
			 DescripcionJerarquia2 VARCHAR(60),
			 DescripcionJerarquia3 VARCHAR(60),
			 DescripcionJerarquia4 VARCHAR(60)
			)

INSERT INTO #Auxiliar0 
 SELECT 
  C.IdCuenta,
  C1.IdCuenta,
  C.IdTipoCuenta,
  C.Codigo,
  C.Descripcion,
  C.Jerarquia,
  Substring(C.Jerarquia,1,1)+' - '+#Auxiliar11.Descripcion,
  Substring(C.Jerarquia,3,1)+' - '+#Auxiliar12.Descripcion,
  Substring(C.Jerarquia,5,2)+' - '+#Auxiliar13.Descripcion,
  --Substring(C.Jerarquia,8,2)+' - '+#Auxiliar14.Descripcion
  Case When Substring(C.Jerarquia,1,1)<='5'  	Then Substring(C.Jerarquia,8,2)+' - '+#Auxiliar14.Descripcion
  	Else Substring(C.Jerarquia,8,2)+' - '+#Auxiliar13.Descripcion
  End
 FROM Cuentas C1 
 LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdCuentaGasto=C1.IdCuenta
 LEFT OUTER JOIN Cuentas C ON C.IdCuenta=IsNull(#Auxiliar2.IdCuentaMadre,C1.IdCuenta)
 LEFT OUTER JOIN #Auxiliar11 ON #Auxiliar11.Jerarquia1=Substring(C.Jerarquia,1,1)
 LEFT OUTER JOIN #Auxiliar12 ON #Auxiliar12.Jerarquia2=Substring(C.Jerarquia,1,3)
 LEFT OUTER JOIN #Auxiliar13 ON #Auxiliar13.Jerarquia3=Substring(C.Jerarquia,1,6)
 LEFT OUTER JOIN #Auxiliar14 ON #Auxiliar14.Jerarquia4=Substring(C.Jerarquia,1,9)
 
CREATE TABLE #Auxiliar00
			(
			 IdCuenta INTEGER,
			 IdTipoCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(50),
			 Jerarquia VARCHAR(60),
			 DescripcionJerarquia1 VARCHAR(60),
			 DescripcionJerarquia2 VARCHAR(60),
			 DescripcionJerarquia3 VARCHAR(60),
			 DescripcionJerarquia4 VARCHAR(60)
			)

INSERT INTO #Auxiliar00 
 SELECT 
  #Auxiliar0.IdCuenta,
  #Auxiliar0.IdTipoCuenta,
  #Auxiliar0.Codigo,
  #Auxiliar0.Descripcion,
  Max(#Auxiliar0.Jerarquia),
  Max(#Auxiliar0.DescripcionJerarquia1),
  Max(#Auxiliar0.DescripcionJerarquia2),
  Max(#Auxiliar0.DescripcionJerarquia3),
  Max(#Auxiliar0.DescripcionJerarquia4)
 FROM #Auxiliar0
 WHERE Substring(#Auxiliar0.Jerarquia,1,1)<='5' or 
	(Substring(#Auxiliar0.Jerarquia,1,1)>'5' and (#Auxiliar0.IdTipoCuenta=2 or #Auxiliar0.IdTipoCuenta=4))
 GROUP BY #Auxiliar0.IdCuenta, #Auxiliar0.IdTipoCuenta, #Auxiliar0.Codigo, #Auxiliar0.Descripcion
 

CREATE TABLE #Auxiliar4 
			(
			 A_IdCuenta INTEGER,
			 A_IdTipoCuenta INTEGER,
			 A_Clave INTEGER,
			 A_Jerarquia1 VARCHAR(60),
			 A_Jerarquia2 VARCHAR(60),
			 A_Jerarquia3 VARCHAR(60),
			 A_Jerarquia4 VARCHAR(60),
			 A_Codigo INTEGER,
			 A_Descripcion  VARCHAR(60),
			 A_Detalle  VARCHAR(100),
			 A_PresupuestoTeoricoMes01 NUMERIC(18, 2),
			 A_SaldoMes01 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes02 NUMERIC(18, 2),
			 A_SaldoMes02 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes03 NUMERIC(18, 2),
			 A_SaldoMes03 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes04 NUMERIC(18, 2),
			 A_SaldoMes04 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes05 NUMERIC(18, 2),
			 A_SaldoMes05 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes06 NUMERIC(18, 2),
			 A_SaldoMes06 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes07 NUMERIC(18, 2),
			 A_SaldoMes07 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes08 NUMERIC(18, 2),
			 A_SaldoMes08 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes09 NUMERIC(18, 2),
			 A_SaldoMes09 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes10 NUMERIC(18, 2),
			 A_SaldoMes10 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes11 NUMERIC(18, 2),
			 A_SaldoMes11 NUMERIC(18, 2),
			 A_PresupuestoTeoricoMes12 NUMERIC(18, 2),
			 A_SaldoMes12 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT 
  #Auxiliar0.IdCuenta,
  Cuentas.IdTipoCuenta,
  1,
  #Auxiliar0.DescripcionJerarquia1,
  #Auxiliar0.DescripcionJerarquia2,
  #Auxiliar0.DescripcionJerarquia3,
  #Auxiliar0.DescripcionJerarquia4,
  #Auxiliar0.Codigo,
  #Auxiliar0.Descripcion,
  '',
  Sum(IsNull(cec.PresupuestoTeoricoMes01,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes02,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes03,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes04,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes05,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes06,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes07,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes08,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes09,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes10,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes11,0)),
  0,
  Sum(IsNull(cec.PresupuestoTeoricoMes12,0)),
  0
 FROM #Auxiliar0 
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = #Auxiliar0.IdCuenta
 LEFT OUTER JOIN CuentasEjerciciosContables cec ON #Auxiliar0.IdCuentaOriginal=cec.IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable
 --WHERE Substring(Cuentas.Jerarquia,1,1)<='5'
 GROUP BY #Auxiliar0.IdCuenta, Cuentas.IdTipoCuenta, #Auxiliar0.DescripcionJerarquia1,
	  #Auxiliar0.DescripcionJerarquia2, #Auxiliar0.DescripcionJerarquia3,
	  #Auxiliar0.DescripcionJerarquia4, #Auxiliar0.Codigo, #Auxiliar0.Descripcion

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0,
  0,  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=1 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=2 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=3 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=4 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=5 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=6 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=7 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=8 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=9 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=10 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber,
  0,
  0
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=11 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  #Auxiliar00.IdTipoCuenta,
  2,
  #Auxiliar00.DescripcionJerarquia1,
  #Auxiliar00.DescripcionJerarquia2,
  #Auxiliar00.DescripcionJerarquia3,
  #Auxiliar00.DescripcionJerarquia4,
  #Auxiliar00.Codigo,
  #Auxiliar00.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  #Auxiliar1.A_Debe-#Auxiliar1.A_Haber
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar00 ON #Auxiliar00.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE MONTH(#Auxiliar1.A_Fecha)=12 --and SUBSTRING(#Auxiliar00.DescripcionJerarquia1,1,1)<='5'


TRUNCATE TABLE _TempCuboPresupuestoEconomico
INSERT INTO _TempCuboPresupuestoEconomico 
SELECT 
 #Auxiliar4.A_Jerarquia1,
 #Auxiliar4.A_Jerarquia2,
 #Auxiliar4.A_Jerarquia3,
 #Auxiliar4.A_Jerarquia4, Convert(varchar,#Auxiliar4.A_Codigo)+' '+#Auxiliar4.A_Descripcion,
 #Auxiliar4.A_Detalle,
 #Auxiliar4.A_PresupuestoTeoricoMes01, #Auxiliar4.A_SaldoMes01, #Auxiliar4.A_PresupuestoTeoricoMes02, #Auxiliar4.A_SaldoMes02, #Auxiliar4.A_PresupuestoTeoricoMes03, #Auxiliar4.A_SaldoMes03, #Auxiliar4.A_PresupuestoTeoricoMes04, #Auxiliar4.A_SaldoMes04, #Auxiliar4.A_PresupuestoTeoricoMes05, #Auxiliar4.A_SaldoMes05, #Auxiliar4.A_PresupuestoTeoricoMes06, #Auxiliar4.A_SaldoMes06, #Auxiliar4.A_PresupuestoTeoricoMes07, #Auxiliar4.A_SaldoMes07, #Auxiliar4.A_PresupuestoTeoricoMes08, #Auxiliar4.A_SaldoMes08, #Auxiliar4.A_PresupuestoTeoricoMes09, #Auxiliar4.A_SaldoMes09, #Auxiliar4.A_PresupuestoTeoricoMes10, #Auxiliar4.A_SaldoMes10, #Auxiliar4.A_PresupuestoTeoricoMes11, #Auxiliar4.A_SaldoMes11, #Auxiliar4.A_PresupuestoTeoricoMes12, #Auxiliar4.A_SaldoMes12,
 0,
 0FROM #Auxiliar4
WHERE (#Auxiliar4.A_SaldoMes01<>0 or #Auxiliar4.A_SaldoMes02<>0 or #Auxiliar4.A_SaldoMes03<>0 or 
	#Auxiliar4.A_SaldoMes04<>0 or #Auxiliar4.A_SaldoMes05<>0 or #Auxiliar4.A_SaldoMes06<>0 or 
	#Auxiliar4.A_SaldoMes07<>0 or #Auxiliar4.A_SaldoMes08<>0 or #Auxiliar4.A_SaldoMes09<>0 or 
	#Auxiliar4.A_SaldoMes10<>0 or #Auxiliar4.A_SaldoMes11<>0 or #Auxiliar4.A_SaldoMes12<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes01<>0 or #Auxiliar4.A_PresupuestoTeoricoMes02<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes03<>0 or #Auxiliar4.A_PresupuestoTeoricoMes04<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes05<>0 or #Auxiliar4.A_PresupuestoTeoricoMes06<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes07<>0 or #Auxiliar4.A_PresupuestoTeoricoMes08<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes09<>0 or #Auxiliar4.A_PresupuestoTeoricoMes10<>0 or 
	#Auxiliar4.A_PresupuestoTeoricoMes11<>0 or #Auxiliar4.A_PresupuestoTeoricoMes12<>0) and 
	(#Auxiliar4.A_IdTipoCuenta=2 or #Auxiliar4.A_IdTipoCuenta=4)

UPDATE _TempCuboPresupuestoEconomico
SET 
	TotalPresupuestoTeorico=
				IsNull(PresupuestoTeoricoMes01,0)+IsNull(PresupuestoTeoricoMes02,0)+
				IsNull(PresupuestoTeoricoMes03,0)+IsNull(PresupuestoTeoricoMes04,0)+
				IsNull(PresupuestoTeoricoMes05,0)+IsNull(PresupuestoTeoricoMes06,0)+
				IsNull(PresupuestoTeoricoMes07,0)+IsNull(PresupuestoTeoricoMes08,0)+
				IsNull(PresupuestoTeoricoMes09,0)+IsNull(PresupuestoTeoricoMes10,0)+
				IsNull(PresupuestoTeoricoMes11,0)+IsNull(PresupuestoTeoricoMes12,0),
	TotalSaldo=
		IsNull(SaldoMes01,0)+IsNull(SaldoMes02,0)+
		IsNull(SaldoMes03,0)+IsNull(SaldoMes04,0)+
		IsNull(SaldoMes05,0)+IsNull(SaldoMes06,0)+
		IsNull(SaldoMes07,0)+IsNull(SaldoMes08,0)+
		IsNull(SaldoMes09,0)+IsNull(SaldoMes10,0)+
		IsNull(SaldoMes11,0)+IsNull(SaldoMes12,0)

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF

--Select * From _TempCuboPresupuestoEconomico 
--Order By Jerarquia1, Jerarquia2, Jerarquia3, Jerarquia4, Cuenta
--Select * from #Auxiliar00 order by jerarquia

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar00
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13
DROP TABLE #Auxiliar14
