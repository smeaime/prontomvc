CREATE PROCEDURE [dbo].[InformeDeDiario_TX_2]

@FechaDesde datetime,
@FechaHasta datetime,
@TransporteInicial numeric(18,2),
@AplicarNiveles varchar(3),
@IncluirConsolidacion varchar(2) = Null

AS

SET NOCOUNT ON

IF @IncluirConsolidacion is null 
	SET @IncluirConsolidacion='SI'

DECLARE @DetalleCuentasHijas varchar(2)
SET @DetalleCuentasHijas='NO'

DECLARE @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int,@IdTipoComprobanteOrdenPago int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 Parametros.IdTipoComprobanteFacturaVenta From Parametros Where Parametros.IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 Parametros.IdTipoComprobanteDevoluciones From Parametros Where Parametros.IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 Parametros.IdTipoComprobanteNotaDebito From Parametros Where Parametros.IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 Parametros.IdTipoComprobanteNotaCredito From Parametros Where Parametros.IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 Parametros.IdTipoComprobanteRecibo From Parametros Where Parametros.IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 Parametros.IdTipoComprobanteOrdenPago From Parametros Where Parametros.IdParametro=1)

CREATE TABLE #Auxiliar3
			(
			 IdCuenta INTEGER,
			 IdCuentaMadre INTEGER
			)
INSERT INTO #Auxiliar3 
 SELECT 
  Cuentas.IdCuenta,
  (Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos
	Where CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto)
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
			 Concepto VARCHAR(200),
			 Comprobante VARCHAR(20)
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
  Null
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
	Else Case When #Auxiliar3.IdCuentaMadre is not null 
			Then #Auxiliar3.IdCuentaMadre 
			Else Subdiarios.IdCuenta 
	     End
  End,
  Null,
  Subdiarios.FechaComprobante,
  Subdiarios.IdTipoComprobante,
  Subdiarios.IdComprobante,
  TiposComprobante.DescripcionAb,
  '2-MOV',
  Null,
  Subdiarios.Debe,  Subdiarios.Haber,
  Null,
  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.TipoABC
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
	 Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then Case When cp.IdProveedor is not null Then cp.IdProveedor Else cp.IdProveedorEventual End Else Null End
  End,
  Null,
  Null,
  Null
 FROM Subdiarios
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante
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
			 Then 'AS '+Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.Asiento)))+	Convert(varchar,#Auxiliar1.Asiento)
			When #Auxiliar1.Letra=' ' and #Auxiliar1.NumeroComprobante1=0 and #Auxiliar1.NumeroComprobante2=0
			 Then #Auxiliar1.TipoComprobante
			 Else Substring(#Auxiliar1.TipoComprobante+' '+Case When #Auxiliar1.Letra=' ' Then '' Else #Auxiliar1.Letra+'-' End+
				Substring('0000',1,4-Len(Convert(varchar,#Auxiliar1.NumeroComprobante1)))+Convert(varchar,#Auxiliar1.NumeroComprobante1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.NumeroComprobante2)))+Convert(varchar,#Auxiliar1.NumeroComprobante2),1,30)
		End

UPDATE #Auxiliar1
SET Concepto = 
		Case 	When #Auxiliar1.Comprobante is null
			 Then 	Case 	When #Auxiliar1.IdCliente is not null and #Auxiliar1.Cliente is not null 
					 Then #Auxiliar1.Cliente
					When #Auxiliar1.IdProveedor is not null and #Auxiliar1.Proveedor is not null 
					 Then #Auxiliar1.Proveedor
					When #Auxiliar1.Asiento is not null and #Auxiliar1.Concepto is not null 
					 Then #Auxiliar1.Concepto
					 Else ''
				End
			Else #Auxiliar1.Comprobante + ' ' +
			 	Case 	When #Auxiliar1.IdCliente is not null and #Auxiliar1.Cliente is not null 
					 Then #Auxiliar1.Cliente
					When #Auxiliar1.IdProveedor is not null and #Auxiliar1.Proveedor is not null 
					 Then #Auxiliar1.Proveedor
					When #Auxiliar1.Asiento is not null and #Auxiliar1.Concepto is not null 
					 Then #Auxiliar1.Concepto
					 Else ''
				End
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
			 Concepto VARCHAR(200),
			 Comprobante VARCHAR(20)
			)
INSERT INTO #Auxiliar2 
 SELECT IdAux, IdCuenta, Asiento, Fecha, IdTipoComprobante, IdComprobante, TipoComprobante, TipoAsiento, Tipo, Sum(IsNull(Debe,0)), Sum(IsNull(Haber,0)), 
	Detalle, Letra, NumeroComprobante1, NumeroComprobante2, IdCliente, Cliente, IdProveedor, Proveedor, Concepto, Comprobante
 FROM #Auxiliar1 
 GROUP BY IdAux, IdCuenta, Asiento, Fecha, IdTipoComprobante, IdComprobante, TipoComprobante, TipoAsiento, Tipo, Detalle, Letra, NumeroComprobante1, 
	NumeroComprobante2, IdCliente, Cliente, IdProveedor, Proveedor, Concepto, Comprobante

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

SET NOCOUNT ON

DECLARE @NumeroAsiento int
SET @NumeroAsiento=0

DECLARE @vector_X varchar(30), @vector_T varchar(30), @vector_E varchar(30)
SET @vector_X='00000001111166133'
SET @vector_T='00000004223233900'
SET @vector_E='  |  |  |  |  |  '

SELECT
 1 as [Id],
 Fecha as [K_Fecha],
 TipoAsiento as [K_TipoAsiento],
 IdTipoComprobante as [K_IdTipoComprobante],
 IdComprobante as [K_IdComprobante],
 Asiento as [K_Asiento],
 1 as [K_Orden],
 Fecha as [Fecha],
 @NumeroAsiento as [Numero],
 Concepto as [Concepto],
 Null as [Cuenta],
 Null as [Descripcion],
 Null as [Debe],
 Null as [Haber],
 ' BOL,ITA | BOL,ITA | BOL,ITA |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
GROUP BY Fecha, TipoAsiento, Asiento, IdTipoComprobante, IdComprobante, Concepto, Comprobante

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar2.Fecha as [K_Fecha],
 #Auxiliar2.TipoAsiento as [K_TipoAsiento],
 #Auxiliar2.IdTipoComprobante as [K_IdTipoComprobante],
 #Auxiliar2.IdComprobante as [K_IdComprobante],
 #Auxiliar2.Asiento as [K_Asiento],
 2 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 #Auxiliar2.Detalle as [Concepto],
 IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Cuenta],
 Case	When #Auxiliar2.Debe is null Then '   '+IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
	Else IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
 End as [Descripcion],
 #Auxiliar2.Debe as [Debe],
 #Auxiliar2.Haber as [Haber],
 '  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar2.IdCuenta=#Auxiliar4.A_IdCuenta

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz1' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_Asiento],
 3 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 Null as [Concepto],
 Null as [Cuenta],
 Null as [Descripcion],
 Null as [Debe],
 Null as [Haber],
 '  |  | BOL |  | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz2' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_Asiento],
 4 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 'TOTALES GENERALES' as [Concepto],
 Null as [Cuenta],
 Null as [Descripcion],
 SUM(IsNull(Debe,0))+@TransporteInicial as [Debe],
 SUM(IsNull(Haber,0))+@TransporteInicial as [Haber],
 '  |  | BOL |  | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2

ORDER BY [K_Fecha], [K_TipoAsiento], [K_IdTipoComprobante], [K_IdComprobante], [K_Asiento], [K_Orden], [Haber], [Debe]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4