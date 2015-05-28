CREATE PROCEDURE [dbo].[InformeMayorDetallado_TX_1]

@IdCuenta int,
@FechaDesde datetime,
@FechaHasta datetime,
@DetalleCuentasHijas varchar(2),
@DetalleSinAgrupar varchar(2),
@IncluirConsolidacion varchar(2) = Null,
@IdObra int = Null

AS

SET NOCOUNT ON

SET @IncluirConsolidacion=IsNull(@IncluirConsolidacion,'SI')
SET @IdObra=IsNull(@IdObra,-1)

IF Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
			Where pic.Clave='Ignorar obra en cuentas para combo'),'')='SI'
	SET @IdObra=-1

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, 
		@IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int, @IdTipoComprobanteDeposito int, @IdTipoComprobanteSalidaMateriales int, 
		@LineaSaldoInicial varchar(2), @IdCuentaGasto int, @FechaFinalizacionUltimoEjercicio datetime

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDeposito=(Select Top 1 IdTipoComprobanteDeposito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteSalidaMateriales=0
SET @IdCuentaGasto=IsNull((Select Top 1 IdCuentaGasto From Cuentas Where IdCuenta=@IdCuenta),0)

SET @FechaFinalizacionUltimoEjercicio=0
IF Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
			Where pic.Clave='Tomar saldo inicial desde ultimo ejercicio en mayor contable'),'')='SI'
	SET @FechaFinalizacionUltimoEjercicio=isnull((Select Top 1 FechaFinalizacion From EjerciciosContables Where FechaFinalizacion<=@FechaDesde Order By FechaFinalizacion Desc),0)

SET @LineaSaldoInicial=''
IF Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
			Where pic.Clave='Ignorar saldo inicial en mayor contable'),'')='SI'
	SET @LineaSaldoInicial='NO'

CREATE TABLE #Auxiliar1	
			(
			 A_IdCuenta INTEGER,
			 A_Codigo INTEGER,
			 A_IdObra INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (A_IdCuenta) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  Cuentas.IdCuenta,
  Cuentas.Codigo,
  Cuentas.IdObra
 FROM Cuentas 
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaMadre=@IdCuenta
 WHERE Cuentas.IdCuentaGasto IS NOT NULL AND Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto


CREATE TABLE #Auxiliar0	
			(
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar0 
 SELECT Sub.IdCuenta, IsNull(Sub.Debe,0), IsNull(Sub.Haber,0)
 FROM Subdiarios Sub
 LEFT OUTER JOIN #Auxiliar1 ON Sub.IdCuenta = #Auxiliar1.A_IdCuenta
 WHERE (Sub.IdCuenta=@IdCuenta or #Auxiliar1.A_IdCuenta is not null) and Sub.FechaComprobante<@FechaDesde and Sub.FechaComprobante>@FechaFinalizacionUltimoEjercicio

 UNION ALL

 SELECT DetAsi.IdCuenta, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0)
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN #Auxiliar1 ON DetAsi.IdCuenta = #Auxiliar1.A_IdCuenta
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE (DetAsi.IdCuenta=@IdCuenta or #Auxiliar1.A_IdCuenta is not null) and 
	Asientos.IdCuentaSubdiario is null and Asientos.FechaAsiento<@FechaDesde and Asientos.FechaAsiento>@FechaFinalizacionUltimoEjercicio and 
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))


CREATE TABLE #Auxiliar2
			(
			 IdAux INTEGER,
			 IdCuenta INTEGER,
			 Asiento INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 Tipo VARCHAR(10),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Saldo NUMERIC(18, 2),
			 Detalle VARCHAR(200),
			 Letra VARCHAR(1),
			 NumeroComprobante1 INTEGER,
			 NumeroComprobante2 INTEGER,
			 IdCliente INTEGER,
			 IdProveedor INTEGER,
			 Observaciones VARCHAR(5000),
			 DebeHaber INTEGER,
			 IdObra INTEGER,
			 Detalle1 VARCHAR(100)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  1,
  Case When @DetalleCuentasHijas='SI' Then DetAsi.IdCuenta Else @IdCuenta End,
  Asientos.NumeroAsiento,
  Asientos.FechaAsiento,
  38,
  Asientos.IdAsiento,
  TiposComprobante.DescripcionAb,
  DetAsi.Libro+' '+DetAsi.TipoImporte+' '+DetAsi.Signo,
  DetAsi.Debe,
  DetAsi.Haber,
  Null,
  SubString(IsNull(Asientos.Concepto COLLATE Modern_Spanish_CI_AS,'') + ' ' + 
	Case When #Auxiliar1.A_IdCuenta is not null and @DetalleCuentasHijas='SI'
			Then '[ Cuenta : '+Convert(varchar,#Auxiliar1.A_Codigo)+' - Obra : '+Obras.NumeroObra+' ] '+IsNull(DetAsi.Detalle,' ')
			Else IsNull(DetAsi.Detalle,' ') 
	End + ' ' + IsNull(Proveedores.RazonSocial,IsNull(Convert(varchar,OrdenesPago.Observaciones),'')),1,200),
  Null,
  0,
  DetAsi.NumeroComprobante,
  Null,
  Null,
  Null,
  Case When IsNull(DetAsi.Debe,0)<>0 Then 1 Else 2 End,
  DetAsi.IdObra,
  Null
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN TiposComprobante ON DetAsi.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN #Auxiliar1 ON DetAsi.IdCuenta = #Auxiliar1.A_IdCuenta
 LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar1.A_IdObra
 LEFT OUTER JOIN Valores ON Valores.IdValor = DetAsi.IdValor
 LEFT OUTER JOIN DetalleOrdenesPagoValores ON DetalleOrdenesPagoValores.IdDetalleOrdenPagoValores = Valores.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = DetalleOrdenesPagoValores.IdOrdenPago
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = OrdenesPago.IdProveedor
 WHERE (DetAsi.IdCuenta=@IdCuenta or #Auxiliar1.A_IdCuenta is not null) and Asientos.IdCuentaSubdiario is null and
		Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta) and 
		(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL

 SELECT
  1,
  Case When @DetalleCuentasHijas='SI' Then Subdiarios.IdCuenta Else @IdCuenta End,
  Null,
  Subdiarios.FechaComprobante,
  Subdiarios.IdTipoComprobante,
  Subdiarios.IdComprobante,
  Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then TiposComprobante.DescripcionAb Else 'CV' End,
  Null,
  Subdiarios.Debe,
  Subdiarios.Haber,
  Null,
  Case 	When @DetalleCuentasHijas='SI' Then 
		Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago and OrdenesPago.IdCuenta is not null
				Then Substring(IsNull(Subdiarios.Detalle,'')+IsNull(' '+(Select Top 1 Cuentas.Descripcion From Cuentas Where Cuentas.IdCuenta=OrdenesPago.IdCuenta),''),1,200)
				Else Case When IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
							Then Substring(IsNull(Subdiarios.Detalle,'')+IsNull(' '+Valores.Detalle COLLATE Modern_Spanish_CI_AS,''),1,200)
							Else Case When #Auxiliar1.A_IdCuenta is not null 
										Then SubString(IsNull(Subdiarios.Detalle,'')+' [ Cuenta : '+Convert(varchar,#Auxiliar1.A_Codigo)+' - Obra : '+Obras.NumeroObra+' ]',1,200)
										Else IsNull(Subdiarios.Detalle,'')
								 End
					 End
		End
	Else ''
  End,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.TipoABC Else IsNull(Facturas.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.TipoABC
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.TipoABC
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.TipoABC Else IsNull(NotasCredito.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteSalidaMateriales Then Null
		Else Case When IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES' Then cp.Letra Else Null End
  End,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.PuntoVenta Else IsNull(Facturas.CuentaVentaPuntoVenta,0) End
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.PuntoVenta
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.PuntoVenta
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.PuntoVenta Else IsNull(NotasCredito.CuentaVentaPuntoVenta,0) End
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Recibos.PuntoVenta
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteSalidaMateriales Then SalidasMateriales.NumeroSalidaMateriales2
		Else Case When IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES' Then cp.NumeroComprobante1	Else Null End
  End,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.NumeroFactura Else IsNull(Facturas.CuentaVentaNumero,0) End
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.NumeroDevolucion
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.NumeroNotaDebito
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.NumeroNotaCredito Else IsNull(NotasCredito.CuentaVentaNumero,0) End
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Recibos.NumeroRecibo
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then OrdenesPago.NumeroOrdenPago
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then DepositosBancarios.NumeroDeposito
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteSalidaMateriales Then SalidasMateriales.NumeroSalidaMateriales
		Else Case When IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES' Then cp.NumeroComprobante2 Else Subdiarios.NumeroComprobante End
  End,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Recibos.IdCliente
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then Null
		Else Null
  End,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then OrdenesPago.IdProveedor
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteSalidaMateriales Then SalidasMateriales.IdProveedor
		Else Case When IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES'
					Then Case When cp.IdProveedor is not null Then cp.IdProveedor Else cp.IdProveedorEventual End
					Else Null
			 End
  End,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Convert(varchar(5000),Facturas.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Convert(varchar(5000),Devoluciones.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Convert(varchar(5000),NotasDebito.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Convert(varchar(5000),NotasCredito.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Convert(varchar(5000),Recibos.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Convert(varchar(5000),OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then Convert(varchar(5000),DepositosBancarios.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteSalidaMateriales Then Convert(varchar(5000),SalidasMateriales.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
		Else Case When IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
					Then IsNull(Bancos.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS,'')
					Else Convert(varchar(5000),cp.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS)
			 End
  End,
  Case When IsNull(Subdiarios.Debe,0)<>0 Then 1 Else 2 End,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.IdObra
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Null
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.IdObra
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.IdObra
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo 
			Then Case When IsNull(Recibos.IdCuenta1,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra1,0)>0 Then Recibos.IdObra1
						When IsNull(Recibos.IdCuenta2,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra2,0)>0 Then Recibos.IdObra2
						When IsNull(Recibos.IdCuenta3,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra3,0)>0 Then Recibos.IdObra3
						When IsNull(Recibos.IdCuenta4,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra4,0)>0 Then Recibos.IdObra4
						When IsNull(Recibos.IdCuenta5,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra5,0)>0 Then Recibos.IdObra5
						When IsNull(Recibos.IdCuenta6,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra6,0)>0 Then Recibos.IdObra6
						When IsNull(Recibos.IdCuenta7,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra7,0)>0 Then Recibos.IdObra7
						When IsNull(Recibos.IdCuenta8,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra8,0)>0 Then Recibos.IdObra8
						When IsNull(Recibos.IdCuenta9,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra9,0)>0 Then Recibos.IdObra9
						When IsNull(Recibos.IdCuenta10,0)=Subdiarios.IdCuenta and IsNull(Recibos.IdObra10,0)>0 Then Recibos.IdObra10
						Else Case When IsNull(Recibos.IdObra,0)>0 Then Recibos.IdObra
									Else (Select Top 1 f.IdObra From DetalleRecibos dr
											Left Outer Join CuentasCorrientesDeudores Cta ON Cta.IdCtaCte=dr.IdImputacion
											Left Outer Join Facturas f ON f.IdFactura=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta
											Where dr.IdRecibo = Recibos.IdRecibo and Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta and f.IdObra is not null)
							 End
				 End
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
			Then Case When Subdiarios.IdDetalleComprobante is not null 
						Then (Select Top 1 Det.IdObra From DetalleOrdenesPagoCuentas Det Where Det.IdDetalleOrdenPagoCuentas=Subdiarios.IdDetalleComprobante)
						Else IsNull((Select Top 1 Det.IdObra From DetalleOrdenesPagoCuentas Det Where Det.IdOrdenPago=Subdiarios.IdComprobante and 
										Det.IdCuenta=Subdiarios.IdCuenta and IsNull(Det.Debe,0)=IsNull(Subdiarios.Debe,0) and IsNull(Det.Haber,0)=IsNull(Subdiarios.Haber,0)),OrdenesPago.IdObra)
				 End
		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then Null
		When Valores.IdObra is not null Then Valores.IdObra
		When IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES' Then IsNull(Cuentas.IdObra,cp.IdObra)
		Else Null
  End,
  Case When IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES' Then cp.InformacionAuxiliar Else Null End
 FROM Subdiarios
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
 LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES'
 LEFT OUTER JOIN Valores ON Valores.IdValor=Subdiarios.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
 LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteSalidaMateriales
 LEFT OUTER JOIN #Auxiliar1 ON Subdiarios.IdCuenta = #Auxiliar1.A_IdCuenta
 LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar1.A_IdObra 
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 WHERE (Subdiarios.IdCuenta=@IdCuenta or #Auxiliar1.A_IdCuenta is not null) and 
		Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta)

IF @IdObra<>-1
	DELETE #Auxiliar2 WHERE IsNull(IdObra,0)<>@IdObra

CREATE TABLE #Auxiliar3
			(
			 A_Id INTEGER IDENTITY (1, 1),
			 IdAux INTEGER,
			 IdCuenta INTEGER,
			 Asiento INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 Tipo VARCHAR(10),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Saldo NUMERIC(18, 2),
			 Detalle VARCHAR(200),
			 Letra VARCHAR(1),
			 NumeroComprobante1 INTEGER,
			 NumeroComprobante2 INTEGER,
			 IdCliente INTEGER,
			 IdProveedor INTEGER,
			 Observaciones VARCHAR(5000),
			 Comprobante VARCHAR(30),
			 IdObra INTEGER,
			 Detalle1 VARCHAR(100)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (Fecha, Comprobante, Asiento, IdComprobante, Debe, Haber) ON [PRIMARY]
IF @DetalleSinAgrupar='SI'
	INSERT INTO #Auxiliar3 
	 SELECT 
	  IdAux,
	  IdCuenta,
	  Asiento,
	  Fecha,
	  IdTipoComprobante,
	  IdComprobante,
	  TipoComprobante,
	  Tipo,
	  IsNull(Debe,0),
	  IsNull(Haber,0),
	  IsNull(Saldo,0),
	  Detalle,
	  Letra,
	  NumeroComprobante1,
	  NumeroComprobante2,
	  IdCliente,
	  IdProveedor,
	  Observaciones,
	  Null,
	  IdObra,
	  Detalle1
	 FROM #Auxiliar2
ELSE
  BEGIN
	UPDATE #Auxiliar2 
	SET Asiento=IsNull(Asiento,0), IdTipoComprobante=IsNull(IdTipoComprobante,0), IdComprobante=IsNull(IdComprobante,0), TipoComprobante=IsNull(TipoComprobante,''), 
		Tipo=IsNull(Tipo,''), IdCliente=IsNull(IdCliente,0), IdProveedor=IsNull(IdProveedor,0), Detalle=IsNull(Detalle,''), Letra=IsNull(Letra,' '), 
		NumeroComprobante1=IsNull(NumeroComprobante1,0), NumeroComprobante2=IsNull(NumeroComprobante2,0), Observaciones=IsNull(Observaciones,''), Detalle1=IsNull(Detalle1,'')

	INSERT INTO #Auxiliar3 
	 SELECT 
	  IdAux,
	  IdCuenta,
	  Asiento,
	  Fecha,
	  IdTipoComprobante,
	  IdComprobante,
	  TipoComprobante,
	  Tipo,
	  SUM(IsNull(Debe,0)),
	  SUM(IsNull(Haber,0)),
	  SUM(IsNull(Saldo,0)),
	  Detalle,
	  Letra,
	  NumeroComprobante1,
	  NumeroComprobante2,
	  IdCliente,
	  IdProveedor,
	  Observaciones,
	  Null,
	  MAX(IsNull(IdObra,0)),
	  Detalle1
	 FROM #Auxiliar2
	 GROUP BY IdAux, IdCuenta, Asiento, Fecha, IdTipoComprobante, IdComprobante, TipoComprobante, Tipo, Detalle, Letra, NumeroComprobante1, 
			  NumeroComprobante2, IdCliente, IdProveedor, Observaciones, DebeHaber, Detalle1 --IdObra, 
  END

UPDATE #Auxiliar3
SET Letra=' '
WHERE Letra IS NULL

UPDATE #Auxiliar3
SET NumeroComprobante1=0
WHERE NumeroComprobante1 IS NULL

UPDATE #Auxiliar3
SET NumeroComprobante2=0
WHERE NumeroComprobante2 IS NULL

UPDATE #Auxiliar3
SET Comprobante=
  Case 	When #Auxiliar3.Letra=' ' and #Auxiliar3.NumeroComprobante1=0 and #Auxiliar3.NumeroComprobante2=0
	 Then #Auxiliar3.TipoComprobante
	 Else Case When Len(Convert(varchar,#Auxiliar3.NumeroComprobante2))<=8
				Then Substring(#Auxiliar3.TipoComprobante+' '+Case When #Auxiliar3.Letra=' ' Then '' Else #Auxiliar3.Letra+'-' End+
						Substring('0000',1,4-Len(Convert(varchar,#Auxiliar3.NumeroComprobante1)))+Convert(varchar,#Auxiliar3.NumeroComprobante1)+'-'+
						Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar3.NumeroComprobante2)))+Convert(varchar,#Auxiliar3.NumeroComprobante2),1,30)
				Else Substring(#Auxiliar3.TipoComprobante+' '+Case When #Auxiliar3.Letra=' ' Then '' Else #Auxiliar3.Letra+'-' End+
						Substring('0000',1,4-Len(Convert(varchar,#Auxiliar3.NumeroComprobante1)))+Convert(varchar,#Auxiliar3.NumeroComprobante1)+'-'+Convert(varchar,#Auxiliar3.NumeroComprobante2),1,30)
			End
  End


/*  CURSOR  */
DECLARE @Debe numeric(18,2), @Haber numeric(18,2), @Saldo numeric(18,2), @SaldoDebe numeric(18,2), @SaldoHaber numeric(18,2), @SaldoIni numeric(18,2), 
		@SaldoIniDebe numeric(18,2), @SaldoIniHaber numeric(18,2), @A_Id int

SET @Saldo=0
SET @SaldoIni=0
SET @SaldoDebe=0
SET @SaldoIniDebe=0
SET @SaldoHaber=0
SET @SaldoIniHaber=0

IF @LineaSaldoInicial<>'NO' or @IdCuentaGasto=0
  BEGIN
	SET @Saldo=IsNull((Select Sum(IsNull(#Auxiliar0.Debe,0))-Sum(IsNull(#Auxiliar0.Haber,0)) From #Auxiliar0),0)
	SET @SaldoIni=@Saldo
	SET @SaldoDebe=IsNull((Select Sum(IsNull(#Auxiliar0.Debe,0)) From #Auxiliar0),0)
	SET @SaldoIniDebe=@SaldoDebe
	SET @SaldoHaber=IsNull((Select Sum(IsNull(#Auxiliar0.Haber,0)) From #Auxiliar0),0)
	SET @SaldoIniHaber=@SaldoHaber
  END

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT A_Id, Debe, Haber FROM #Auxiliar3 ORDER BY Fecha, Comprobante, Asiento, IdComprobante, Debe, Haber, A_Id
OPEN Cur
FETCH NEXT FROM Cur INTO @A_Id, @Debe, @Haber
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @Saldo=@Saldo+(IsNull(@Debe,0)-IsNull(@Haber,0))
	SET @SaldoDebe=@SaldoDebe+IsNull(@Debe,0)
	SET @SaldoHaber=@SaldoHaber+IsNull(@Haber,0)

	UPDATE #Auxiliar3
	SET Saldo = @Saldo
	WHERE A_Id=@A_Id
	
	FETCH NEXT FROM Cur INTO @A_Id, @Debe, @Haber
  END
CLOSE Cur
DEALLOCATE Cur

DECLARE @Registros int
SET @Registros=IsNull((Select Count(*) From #Auxiliar3),0)
--Esto es para que muestre las cuentas sin movimiento en el periodo
If @Registros=0 Set @Registros=1

CREATE TABLE #Auxiliar4	
			(
			 A_IdCuenta INTEGER,
			 A_Codigo INTEGER,
			 A_Descripcion VARCHAR(50),
			 A_NombreAnterior VARCHAR(50),
			 A_CodigoAnterior INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (A_IdCuenta) ON [PRIMARY]
INSERT INTO #Auxiliar4 
 SELECT 
  Cuentas.IdCuenta,
  Cuentas.Codigo,
  Cuentas.Descripcion,
  (Select Top 1 dc.NombreAnterior From DetalleCuentas dc Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta Order By dc.FechaCambio),
  (Select Top 1 dc.CodigoAnterior From DetalleCuentas dc Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta Order By dc.FechaCambio)
 FROM Cuentas 
-- WHERE Cuentas.IdCuenta=@IdCuenta


CREATE TABLE #Auxiliar11 
			(
			 IdComprobante INTEGER,
			 IdTipoComprobante INTEGER,
			 Obras VARCHAR(1000)
			)

CREATE TABLE #Auxiliar12 
			(
			 IdComprobante INTEGER,
			 IdTipoComprobante INTEGER,
			 Obra VARCHAR(13)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar12 ON #Auxiliar12 (IdComprobante, IdTipoComprobante, Obra) ON [PRIMARY]
INSERT INTO #Auxiliar12 
 SELECT #Auxiliar3.IdComprobante, #Auxiliar3.IdTipoComprobante, Obras.NumeroObra
 FROM #Auxiliar3
 LEFT OUTER JOIN DetalleComprobantesProveedores dcp ON dcp.IdComprobanteProveedor = #Auxiliar3.IdComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = dcp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = #Auxiliar3.IdTipoComprobante
 LEFT OUTER JOIN Obras ON Obras.IdObra = dcp.IdObra
 WHERE IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES' and IsNull(dcp.IdObra,0)<>0

INSERT INTO #Auxiliar11 
 SELECT IdComprobante, IdTipoComprobante, ''
 FROM #Auxiliar12
 GROUP BY IdComprobante, IdTipoComprobante

/*  CURSOR  */
DECLARE @IdComprobante1 int, @IdTipoComprobante1 int, @Corte int, @Obra varchar(13), @P varchar(1000)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdComprobante, IdTipoComprobante, Obra FROM #Auxiliar12 ORDER BY IdComprobante, IdTipoComprobante
OPEN Cur
FETCH NEXT FROM Cur INTO @IdComprobante1, @IdTipoComprobante1, @Obra
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @Corte<>@IdComprobante1
	  BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar11
			SET Obras = SUBSTRING(@P,1,1000)
			WHERE IdComprobante=@Corte
		SET @P=''
		SET @Corte=@IdComprobante1
	  END
	IF NOT @Obra IS NULL
		IF PATINDEX('%'+@Obra+' '+'%', @P)=0
			SET @P=@P+@Obra+' '
	FETCH NEXT FROM Cur INTO @IdComprobante1, @IdTipoComprobante1, @Obra
  END
IF @Corte<>0
  BEGIN
	UPDATE #Auxiliar11
	SET Obras = SUBSTRING(@P,1,1000)
	WHERE IdComprobante=@Corte
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT ON

DECLARE @vector_X varchar(50),@vector_T varchar(50),@vector_E varchar(500)
SET @vector_X='000011111166611111511133'
SET @vector_T='0000312419333299A2EA0900'
SET @vector_E='  |  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  |  |  |  |  |'

IF @Registros>0 
  BEGIN
	SELECT
	 0 as [Id0],
	 0 as [Id],
	 @FechaDesde as [Aux_Fecha],
	 0 as [Aux_Id],
	 IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Cuenta],
	 IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion) as [Descripcion],
	 Null as [Asiento],
	 Null as [Fecha],
	 'SDO.INIC. '+Convert(varchar,@FechaDesde,103) as [Comprobante],
	 Null as [Tipo],
	 @SaldoIniDebe as [Debe],
	 @SaldoIniHaber as [Haber],
	 @SaldoIni as [Saldo],
	 Null as [Cliente],
	 Null as [IdTipoComprobante],
	 Null as [IdComprobante],
	 Null as [Obra],
	 Null as [Proveedor],
	 Null as [Detalle],
	 Null as [Observaciones],
	 Null as [Detalle adic.],
	 @vector_E as [Vector_E],
	 @vector_T as [Vector_T],
	 @vector_X as [Vector_X]
	FROM #Auxiliar4
	WHERE #Auxiliar4.A_IdCuenta=@IdCuenta and @LineaSaldoInicial<>'NO'
	
	UNION ALL 
	
	SELECT
	 #Auxiliar3.A_Id as [Id0],
	 #Auxiliar3.IdAux as [Id],
	 #Auxiliar3.Fecha as [Aux_Fecha],
	 #Auxiliar3.A_Id as [Aux_Id],
	 IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Cuenta],
	 Case When #Auxiliar3.Debe is null 
		Then '   '+IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
		Else IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
	 End as [Descripcion],
	 Case When IsNull(#Auxiliar3.Asiento,0)=0 Then Null Else #Auxiliar3.Asiento End as [Asiento],
	 #Auxiliar3.Fecha as [Fecha],
	 #Auxiliar3.Comprobante as [Comprobante],
	 #Auxiliar3.Tipo as [Tipo],
	 #Auxiliar3.Debe as [Debe],
	 #Auxiliar3.Haber as [Haber],
	 #Auxiliar3.Saldo as [Saldo],
	 Clientes.RazonSocial as [Cliente],
	 #Auxiliar3.IdTipoComprobante as [IdTipoComprobante],
	 #Auxiliar3.IdComprobante as [IdComprobante],
	 IsNull(#Auxiliar11.Obras, Obras.NumeroObra) as [Obra],
	 Proveedores.RazonSocial as [Proveedor],
	 #Auxiliar3.Detalle as [Detalle],
	 #Auxiliar3.Observaciones as [Observaciones],
	 #Auxiliar3.Detalle1 as [Detalle adic.],
	 @vector_E as [Vector_E],
	 @vector_T as [Vector_T],
	 @vector_X as [Vector_X]
	FROM #Auxiliar3
	LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar3.IdCuenta=#Auxiliar4.A_IdCuenta
	LEFT OUTER JOIN TiposComprobante ON #Auxiliar3.IdTipoComprobante=TiposComprobante.IdTipoComprobante
	LEFT OUTER JOIN Clientes ON #Auxiliar3.IdCliente=Clientes.IdCliente
	LEFT OUTER JOIN Proveedores ON #Auxiliar3.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN #Auxiliar11 ON #Auxiliar11.IdComprobante=#Auxiliar3.IdComprobante and #Auxiliar11.IdTipoComprobante=#Auxiliar3.IdTipoComprobante
	LEFT OUTER JOIN Obras ON #Auxiliar3.IdObra=Obras.IdObra
	
	UNION ALL 
	
	SELECT
	 0 as [Id0],
	 2 as [Id],
	 @FechaHasta as [Aux_Fecha],
	 0 as [Aux_Id],
	 Null as [Cuenta],
	 Null as [Descripcion],
	 Null as [Asiento],
	 Null as [Fecha],
	 'SDO.FIN. '+Convert(varchar,@FechaHasta,103) as [Comprobante],
	 Null as [Tipo],
	 @SaldoDebe as [Debe],
	 @SaldoHaber as [Haber],
	 @Saldo as [Saldo],
	 Null as [Cliente],
	 Null as [IdTipoComprobante],
	 Null as [IdComprobante],
	 Null as [Obra],
	 Null as [Proveedor],
	 Null as [Detalle],
	 Null as [Observaciones],
	 Null as [Detalle adic.],
	 @vector_E as [Vector_E],
	 @vector_T as [Vector_T],
	 @vector_X as [Vector_X]
	FROM Cuentas
	WHERE Cuentas.IdCuenta=@IdCuenta
	
	UNION ALL 
	
	SELECT
	 0 as [Id0],
	 3 as [Id],
	 @FechaHasta as [Aux_Fecha],
	 0 as [Aux_Id],
	 Null as [Cuenta],
	 Null as [Descripcion],
	 Null as [Asiento],
	 Null as [Fecha],
	 Null as [Comprobante],
	 Null as [Tipo],
	 Null as [Debe],
	 Null as [Haber],
	 Null as [Saldo],
	 Null as [Cliente],
	 Null as [IdTipoComprobante],
	 Null as [IdComprobante],
	 Null as [Obra],
	 Null as [Proveedor],
	 Null as [Detalle],
	 Null as [Observaciones],
	 Null as [Detalle adic.],
	 @vector_E as [Vector_E],
	 @vector_T as [Vector_T],
	 @vector_X as [Vector_X]
	FROM Cuentas
	WHERE Cuentas.IdCuenta=@IdCuenta
	
	ORDER BY [Aux_Fecha], [Id], [Comprobante], [Asiento], [IdComprobante], [Debe], [Haber], [Aux_Id]
  END
ELSE
	SELECT
	 0 as [Id0],
	 9 as [Id],
	 Null as [Aux_Fecha],
	 0 as [Aux_Id],
	 Null as [Cuenta],
	 Null as [Descripcion],
	 Null as [Asiento],
	 Null as [Fecha],
	 Null as [Comprobante],
	 Null as [Tipo],
	 Null as [Debe],
	 Null as [Haber],
	 Null as [Saldo],
	 Null as [Cliente],
	 Null as [IdTipoComprobante],
	 Null as [IdComprobante],
	 Null as [Obra],
	 Null as [Proveedor],
	 Null as [Detalle],
	 Null as [Observaciones],
	 Null as [Detalle adic.],
	 @vector_E as [Vector_E],
	 @vector_T as [Vector_T],
	 @vector_X as [Vector_X]
	FROM #Auxiliar3

/*
SELECT *
FROM #Auxiliar3
ORDER BY Fecha, Comprobante, Asiento, IdComprobante
*/

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12