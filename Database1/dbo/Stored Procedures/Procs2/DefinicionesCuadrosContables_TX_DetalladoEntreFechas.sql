CREATE  Procedure [dbo].[DefinicionesCuadrosContables_TX_DetalladoEntreFechas]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetAsi.IdCuenta,
  DetAsi.Debe,
  DetAsi.Haber
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE Asientos.IdCuentaSubdiario is null and
		Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta and 
		Exists(Select Top 1 dcc.IdCuenta From DefinicionesCuadrosContables dcc Where dcc.IdCuentaIngreso=DetAsi.IdCuenta or dcc.IdCuentaEgreso=DetAsi.IdCuenta)

 UNION ALL

 SELECT
  Subdiarios.IdCuenta,
  Subdiarios.Debe,
  Subdiarios.Haber
 FROM Subdiarios
 LEFT OUTER JOIN Bancos ON Subdiarios.IdCuenta = Bancos.IdCuenta
 WHERE Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=@FechaHasta and 
		Exists(Select Top 1 dcc.IdCuenta From DefinicionesCuadrosContables dcc Where dcc.IdCuentaIngreso=Subdiarios.IdCuenta or dcc.IdCuentaEgreso=Subdiarios.IdCuenta)

CREATE TABLE #Auxiliar2 
			(
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdCuenta,
  SUM(IsNull(#Auxiliar1.Debe,0)),
  SUM(IsNull(#Auxiliar1.Haber,0))
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdCuenta

CREATE TABLE #Auxiliar3 
			(
			 IdCuenta INTEGER,
			 IdCuentaIngreso INTEGER,
			 IdCuentaEgreso INTEGER,
			 Ingreso NUMERIC(18, 2),
			 Egreso NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  dcc.IdCuenta,
  dcc.IdCuentaIngreso,
  dcc.IdCuentaEgreso,
  Case When IsNull(dcc.IdCuentaIngreso,0)<>0 
	Then (Select Top 1 IsNull(#Auxiliar2.Debe,0)-IsNull(#Auxiliar2.Haber,0) From #Auxiliar2 Where #Auxiliar2.IdCuenta=dcc.IdCuentaIngreso)
	Else 0
  End, 
  Case When IsNull(dcc.IdCuentaEgreso,0)<>0 
	Then (Select Top 1 IsNull(#Auxiliar2.Debe,0)-IsNull(#Auxiliar2.Haber,0) From #Auxiliar2 Where #Auxiliar2.IdCuenta=dcc.IdCuentaEgreso)
	Else 0
  End
 FROM DefinicionesCuadrosContables dcc 

CREATE TABLE #Auxiliar4 
			(
			 IdCuenta INTEGER,
			 IdCuentaIngreso INTEGER,
			 IdCuentaEgreso INTEGER,
			 Ingreso NUMERIC(18, 2),
			 Egreso NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT 
  #Auxiliar3.IdCuenta,
  #Auxiliar3.IdCuentaIngreso,
  #Auxiliar3.IdCuentaEgreso,
  SUM(IsNull(#Auxiliar3.Ingreso,0)) * -1,
  SUM(IsNull(#Auxiliar3.Egreso,0)) * -1
 FROM #Auxiliar3
 GROUP BY #Auxiliar3.IdCuenta, #Auxiliar3.IdCuentaIngreso, #Auxiliar3.IdCuentaEgreso

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='000011166633'
SET @vector_T='000043233300'

SELECT 
 0 as [K_Id],
 dcc.Descripcion as [K_Grupo],
 1 as [K_Orden],
 Null as [K_Cuenta], 
 dcc.Descripcion as [Grupo],
 Null as [Cuenta], 
 Null as [Descripcion], 
 Null as [Ingresos], 
 Null as [Egresos], 
 Null as [Saldo], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DefinicionesCuadrosContables dcc 
GROUP BY dcc.Descripcion

UNION ALL 

SELECT 
 0 as [K_Id],
 dcc.Descripcion as [K_Grupo],
 2 as [K_Orden],
 Case When IsNull(dcc.IdCuentaIngreso,0)<>0 
	Then (Select Top 1 Cuentas.Codigo From Cuentas Where Cuentas.IdCuenta=dcc.IdCuentaIngreso)
	Else '     '+(Select Top 1 Cuentas.Codigo From Cuentas Where Cuentas.IdCuenta=dcc.IdCuentaEgreso)
 End as [K_Cuenta], 
 Null as [Grupo],
 Case When IsNull(dcc.IdCuentaIngreso,0)<>0 
	Then (Select Top 1 Cuentas.Codigo From Cuentas Where Cuentas.IdCuenta=dcc.IdCuentaIngreso)
	Else (Select Top 1 Cuentas.Codigo From Cuentas Where Cuentas.IdCuenta=dcc.IdCuentaEgreso)
 End as [Cuenta], 
 Case When IsNull(dcc.IdCuentaIngreso,0)<>0 
	Then (Select Top 1 Cuentas.Descripcion From Cuentas Where Cuentas.IdCuenta=dcc.IdCuentaIngreso)
	Else '     '+(Select Top 1 Cuentas.Descripcion From Cuentas Where Cuentas.IdCuenta=dcc.IdCuentaEgreso)
 End as [Descripcion], 
 Case When IsNull(dcc.IdCuentaIngreso,0)<>0 Then #Auxiliar4.Ingreso Else Null End as [Ingresos], 
 Case When IsNull(dcc.IdCuentaEgreso,0)<>0  Then #Auxiliar4.Egreso Else Null End as [Egresos], 
 IsNull(#Auxiliar4.Ingreso,0) + IsNull(#Auxiliar4.Egreso,0) as [Saldo], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DefinicionesCuadrosContables dcc 
LEFT OUTER JOIN #Auxiliar4 ON dcc.IdCuenta=#Auxiliar4.IdCuenta and dcc.IdCuentaIngreso=#Auxiliar4.IdCuentaIngreso and dcc.IdCuentaEgreso=#Auxiliar4.IdCuentaEgreso

UNION ALL 

SELECT 
 0 as [K_Id],
 (Select Top 1 dcc.Descripcion From DefinicionesCuadrosContables dcc Where dcc.IdCuenta=#Auxiliar4.IdCuenta) as [K_Grupo],
 3 as [K_Orden],
 Null as [K_Cuenta], 
 Null as [Grupo],
 Null as [Cuenta], 
 'TOTALES' as [Descripcion], 
 SUM(IsNull(#Auxiliar4.Ingreso,0)) as [Ingresos], 
 SUM(IsNull(#Auxiliar4.Egreso,0)) as [Egresos], 
 SUM(IsNull(#Auxiliar4.Ingreso,0)) + SUM(IsNull(#Auxiliar4.Egreso,0)) as [Saldo], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar4  
GROUP BY #Auxiliar4.IdCuenta

ORDER BY [K_Grupo],[K_Orden],[K_Cuenta]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
