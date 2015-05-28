CREATE PROCEDURE [dbo].[InformeDeDiario_TX_2_Modelo2]

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

Declare @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteDevoluciones int,
	@IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int,@IdTipoComprobanteOrdenPago int

Set @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
Set @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
Set @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
Set @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
Set @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
Set @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)

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
			 Comprobante VARCHAR(20)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  1,
  DetAsi.IdCuenta,
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
 WHERE Asientos.IdCuentaSubdiario is null and
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta) and 
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL

 SELECT
  1,
  Subdiarios.IdCuenta,
  Null,
  Subdiarios.FechaComprobante,
  Subdiarios.IdTipoComprobante,
  Subdiarios.IdComprobante,
  Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then TiposComprobante.DescripcionAb Else 'CV' End,
  '2-MOV',
  Null,
  Subdiarios.Debe,
  Subdiarios.Haber,
  Null,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.TipoABC Else IsNull(Facturas.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.TipoABC
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.TipoABC
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.TipoABC Else IsNull(NotasCredito.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null 
	Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then cp.Letra Else Null End
  End,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.PuntoVenta Else IsNull(Facturas.CuentaVentaPuntoVenta,0) End
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.PuntoVenta
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.PuntoVenta
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.PuntoVenta Else IsNull(NotasCredito.CuentaVentaPuntoVenta,0) End
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null 
	Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then cp.NumeroComprobante1 Else Null End
  End,
  Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.NumeroFactura Else IsNull(Facturas.CuentaVentaNumero,0) End
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.NumeroDevolucion
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.NumeroNotaDebito
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.NumeroNotaCredito Else IsNull(NotasCredito.CuentaVentaNumero,0) End
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
WHERE Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta)

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
SET Cliente=(Select Top 1 Clientes.RazonSocial From Clientes 
		Where #Auxiliar1.IdCliente=Clientes.IdCliente)
WHERE #Auxiliar1.IdCliente IS NOT NULL

UPDATE #Auxiliar1
SET Proveedor=(Select Top 1 Proveedores.RazonSocial From Proveedores 
		Where #Auxiliar1.IdProveedor=Proveedores.IdProveedor)
WHERE #Auxiliar1.IdProveedor IS NOT NULL

UPDATE #Auxiliar1
SET Comprobante = 
		Case 	When #Auxiliar1.Asiento is not null
			 Then 'AS '+Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.Asiento)))+Convert(varchar,#Auxiliar1.Asiento)
			When #Auxiliar1.Letra=' ' and #Auxiliar1.NumeroComprobante1=0 and #Auxiliar1.NumeroComprobante2=0
			 Then #Auxiliar1.TipoComprobante
			 Else Substring(#Auxiliar1.TipoComprobante+' '+Case When #Auxiliar1.Letra=' ' Then '' Else #Auxiliar1.Letra+'-' End+
				Substring('0000',1,4-Len(Convert(varchar,#Auxiliar1.NumeroComprobante1)))+Convert(varchar,#Auxiliar1.NumeroComprobante1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.NumeroComprobante2)))+Convert(varchar,#Auxiliar1.NumeroComprobante2),1,30)
		End

UPDATE #Auxiliar1
SET Concepto = 
		Case 	When #Auxiliar1.Comprobante is null
			 Then 	Case 	When #Auxiliar1.IdCliente is not null and #Auxiliar1.Cliente is not null Then #Auxiliar1.Cliente
					When #Auxiliar1.IdProveedor is not null and #Auxiliar1.Proveedor is not null Then #Auxiliar1.Proveedor
					When #Auxiliar1.Asiento is not null and #Auxiliar1.Concepto is not null Then #Auxiliar1.Concepto
					 Else ''
				End
			Else #Auxiliar1.Comprobante + ' ' +
			 	Case 	When #Auxiliar1.IdCliente is not null and #Auxiliar1.Cliente is not null Then #Auxiliar1.Cliente
					When #Auxiliar1.IdProveedor is not null and #Auxiliar1.Proveedor is not null Then #Auxiliar1.Proveedor
					When #Auxiliar1.Asiento is not null and #Auxiliar1.Concepto is not null Then #Auxiliar1.Concepto
					 Else ''
				End
		End

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

DECLARE @NumeroAsiento int,@vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(200)

SET @NumeroAsiento=0
SET @vector_X='0000000111166133'
SET @vector_T='0000000420033900'
SET @vector_E='  |  |  |  |  |  '

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.TipoAsiento as [K_TipoAsiento],
 #Auxiliar1.IdTipoComprobante as [K_IdTipoComprobante],
 #Auxiliar1.IdComprobante as [K_IdComprobante],
 #Auxiliar1.Asiento as [K_Asiento],
 1 as [K_Orden],
 #Auxiliar1.Fecha as [Fecha],
 @NumeroAsiento as [Numero],
 Substring(#Auxiliar1.Concepto,1,70) as [Nombre de la cuenta],
 Substring(Space(100),1,60) as [Detalle],
 Null as [Debe],
 Null as [Haber],
 ' EBH,BOL,ITA | BOL,ITA | BOL,ITA |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY #Auxiliar1.Fecha, #Auxiliar1.TipoAsiento, #Auxiliar1.Asiento, #Auxiliar1.IdTipoComprobante, #Auxiliar1.IdComprobante, #Auxiliar1.Concepto, #Auxiliar1.Comprobante

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.TipoAsiento as [K_TipoAsiento],
 #Auxiliar1.IdTipoComprobante as [K_IdTipoComprobante],
 #Auxiliar1.IdComprobante as [K_IdComprobante],
 #Auxiliar1.Asiento as [K_Asiento],
 2 as [K_Orden],
 Null as [Fecha],
 IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Numero],
 Case	When #Auxiliar1.Debe is null Then '   '+IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
	Else IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
 End as [Nombre de la cuenta],
 #Auxiliar1.Detalle as [Detalle],
 #Auxiliar1.Debe as [Debe],
 #Auxiliar1.Haber as [Haber],
 '  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar1.IdCuenta=#Auxiliar4.A_IdCuenta

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.TipoAsiento as [K_TipoAsiento],
 #Auxiliar1.IdTipoComprobante as [K_IdTipoComprobante],
 #Auxiliar1.IdComprobante as [K_IdComprobante],
 #Auxiliar1.Asiento as [K_Asiento],
 3 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 Null as [Nombre de la cuenta],
 Null as [Detalle],
 SUM(#Auxiliar1.Debe) as [Debe],
 SUM(#Auxiliar1.Haber) as [Haber],
 ' LNI |  |  |  | BDS NOSUMAR | BDS NOSUMAR ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY #Auxiliar1.Fecha, #Auxiliar1.TipoAsiento, #Auxiliar1.Asiento, #Auxiliar1.IdTipoComprobante, #Auxiliar1.IdComprobante, #Auxiliar1.Concepto, #Auxiliar1.Comprobante

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zzzz' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_Asiento],
 5 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 Null as [Nombre de la cuenta],
 Null as [Detalle],
 Null as [Debe],
 Null as [Haber],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zzzzz' as [K_TipoAsiento],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_Asiento],
 6 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 'TOTALES GENERALES' as [Nombre de la cuenta],
 Null as [Detalle],
 SUM(#Auxiliar1.Debe)+@TransporteInicial as [Debe],
 SUM(#Auxiliar1.Haber)+@TransporteInicial as [Haber],
 '  |  | BOL |  | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Fecha], [K_TipoAsiento], [K_IdTipoComprobante], [K_IdComprobante], [K_Asiento], [K_Orden]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar4