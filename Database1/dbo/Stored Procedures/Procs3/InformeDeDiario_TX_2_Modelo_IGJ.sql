CREATE PROCEDURE [dbo].[InformeDeDiario_TX_2_Modelo_IGJ]

@FechaDesde datetime,
@FechaHasta datetime,
@TransporteInicial numeric(18,2),
@AplicarNiveles varchar(3),
@IncluirConsolidacion varchar(2) = Null

AS

SET NOCOUNT ON

SET DATEFORMAT dmy

IF @IncluirConsolidacion is null 
	SET @IncluirConsolidacion='SI'

DECLARE @DetalleCuentasHijas varchar(2)
SET @DetalleCuentasHijas='SI'

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int, @IdTipoComprobanteDeposito int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDeposito=(Select Top 1 IdTipoComprobanteDeposito From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar3
			(
			 IdCuenta INTEGER,
			 IdCuentaMadre INTEGER
			)
INSERT INTO #Auxiliar3 
 SELECT Cuentas.IdCuenta, (Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto)
 FROM Cuentas 
 WHERE Cuentas.IdCuentaGasto IS NOT NULL


CREATE TABLE #Auxiliar1
			(
			 IdAux INTEGER,
			 IdCuenta INTEGER,
			 Asiento INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 TipoAsiento VARCHAR(5),
			 Tipo VARCHAR(10),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Detalle VARCHAR(100),
			 Letra VARCHAR(1),
			 NumeroComprobante1 INTEGER,
			 NumeroComprobante2 INTEGER,
			 IdCliente INTEGER,
			 Cliente VARCHAR(100),
			 IdProveedor INTEGER,
			 Proveedor VARCHAR(100),
			 Concepto VARCHAR(100),
			 Comprobante VARCHAR(20),
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  1,
  Case When @DetalleCuentasHijas='SI' 
	Then DetAsi.IdCuenta 
	Else Case When #Auxiliar3.IdCuentaMadre is not null Then #Auxiliar3.IdCuentaMadre Else DetAsi.IdCuenta End
  End,
  Asientos.NumeroAsiento,
  Asientos.FechaAsiento,
  DetAsi.IdTipoComprobante,
  Null,
  TiposComprobante.DescripcionAb,
  Case 	When Substring(IsNull(Asientos.Tipo,'   '),1,3)='APE' Then '1-APE'
	When Substring(IsNull(Asientos.Tipo,'   '),1,3)='   ' Then '2-MOV'
	When Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' Then '3-CIE'
  End,
  DetAsi.Libro+' '+DetAsi.TipoImporte+' '+DetAsi.Signo,
  DetAsi.Debe,
  DetAsi.Haber,
  DetAsi.Detalle,
  ' ',
  0,
  DetAsi.NumeroComprobante,
  Null,
  Null,
  Null,
  Null,
  Asientos.Concepto,
  Null,
  DetAsi.IdObra
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN TiposComprobante ON DetAsi.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdCuenta=DetAsi.IdCuenta
 WHERE Asientos.IdCuentaSubdiario is null and
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta) and 
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL

 SELECT
  1,
  Case When @DetalleCuentasHijas='SI' 
	Then Subdiarios.IdCuenta 
	Else Case When #Auxiliar3.IdCuentaMadre is not null Then #Auxiliar3.IdCuentaMadre Else Subdiarios.IdCuenta End
  End,
  Null,
  Subdiarios.FechaComprobante,
  Subdiarios.IdTipoComprobante,
  Subdiarios.IdComprobante,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
	 Then Case When IsNull(NotasDebito.CtaCte,'SI')='SI' Then 'ND' Else 'NDI' End
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
	 Then Case When IsNull(NotasCredito.CtaCte,'SI')='SI' Then 'NC' Else 'NCI' End
	Else TiposComprobante.DescripcionAb
  End,
  '2-MOV',
  Null,
  Subdiarios.Debe,  Subdiarios.Haber,
  Null,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.TipoABC
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.TipoABC
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.TipoABC
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.TipoABC
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
	Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then cp.Letra Else Null End
  End,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.PuntoVenta
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.PuntoVenta
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.PuntoVenta
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.PuntoVenta
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
	Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then cp.NumeroComprobante1 Else Null End
  End,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.NumeroFactura
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.NumeroDevolucion
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.NumeroNotaDebito
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.NumeroNotaCredito
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Recibos.NumeroRecibo
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then OrdenesPago.NumeroOrdenPago
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then DepositosBancarios.NumeroDeposito
	Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then cp.NumeroComprobante2 Else Subdiarios.NumeroComprobante End
  End,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.IdCliente
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.IdCliente
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.IdCliente
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.IdCliente
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Recibos.IdCliente
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
	Else Null
  End,
  Null,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then OrdenesPago.IdProveedor
	 Else 	Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' and TiposComprobante.DescripcionAb<>'GA'
			Then 	Case When cp.IdProveedor is not null
					Then cp.IdProveedor
					Else cp.IdProveedorEventual
				End
			Else Null
		End
  End,
  Null,
  Case When OrdenesPago.IdCuenta is not null Then (Select Top 1 C.Descripcion From Cuentas C Where C.IdCuenta=OrdenesPago.IdCuenta)
	When cp.IdCuenta is not null Then (Select Top 1 C.Descripcion From Cuentas C Where C.IdCuenta=cp.IdCuenta)
	Else Bancos.Nombre
  End,
  Null,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.IdObra
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.IdObra
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.IdObra
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Recibos.IdObra
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
	Then IsNull((Select Top 1 Det.IdObra From DetalleOrdenesPagoCuentas Det Where Det.IdOrdenPago=Subdiarios.IdComprobante and Det.IdCuenta=Subdiarios.IdCuenta and 
				IsNull(Det.Debe,0)=IsNull(Subdiarios.Debe,0) and IsNull(Det.Haber,0)=IsNull(Subdiarios.Haber,0)),OrdenesPago.IdObra)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDeposito Then Null
	When cp.IdObra is not null Then cp.IdObra
	Else Null
  End
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
 LEFT OUTER JOIN Valores ON Valores.IdValor=Subdiarios.IdComprobante
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdCuenta=Subdiarios.IdCuenta
 WHERE Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta) and 
	(IsNull(Subdiarios.Debe,0)<>0 or IsNull(Subdiarios.Haber,0)<>0)

UPDATE #Auxiliar1
SET Letra=' '
WHERE Letra IS NULL

UPDATE #Auxiliar1
SET NumeroComprobante1=0
WHERE NumeroComprobante1 IS NULL

UPDATE #Auxiliar1
SET NumeroComprobante2=0
WHERE NumeroComprobante2 IS NULL

UPDATE #Auxiliar1
SET NumeroComprobante1=0
WHERE Len(Convert(varchar,NumeroComprobante1))>4

UPDATE #Auxiliar1
SET NumeroComprobante2=0
WHERE Len(Convert(varchar,NumeroComprobante2))>8

UPDATE #Auxiliar1
SET Cliente=(Select Top 1 Clientes.RazonSocial From Clientes Where #Auxiliar1.IdCliente=Clientes.IdCliente)
WHERE #Auxiliar1.IdCliente IS NOT NULL

UPDATE #Auxiliar1
SET Proveedor=(Select Top 1 Proveedores.RazonSocial From Proveedores Where #Auxiliar1.IdProveedor=Proveedores.IdProveedor)
WHERE #Auxiliar1.IdProveedor IS NOT NULL

UPDATE #Auxiliar1
SET Comprobante = 
		Case When #Auxiliar1.Asiento is not null
			 Then 'AS '+Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.Asiento)))+Convert(varchar,#Auxiliar1.Asiento)
			When #Auxiliar1.Letra=' ' and #Auxiliar1.NumeroComprobante1=0 and #Auxiliar1.NumeroComprobante2=0
			 Then #Auxiliar1.TipoComprobante
			 Else Substring(#Auxiliar1.TipoComprobante+' '+Case When #Auxiliar1.Letra=' ' Then '' Else #Auxiliar1.Letra+'-' End+
				Substring('0000',1,4-Len(Convert(varchar,#Auxiliar1.NumeroComprobante1)))+Convert(varchar,#Auxiliar1.NumeroComprobante1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.NumeroComprobante2)))+Convert(varchar,#Auxiliar1.NumeroComprobante2),1,30)
		End

UPDATE #Auxiliar1
SET Concepto = Case When #Auxiliar1.IdCliente is not null and #Auxiliar1.Cliente is not null Then #Auxiliar1.Cliente
			When #Auxiliar1.IdProveedor is not null and #Auxiliar1.Proveedor is not null Then #Auxiliar1.Proveedor
			Else IsNull(#Auxiliar1.Concepto,'')
		End

CREATE TABLE #Auxiliar2 
			(
			 IdAux INTEGER,
			 IdCuenta INTEGER,
			 Asiento INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 TipoAsiento VARCHAR(5),
			 Tipo VARCHAR(10),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Detalle VARCHAR(100),
			 Letra VARCHAR(1),
			 NumeroComprobante1 INTEGER,
			 NumeroComprobante2 INTEGER,
			 IdCliente INTEGER,
			 Cliente VARCHAR(100),
			 IdProveedor INTEGER,
			 Proveedor VARCHAR(100),
			 Concepto VARCHAR(100),
			 Comprobante VARCHAR(20),
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT IdAux, IdCuenta, Asiento, Fecha, IdTipoComprobante, IdComprobante, TipoComprobante, TipoAsiento, Tipo, Sum(IsNull(Debe,0)), Sum(IsNull(Haber,0)), 
	Detalle, Letra, NumeroComprobante1, NumeroComprobante2, IdCliente, Cliente, IdProveedor, Proveedor, Concepto, Comprobante, IdObra
 FROM #Auxiliar1  GROUP BY IdAux, IdCuenta, Asiento, Fecha, IdTipoComprobante, IdComprobante, TipoComprobante, TipoAsiento, Tipo, Detalle, Letra, NumeroComprobante1, 
	NumeroComprobante2, IdCliente, Cliente, IdProveedor, Proveedor, Concepto, Comprobante, IdObra

CREATE TABLE #Auxiliar4	
			(
			 A_IdCuenta INTEGER,
			 A_Codigo INTEGER,
			 A_Descripcion VARCHAR(50),
			 A_NombreAnterior VARCHAR(50),
			 A_CodigoAnterior INTEGER
			)
INSERT INTO #Auxiliar4 
 SELECT 
  Cuentas.IdCuenta,
  Cuentas.Codigo,
  Cuentas.Descripcion,
  (Select Top 1 dc.NombreAnterior From DetalleCuentas dc Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta Order By dc.FechaCambio),
  (Select Top 1 dc.CodigoAnterior From DetalleCuentas dc Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta Order By dc.FechaCambio)
 FROM Cuentas 

CREATE TABLE #Auxiliar5	
			(
			 NumeroObra VARCHAR(13),
			 Descripcion VARCHAR(100)
			)
INSERT INTO #Auxiliar5 
 SELECT Obras.NumeroObra, Obras.Descripcion
 FROM #Auxiliar2
 LEFT OUTER JOIN Obras ON #Auxiliar2.IdObra=Obras.IdObra
 GROUP BY Obras.NumeroObra, Obras.Descripcion
 ORDER BY Obras.NumeroObra, Obras.Descripcion

SET NOCOUNT ON
DECLARE @NumeroAsiento int
SET @NumeroAsiento=0

DECLARE @vector_X varchar(30), @vector_T varchar(30), @vector_E varchar(30)
SET @vector_X='00000000111111166133'
SET @vector_T='00000000462032633900'
SET @vector_E='  |  |  |  |  |  |  |  '

SELECT
 1 as [Id],
 Null as [K_Fecha],
 Null as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 0 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 Null as [TERCERO N°],
 Null as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 Null as [DEBITO],
 Null as [CREDITO],
 ' FN1:10 | EBH | BDT | FinTransporte |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar2.Fecha as [K_Fecha],
 #Auxiliar2.TipoAsiento as [K_TipoAsiento],
 #Auxiliar2.IdTipoComprobante as [K_IdTipoComprobante],
 #Auxiliar2.IdComprobante as [K_IdComprobante],
 #Auxiliar2.Comprobante as [K_NumeroComprobante],
 #Auxiliar2.Asiento as [K_Asiento],
 1 as [K_Orden],
 #Auxiliar2.Fecha as [FECHA],
 #Auxiliar2.Comprobante as [COMPROBANTE],
 IsNull(Clientes.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS,Proveedores.CodigoEmpresa COLLATE SQL_Latin1_General_CP1_CI_AS) as [TERCERO N°],
 #Auxiliar2.Concepto COLLATE SQL_Latin1_General_CP1_CI_AS as [TERCERO - NOMBRE],
 Convert(varchar,IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo)) as [CTA N°],
 Case When #Auxiliar2.Debe is null Then '   '+IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
	Else IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
 End as [CUENTA - NOMBRE],
 Obras.NumeroObra as [CENTRO DE COSTO N°],
 #Auxiliar2.Debe as [DEBITO],
 #Auxiliar2.Haber as [CREDITO],
 '  |  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar2.IdCuenta=#Auxiliar4.A_IdCuenta
LEFT OUTER JOIN Clientes ON #Auxiliar2.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON #Auxiliar2.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Obras ON #Auxiliar2.IdObra=Obras.IdObra

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar2.Fecha as [K_Fecha],
 #Auxiliar2.TipoAsiento as [K_TipoAsiento],
 #Auxiliar2.IdTipoComprobante as [K_IdTipoComprobante],
 #Auxiliar2.IdComprobante as [K_IdComprobante],
 #Auxiliar2.Comprobante as [K_NumeroComprobante],
 #Auxiliar2.Asiento as [K_Asiento],
 2 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 Null as [TERCERO N°],
 Null as [TERCERO - NOMBRE],
 'Total asiento' as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 SUM(IsNull(#Auxiliar2.Debe,0))+@TransporteInicial as [DEBITO],
 SUM(IsNull(#Auxiliar2.Haber,0))+@TransporteInicial as [CREDITO],
 ' LNI:2 |  |  |  | BOL |  |  | NUM:#COMMA##0.00,BOL | NUM:#COMMA##0.00,BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
GROUP BY #Auxiliar2.Fecha, #Auxiliar2.TipoAsiento, #Auxiliar2.IdTipoComprobante, 
	#Auxiliar2.IdComprobante, #Auxiliar2.Asiento, #Auxiliar2.Comprobante

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 4 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 Null as [TERCERO N°],
 Null as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 'TOTAL DEL MES' as [CENTRO DE COSTO N°],
 SUM(IsNull(#Auxiliar2.Debe,0))+@TransporteInicial as [DEBITO],
 SUM(IsNull(#Auxiliar2.Haber,0))+@TransporteInicial as [CREDITO],
 ' BDV |  |  |  | BOL |  |  | NUM:#COMMA##0.00,BOL | NUM:#COMMA##0.00,BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 5 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 Null as [TERCERO N°],
 Null as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 Null as [DEBITO],
 Null as [CREDITO],
 '  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 6 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 Null as [TERCERO N°],
 'SIGNIFICADO DE CODIGOS DE CENTRO DE COSTOS' as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 Null as [DEBITO],
 Null as [CREDITO],
 ' COM:0:2:0:3 |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 7 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 Null as [TERCERO N°],
 '----------------------------------------------------------------------------------------' as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 Null as [DEBITO],
 Null as [CREDITO],
 ' COM:0:2:0:3 |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 8 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 'N°' as [TERCERO N°],
 'NOMBRE' as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 Null as [DEBITO],
 Null as [CREDITO],
 '  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 9 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 #Auxiliar5.NumeroObra COLLATE SQL_Latin1_General_CP1_CI_AS as [TERCERO N°],
 #Auxiliar5.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 Null as [DEBITO],
 Null as [CREDITO],
 '  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar5
WHERE Len(IsNull(#Auxiliar5.NumeroObra,''))>0

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 10 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 Null as [TERCERO N°],
 Null as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 Null as [DEBITO],
 Null as [CREDITO],
 '  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_NumeroComprobante],
 Null as [K_Asiento],
 11 as [K_Orden],
 Null as [FECHA],
 Null as [COMPROBANTE],
 Null as [TERCERO N°],
 'FIN DEL REGISTRO' as [TERCERO - NOMBRE],
 Null as [CTA N°],
 Null as [CUENTA - NOMBRE],
 Null as [CENTRO DE COSTO N°],
 Null as [DEBITO],
 Null as [CREDITO],
 ' COM:0:0:0:8,CEN |  | ANC:13 | ANC:47 |  | ANC:38 | ANC:12 |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

ORDER BY [K_Fecha], [K_NumeroComprobante], [K_TipoAsiento], [K_IdTipoComprobante], [K_IdComprobante], [K_Asiento], [K_Orden], [CREDITO], [DEBITO]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5