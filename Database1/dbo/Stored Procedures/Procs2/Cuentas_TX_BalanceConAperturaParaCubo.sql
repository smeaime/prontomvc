CREATE Procedure [dbo].[Cuentas_TX_BalanceConAperturaParaCubo]

@Desde varchar(10),
@Hasta varchar(10),
@FechaDesde datetime,
@FechaHasta datetime,
@EjercicioInicio int,
@FechaInicioEjercicio datetime,
@Dts varchar(200),
@IncluirCierre varchar(2),
@IncluirApertura varchar(2),
@IncluirConsolidacion varchar(2) = Null

AS 

SET NOCOUNT ON

SET @IncluirConsolidacion=IsNull(@IncluirConsolidacion,'SI')

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
	@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int, @Resultado int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)

TRUNCATE TABLE _TempCuboBalance
INSERT INTO _TempCuboBalance 
(Jerarquia1, Jerarquia2, Jerarquia3, Jerarquia4, Cuenta, Detalle, SaldoInicial, SaldoDeudorPeriodo, SaldoAcreedorPeriodo, SaldoPeriodo, SaldoFinal)
VALUES
('1', '1', '1', '1', '1', '1', 0, 0, 0, 0, 0)
EXEC @Resultado=master..xp_cmdshell @Dts

CREATE TABLE #Auxiliar10
			(
			 Descripcion VARCHAR(50),
			 Jerarquia VARCHAR(20),
			 Jerarquia1 VARCHAR(1),
			 Jerarquia2 VARCHAR(3),
			 Jerarquia3 VARCHAR(6),
			 Jerarquia4 VARCHAR(9)
			)

INSERT INTO #Auxiliar10
 SELECT  
  IsNull((Select Top 1 dc.NombreAnterior From DetalleCuentas dc 
		Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),C.Descripcion),
  IsNull((Select Top 1 dc.JerarquiaAnterior From DetalleCuentas dc 
		Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),C.Jerarquia),
  '','','',''
 FROM Cuentas C 

UPDATE #Auxiliar10
SET Jerarquia1=Substring(Jerarquia,1,1), Jerarquia2=Substring(Jerarquia,1,3), Jerarquia3=Substring(Jerarquia,1,6), Jerarquia4=Substring(Jerarquia,1,9)

UPDATE #Auxiliar10
SET Descripcion=(Select Top 1 Cuentas.Descripcion From Cuentas Where Cuentas.Jerarquia COLLATE Modern_Spanish_CI_AS=#Auxiliar10.Jerarquia and Len(IsNull(Cuentas.Descripcion,''))>0)
WHERE Len(IsNull(Descripcion,''))=0

CREATE TABLE #Auxiliar11
			(
			 Descripcion VARCHAR(50),
			 Jerarquia1 VARCHAR(1)
			)
INSERT INTO #Auxiliar11
 SELECT Null, #Auxiliar10.Jerarquia1
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia1

UPDATE #Auxiliar11
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia1=#Auxiliar11.Jerarquia1
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar12
			(
			 Descripcion VARCHAR(50),
			 Jerarquia2 VARCHAR(3)
			)
INSERT INTO #Auxiliar12
 SELECT Null, #Auxiliar10.Jerarquia2
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia2

UPDATE #Auxiliar12
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia2=#Auxiliar12.Jerarquia2
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar13
			(
			 Descripcion VARCHAR(50),
			 Jerarquia3 VARCHAR(6)
			)
INSERT INTO #Auxiliar13
 SELECT Null, #Auxiliar10.Jerarquia3
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia3

UPDATE #Auxiliar13
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia3=#Auxiliar13.Jerarquia3
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar14
			(
			 Descripcion VARCHAR(50),
			 Jerarquia4 VARCHAR(9)
			)
INSERT INTO #Auxiliar14
 SELECT Null, #Auxiliar10.Jerarquia4
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.Jerarquia4

UPDATE #Auxiliar14
SET Descripcion=(Select Top 1 #Auxiliar10.Descripcion From #Auxiliar10 
		 Where #Auxiliar10.Jerarquia4=#Auxiliar14.Jerarquia4
		 Order By #Auxiliar10.Jerarquia)


CREATE TABLE #Auxiliar0
			(
			 IdCuenta INTEGER,
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
  IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),C.Codigo),
  IsNull((Select Top 1 dc.NombreAnterior 		From DetalleCuentas dc 
		Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),C.Descripcion),
  IsNull((Select Top 1 dc.JerarquiaAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),C.Jerarquia),
  Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,1,1)+' - '+#Auxiliar11.Descripcion,
  Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,3,1)+' - '+#Auxiliar12.Descripcion,
  Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,5,2)+' - '+#Auxiliar13.Descripcion,
  Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,8,2)+' - '+#Auxiliar14.Descripcion
/*
  Case When Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,1,1)<'6'  	Then Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,8,2)+' - '+#Auxiliar14.Descripcion
  	Else Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,8,2)+' - '+#Auxiliar13.Descripcion
  End
*/
 FROM Cuentas C 
 LEFT OUTER JOIN #Auxiliar11 ON #Auxiliar11.Jerarquia1=Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,1,1)
 LEFT OUTER JOIN #Auxiliar12 ON #Auxiliar12.Jerarquia2=Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,1,3)
 LEFT OUTER JOIN #Auxiliar13 ON #Auxiliar13.Jerarquia3=Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,1,6)
 LEFT OUTER JOIN #Auxiliar14 ON #Auxiliar14.Jerarquia4=Substring(C.Jerarquia COLLATE Modern_Spanish_CI_AS,1,9)
 WHERE 	Not (Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
			 Order By dc.FechaCambio),'S/D'))=0 and C.IdTipoCuenta=1) and 

	(Len(IsNull(C.Descripcion,''))>0 or 
	 (Len(IsNull(C.Descripcion,''))=0 and 
	  Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
			 Order By dc.FechaCambio),''))>0))
 

CREATE TABLE #Auxiliar1
			(
			 A_IdCuenta INTEGER,
			 A_Fecha DATETIME,
			 A_TipoComprobante VARCHAR(5),
			 A_Letra VARCHAR(1),
			 A_NumeroComprobante1 INTEGER,
			 A_NumeroComprobante2 INTEGER,
			 A_IdCliente INTEGER,
			 A_IdProveedor INTEGER,
			 A_Detalle VARCHAR(35),
			 A_Debe NUMERIC(18, 2),
			 A_Haber NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar1 
 SELECT 
  DetAsi.IdCuenta,
  DetAsi.FechaComprobante,
  IsNull(TiposComprobante.DescripcionAb,'AS'),
  '',
  0,
  IsNull(DetAsi.NumeroComprobante,Asientos.NumeroAsiento),
  Null,
  Null,
  '',
  Case When DetAsi.Debe is not null Then Round(DetAsi.Debe,2) Else 0 End,
  Case When DetAsi.Haber is not null Then Round(DetAsi.Haber,2) Else 0 End
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN TiposComprobante ON DetAsi.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE Asientos.IdCuentaSubdiario is null and 
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta and 
	(@IncluirCierre='SI' or Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'CIE') and 
/*
	(@IncluirCierre='SI' or 
		(@IncluirCierre='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta)))) and 
*/
	(@IncluirApertura='SI' or Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'APE') and 
/*
	(@IncluirApertura='SI' or 
		(@IncluirApertura='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='APE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta)))) and 
*/
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL 

 SELECT 
  Sub.IdCuenta,
  Sub.FechaComprobante,
  TiposComprobante.DescripcionAb,
  Case 	When Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.TipoABC
	When Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.TipoABC
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.TipoABC
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.TipoABC
	When Sub.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
	When Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
	 Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then cp.Letra Else Null End
  End,
  Case 	When Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.PuntoVenta
	When Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.PuntoVenta
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.PuntoVenta
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.PuntoVenta
	When Sub.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
	When Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
	 Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then cp.NumeroComprobante1 Else Null End
  End,
  Case 	When Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.NumeroFactura
	When Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.NumeroDevolucion
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.NumeroNotaDebito
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.NumeroNotaCredito
	When Sub.IdTipoComprobante=@IdTipoComprobanteRecibo Then Recibos.NumeroRecibo
	When Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then OrdenesPago.NumeroOrdenPago
	 Else Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES' Then cp.NumeroComprobante2 Else Sub.NumeroComprobante End
  End,
  Case 	When Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Facturas.IdCliente
	When Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Devoluciones.IdCliente
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then NotasDebito.IdCliente
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then NotasCredito.IdCliente
	When Sub.IdTipoComprobante=@IdTipoComprobanteRecibo Then Recibos.IdCliente
	When Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then Null
	 Else Null
  End,
  Case 	When Sub.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Null
	When Sub.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then Null
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Null
	When Sub.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Null
	When Sub.IdTipoComprobante=@IdTipoComprobanteRecibo Then Null
	When Sub.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then OrdenesPago.IdProveedor
	 Else 	Case When TiposComprobante.Agrupacion1 is not null and TiposComprobante.Agrupacion1='PROVEEDORES'
			Then Case When cp.IdProveedor is not null Then cp.IdProveedor Else cp.IdProveedorEventual End
			Else Null
		End
  End,
  '',
  Case When Sub.Debe is not null Then Round(Sub.Debe,2) Else 0 End,
  Case When Sub.Haber is not null Then Round(Sub.Haber,2) Else 0 End
 FROM Subdiarios Sub
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Sub.IdTipoComprobante
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Sub.IdComprobante
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Sub.IdComprobante
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Sub.IdComprobante
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Sub.IdComprobante
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Sub.IdComprobante
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Sub.IdComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Sub.IdComprobante
 WHERE Sub.FechaComprobante>=@FechaDesde and Sub.FechaComprobante<=@FechaHasta 

UPDATE #Auxiliar1
SET A_Letra=' '
WHERE A_Letra IS NULL

UPDATE #Auxiliar1
SET A_NumeroComprobante1=0
WHERE A_NumeroComprobante1 IS NULL

UPDATE #Auxiliar1
SET A_NumeroComprobante2=0
WHERE A_NumeroComprobante2 IS NULL

UPDATE #Auxiliar1
SET A_NumeroComprobante1=0
WHERE Len(Convert(varchar,A_NumeroComprobante1))>4

UPDATE #Auxiliar1
SET A_NumeroComprobante2=0
WHERE Len(Convert(varchar,A_NumeroComprobante2))>8

UPDATE #Auxiliar1
SET A_Detalle =	Substring(
				IsNull(#Auxiliar1.A_TipoComprobante+' ','')+IsNull(#Auxiliar1.A_Letra+'-','')+
				IsNull(Substring('0000',1,4-Len(Convert(varchar,#Auxiliar1.A_NumeroComprobante1)))+Convert(varchar,#Auxiliar1.A_NumeroComprobante1)+'-','')+
				IsNull(Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.A_NumeroComprobante2)))+Convert(varchar,#Auxiliar1.A_NumeroComprobante2)+' ','')+
				IsNull(' del '+Convert(varchar,#Auxiliar1.A_Fecha,103),''),1,35)
/*
Case When #Auxiliar1.A_Letra=' ' and #Auxiliar1.A_NumeroComprobante1=0 and #Auxiliar1.A_NumeroComprobante2=0
			Then #Auxiliar1.A_TipoComprobante
			Else Substring(#Auxiliar1.A_TipoComprobante+' '+Case When #Auxiliar1.A_Letra=' ' Then '' Else #Auxiliar1.A_Letra+'-' End+
				Substring('0000',1,4-Len(Convert(varchar,#Auxiliar1.A_NumeroComprobante1)))+Convert(varchar,#Auxiliar1.A_NumeroComprobante1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.A_NumeroComprobante2)))+Convert(varchar,#Auxiliar1.A_NumeroComprobante2)+
				' del '+Convert(varchar,#Auxiliar1.A_Fecha,103),1,35)
		End
*/

CREATE TABLE #Auxiliar2
			(
			 A_IdCuenta INTEGER,
			 A_SaldoDeudor NUMERIC(18, 2),
			 A_SaldoAcreedor NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar2 
 SELECT 
  DetAsi.IdCuenta,
  Case 	When DetAsi.Debe is not null Then Round(DetAsi.Debe,2) Else 0 End,
  Case 	When DetAsi.Haber is not null Then Round(DetAsi.Haber,2) Else 0 End
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE Asientos.FechaAsiento<@FechaDesde and Asientos.IdCuentaSubdiario is null and 
/*
	(@IncluirCierre='SI' or 
		(@IncluirCierre='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta)))) and 
	(@IncluirApertura='SI' or 
		(@IncluirApertura='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='APE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta)))) and 
*/
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL

 SELECT 
  Sub.IdCuenta,
  Case 	When Sub.Debe is not null Then Round(Sub.Debe,2) Else 0 End,
  Case 	When Sub.Haber is not null Then Round(Sub.Haber,2) Else 0 End
 FROM Subdiarios Sub
 WHERE Sub.FechaComprobante<@FechaDesde


CREATE TABLE #Auxiliar3
			(
			 A_IdCuenta INTEGER,
			 A_SaldoAnterior NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar3 
 SELECT   #Auxiliar2.A_IdCuenta,
  SUM(#Auxiliar2.A_SaldoDeudor-#Auxiliar2.A_SaldoAcreedor)
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.A_IdCuenta


CREATE TABLE #Auxiliar4 
			(
			 A_IdCuenta INTEGER,
			 A_Clave INTEGER,
			 A_Jerarquia1 VARCHAR(60),
			 A_Jerarquia2 VARCHAR(60),
			 A_Jerarquia3 VARCHAR(60),
			 A_Jerarquia4 VARCHAR(60),
			 A_Codigo INTEGER,
			 A_Descripcion  VARCHAR(60),
			 A_Detalle VARCHAR(35),
			 A_ClienteProveedor VARCHAR(100),
			 A_SaldoInicial NUMERIC(18, 2),
			 A_SaldoDeudorPeriodo NUMERIC(18, 2),
			 A_SaldoAcreedorPeriodo NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT 
  #Auxiliar0.IdCuenta,
  1,
  #Auxiliar0.DescripcionJerarquia1,
  #Auxiliar0.DescripcionJerarquia2,
  #Auxiliar0.DescripcionJerarquia3,
  #Auxiliar0.DescripcionJerarquia4,
  #Auxiliar0.Codigo,
  #Auxiliar0.Descripcion,
  '',
  '',
  Case When #Auxiliar3.A_SaldoAnterior is not null Then #Auxiliar3.A_SaldoAnterior Else 0 End,
  0,
  0
 FROM #Auxiliar0 
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.A_IdCuenta = #Auxiliar0.IdCuenta

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  2,
  #Auxiliar0.DescripcionJerarquia1,
  #Auxiliar0.DescripcionJerarquia2,
  #Auxiliar0.DescripcionJerarquia3,
  #Auxiliar0.DescripcionJerarquia4,
  #Auxiliar0.Codigo,
  #Auxiliar0.Descripcion,
  #Auxiliar1.A_Detalle,
  Case 	When Clientes.RazonSocial is not null
	 Then Clientes.RazonSocial
	When Proveedores.RazonSocial is not null
	 Then Proveedores.RazonSocial
	 Else ''
  End,
  0,
  #Auxiliar1.A_Debe,
  #Auxiliar1.A_Haber
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdCuenta=#Auxiliar1.A_IdCuenta
 LEFT OUTER JOIN Clientes ON #Auxiliar1.A_IdCliente=Clientes.IdCliente
 LEFT OUTER JOIN Proveedores ON #Auxiliar1.A_IdProveedor=Proveedores.IdProveedor
 WHERE #Auxiliar0.IdCuenta is not null

TRUNCATE TABLE _TempCuboBalance
INSERT INTO _TempCuboBalance 
SELECT 
 #Auxiliar4.A_Jerarquia1,
 #Auxiliar4.A_Jerarquia2,
 #Auxiliar4.A_Jerarquia3,
 #Auxiliar4.A_Jerarquia4, 
 Convert(varchar,#Auxiliar4.A_Codigo)+' '+#Auxiliar4.A_Descripcion,
 LTrim(#Auxiliar4.A_Detalle)+' '+#Auxiliar4.A_ClienteProveedor,
 Round(IsNull(#Auxiliar4.A_SaldoInicial,0),2),
 Round(IsNull(#Auxiliar4.A_SaldoDeudorPeriodo,0),2),
 Round(IsNull(#Auxiliar4.A_SaldoAcreedorPeriodo,0),2),
 Round(IsNull(#Auxiliar4.A_SaldoDeudorPeriodo,0)-IsNull(#Auxiliar4.A_SaldoAcreedorPeriodo,0),2),
 Round(IsNull(#Auxiliar4.A_SaldoInicial,0)+IsNull(#Auxiliar4.A_SaldoDeudorPeriodo,0)-IsNull(#Auxiliar4.A_SaldoAcreedorPeriodo,0),2)
FROM #Auxiliar4
WHERE Round(IsNull(#Auxiliar4.A_SaldoInicial,0),2)<>0 or 
	Round(IsNull(#Auxiliar4.A_SaldoDeudorPeriodo,0),2)<>0 or 
	Round(IsNull(#Auxiliar4.A_SaldoAcreedorPeriodo,0),2)<>0 or 
	Round(IsNull(#Auxiliar4.A_SaldoDeudorPeriodo,0)-IsNull(#Auxiliar4.A_SaldoAcreedorPeriodo,0),2)<>0 or 
	Round(IsNull(#Auxiliar4.A_SaldoInicial,0)+IsNull(#Auxiliar4.A_SaldoDeudorPeriodo,0)-IsNull(#Auxiliar4.A_SaldoAcreedorPeriodo,0),2)<>0


DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13
DROP TABLE #Auxiliar14

EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF