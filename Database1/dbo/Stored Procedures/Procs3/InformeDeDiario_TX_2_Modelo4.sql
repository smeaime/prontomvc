CREATE PROCEDURE [dbo].[InformeDeDiario_TX_2_Modelo4]

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

CREATE TABLE #Auxiliar1	
			(
			 IdTipoGrupo INTEGER,
			 IdCuenta INTEGER,
			 Asiento INTEGER,
			 Fecha DATETIME,
			 DebeHaber INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT
  2,
  IdCuenta,
  Null,
  FechaComprobante,
  Case When IsNull(Debe,0)<>0 Then 1 Else 2 End,
  Debe,
  Haber
 FROM Subdiarios
 WHERE FechaComprobante>=@FechaDesde and FechaComprobante<=DATEADD(n,1439,@FechaHasta) and IdCuentaSubdiario=1

 UNION ALL

 SELECT
  3,
  IdCuenta,
  Null,
  FechaComprobante,
  Case When IsNull(Debe,0)<>0 Then 1 Else 2 End,
  Debe,
  Haber
 FROM Subdiarios
 WHERE FechaComprobante>=@FechaDesde and FechaComprobante<=DATEADD(n,1439,@FechaHasta) and 
	IdCuentaSubdiario=4 and IdTipoComprobante=2

 UNION ALL

 SELECT
  4,
  IdCuenta,
  Null,
  FechaComprobante,
  Case When IsNull(Debe,0)<>0 Then 1 Else 2 End,
  Debe,
  Haber
 FROM Subdiarios
 WHERE FechaComprobante>=@FechaDesde and FechaComprobante<=DATEADD(n,1439,@FechaHasta) and 
	(IdCuentaSubdiario=7 or 
	 (IdCuentaSubdiario=4 and IsNull((Select Top 1 Valores.Iva From Valores 
					Where Valores.IdTipoComprobante=Subdiarios.IdTipoComprobante and 
						Valores.IdValor=Subdiarios.IdComprobante),0)<>0))

 UNION ALL

 SELECT
  5,
  IdCuenta,
  Null,
  FechaComprobante,
  Case When IsNull(Debe,0)<>0 Then 1 Else 2 End,
  Debe,
  Haber
 FROM Subdiarios
 WHERE FechaComprobante>=@FechaDesde and FechaComprobante<=DATEADD(n,1439,@FechaHasta) and 
	IdCuentaSubdiario=4 and IdTipoComprobante=17

 UNION ALL

 SELECT
  6,
  IdCuenta,
  Null,
  FechaComprobante,
  Case When IsNull(Debe,0)<>0 Then 1 Else 2 End,
  Debe,
  Haber
 FROM Subdiarios
 WHERE FechaComprobante>=@FechaDesde and FechaComprobante<=DATEADD(n,1439,@FechaHasta) and 
	IdCuentaSubdiario=4 and IdTipoComprobante<>2 and IdTipoComprobante<>17 and 
	not (IdCuentaSubdiario=4 and IsNull((Select Top 1 Valores.Iva From Valores 
						Where Valores.IdTipoComprobante=Subdiarios.IdTipoComprobante and 
							Valores.IdValor=Subdiarios.IdComprobante),0)<>0)

CREATE TABLE #Auxiliar2	
			(
			 IdTipoGrupo INTEGER,
			 IdCuenta INTEGER,
			 Asiento INTEGER,
			 Fecha DATETIME,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Detalle VARCHAR(100)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdTipoGrupo,
  #Auxiliar1.IdCuenta,
  0,
  #Auxiliar1.Fecha,
  SUM(IsNull(#Auxiliar1.Debe,0)),
  SUM(IsNull(#Auxiliar1.Haber,0)),
  Null
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdTipoGrupo, #Auxiliar1.IdCuenta, #Auxiliar1.Fecha, #Auxiliar1.DebeHaber

UPDATE #Auxiliar2
SET Detalle=	CASE When IdTipoGrupo=2 Then 'Ventas del dia'
			When IdTipoGrupo=3 Then 'Cobranzas del dia'
			When IdTipoGrupo=4 Then 'Compras del dia'
			When IdTipoGrupo=5 Then 'Pagos del dia'
			When IdTipoGrupo=6 Then 'Caja del dia'
			Else Null
		END

INSERT INTO #Auxiliar2 
 SELECT 
  1,
  DetAsi.IdCuenta,
  Asientos.NumeroAsiento,
  Asientos.FechaAsiento,
  DetAsi.Debe,
  DetAsi.Haber,
  Substring(IsNull(Asientos.Concepto COLLATE SQL_Latin1_General_CP1_CI_AS+' - ','')+
		IsNull(DetAsi.Detalle,''),1,100)
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE Asientos.IdCuentaSubdiario is null and
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta) and 
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

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
  (Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio),
  (Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio)
 FROM Cuentas 

SET NOCOUNT ON

Declare @NumeroAsiento int
Set @NumeroAsiento=0

Declare @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(500)
Set @vector_X='000001111166133'
Set @vector_T='000004223F33900'
Set @vector_E='  |  |  |  |  |  |  '

SELECT
 1 as [Id],
 Null as [K_IdTipoGrupo],
 Null as [K_Asiento],
 #Auxiliar2.Fecha as [K_Fecha],
 0 as [K_Orden],
 #Auxiliar2.Fecha as [Fecha],
 Null as [Asiento],
 Null as [Cuenta],
 Null as [Concepto],
 Null as [Detalle],
 Null as [Debito],
 Null as [Credito],
 ' FEC,BOL |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
GROUP BY #Auxiliar2.Fecha

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar2.IdTipoGrupo as [K_IdTipoGrupo],
 #Auxiliar2.Asiento as [K_Asiento],
 #Auxiliar2.Fecha as [K_Fecha],
 1 as [K_Orden],
 Null as [Fecha],
 @NumeroAsiento as [Asiento],
 IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Cuenta],
 Case	When #Auxiliar2.Debe is null Then '   '+IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
	Else IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
 End as [Concepto],
 #Auxiliar2.Detalle as [Detalle],
 #Auxiliar2.Debe as [Debito],
 #Auxiliar2.Haber as [Credito],
 ' BOL | BOL | BOL | BOL |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar2.IdCuenta=#Auxiliar4.A_IdCuenta

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar2.IdTipoGrupo as [K_IdTipoGrupo],
 #Auxiliar2.Asiento as [K_Asiento],
 #Auxiliar2.Fecha as [K_Fecha],
 2 as [K_Orden],
 Null as [Fecha],
 Null as [Asiento],
 Null as [Cuenta],
 Null as [Concepto],
 Null as [Detalle],
 SUM(IsNull(#Auxiliar2.Debe,0)) as [Debito],
 SUM(IsNull(#Auxiliar2.Haber,0)) as [Credito],
 ' LIN:100:- | LIN:100:- | LIN:100:- | LIN:100:- | LIN:100:- | NUM:#COMMA##0.00,NOSUMAR | NUM:#COMMA##0.00,NOSUMAR ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
GROUP BY #Auxiliar2.IdTipoGrupo, #Auxiliar2.Asiento, #Auxiliar2.Fecha

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar2.IdTipoGrupo as [K_IdTipoGrupo],
 #Auxiliar2.Asiento as [K_Asiento],
 #Auxiliar2.Fecha as [K_Fecha],
 3 as [K_Orden],
 Null as [Fecha],
 Null as [Asiento],
 Null as [Cuenta],
 Null as [Concepto],
 Null as [Detalle],
 Null as [Debito],
 Null as [Credito],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
GROUP BY #Auxiliar2.IdTipoGrupo, #Auxiliar2.Asiento, #Auxiliar2.Fecha

UNION ALL 

SELECT
 1 as [Id],
 999999 as [K_IdTipoGrupo],
 999999 as [K_Asiento],
 @FechaHasta as [K_Fecha],
 4 as [K_Orden],
 Null as [Fecha],
 Null as [Asiento],
 Null as [Cuenta],
 Null as [Concepto],
 'TOTAL GENERAL' as [Detalle],
 SUM(IsNull(#Auxiliar2.Debe,0)) as [Debito],
 SUM(IsNull(#Auxiliar2.Haber,0)) as [Credito],
 ' EBH, CO2, AN2:2;10, AN2:3;10, '+
	'AV2:1;1, AV2:4;1, AV2:5;1, AV2:6;1, AV2:7;1, '+
	'AH2:2;1, AH2:3;1, AH2:4;1, AH2:5;1, '+
	'VAL:1;2;Asiento;Numero, VAL:1;3;Cuenta;Numero, '+
	' LIN:100:- | LIN:100:- | LIN:100:- | LIN:100:- |  | BDS NOSUMAR | BDS NOSUMAR ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2

ORDER BY [K_Fecha], [K_IdTipoGrupo], [K_Asiento], [K_Orden], [Credito], [Cuenta]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar4