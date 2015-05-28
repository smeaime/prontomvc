CREATE Procedure [dbo].[Cuentas_TX_DesdeHastaConSaldosConGastosTotalizados]

@FechaDesde datetime,
@FechaHasta datetime,
@EjercicioInicio int,
@FechaInicioEjercicio datetime,
@IncluirCierre varchar(2),
@IncluirApertura varchar(2),
@IncluirConsolidacion varchar(2) = Null

AS

SET NOCOUNT ON

SET @IncluirConsolidacion=IsNull(@IncluirConsolidacion,'SI')
SET @FechaInicioEjercicio=Convert(datetime,'01/01/1990')

CREATE TABLE #Auxiliar1	
			(
			 IdCuentaMadre INTEGER,
			 IdCuentaGasto INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT (Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto), Cuentas.IdCuenta
 FROM Cuentas 
 WHERE Cuentas.IdCuentaGasto IS NOT NULL


CREATE TABLE #Auxiliar2
			(
			 IdCuenta INTEGER,
			 IdCuentaMadre INTEGER,
			 SaldoDebeEjercicio NUMERIC(18, 2),
			 SaldoHaberEjercicio NUMERIC(18, 2),
			 SaldoDebeInicioSubdiario NUMERIC(18, 2),
			 SaldoDebeInicioAsientos NUMERIC(18, 2),
			 SaldoHaberInicioSubdiario NUMERIC(18, 2),
			 SaldoHaberInicioAsientos NUMERIC(18, 2),
			 SaldoDebePeriodoSubdiario NUMERIC(18, 2),
			 SaldoDebePeriodoAsientos NUMERIC(18, 2),
			 SaldoHaberPeriodoSubdiario NUMERIC(18, 2),
			 SaldoHaberPeriodoAsientos NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  C.IdCuenta,
  IsNull(#Auxiliar1.IdCuentaMadre,C.IdCuenta),

  (Select Sum(IsNull(Ejercicios.SaldoDebe,0))
   From Ejercicios
   Where Ejercicios.Ejercicio=@EjercicioInicio and Ejercicios.IdCuenta=C.IdCuenta),

  (Select Sum(IsNull(Ejercicios.SaldoHaber,0))
   From Ejercicios
   Where Ejercicios.Ejercicio=@EjercicioInicio and Ejercicios.IdCuenta=C.IdCuenta),

  (Select Sum(IsNull(Sub.Debe,0))
   From Subdiarios Sub
   Where Sub.IdCuenta=C.IdCuenta and Sub.FechaComprobante>=@FechaInicioEjercicio and Sub.FechaComprobante<@FechaDesde),

  (Select Sum(IsNull(DetAsi.Debe,0))
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=C.IdCuenta and 
		Asientos.FechaAsiento>=@FechaInicioEjercicio and Asientos.FechaAsiento<@FechaDesde and 
		(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))),

  (Select Sum(IsNull(Sub.Haber,0))
   From Subdiarios Sub
   Where Sub.IdCuenta=C.IdCuenta and Sub.FechaComprobante>=@FechaInicioEjercicio and Sub.FechaComprobante<@FechaDesde),

  (Select Sum(IsNull(DetAsi.Haber,0))
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=C.IdCuenta and 
		 Asientos.FechaAsiento>=@FechaInicioEjercicio and Asientos.FechaAsiento<@FechaDesde and 
		(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))),

  (Select Sum(IsNull(Sub.Debe,0))
   From Subdiarios Sub
   Where Sub.IdCuenta=C.IdCuenta and Sub.FechaComprobante>=@FechaDesde and Sub.FechaComprobante<=@FechaHasta),

  (Select Sum(IsNull(DetAsi.Debe,0))
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=C.IdCuenta and 
		 Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta and 
		(@IncluirCierre='SI' or Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'CIE') and 
		(@IncluirApertura='SI' or Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'APE') and 
		(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))),

  (Select Sum(IsNull(Sub.Haber,0))
   From Subdiarios Sub
   Where Sub.IdCuenta=C.IdCuenta and Sub.FechaComprobante>=@FechaDesde and Sub.FechaComprobante<=@FechaHasta),

  (Select Sum(IsNull(DetAsi.Haber,0))
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=C.IdCuenta and 
		 Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta and 
		(@IncluirCierre='SI' or Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'CIE') and 
		(@IncluirApertura='SI' or Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'APE') and 
		(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null)))

 FROM Cuentas C
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdCuentaGasto=C.IdCuenta
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


CREATE TABLE #Auxiliar3
			(
			 IdCuenta INTEGER,
			 SaldoDebeEjercicio NUMERIC(18, 2),
			 SaldoHaberEjercicio NUMERIC(18, 2),
			 SaldoDebeInicioSubdiario NUMERIC(18, 2),
			 SaldoDebeInicioAsientos NUMERIC(18, 2),
			 SaldoHaberInicioSubdiario NUMERIC(18, 2),
			 SaldoHaberInicioAsientos NUMERIC(18, 2),
			 SaldoDebePeriodoSubdiario NUMERIC(18, 2),
			 SaldoDebePeriodoAsientos NUMERIC(18, 2),
			 SaldoHaberPeriodoSubdiario NUMERIC(18, 2),
			 SaldoHaberPeriodoAsientos NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  #Auxiliar2.IdCuentaMadre,
  Sum(IsNull(#Auxiliar2.SaldoDebeEjercicio,0)), Sum(IsNull(#Auxiliar2.SaldoHaberEjercicio,0)),
  Sum(IsNull(#Auxiliar2.SaldoDebeInicioSubdiario,0)), Sum(IsNull(#Auxiliar2.SaldoDebeInicioAsientos,0)),
  Sum(IsNull(#Auxiliar2.SaldoHaberInicioSubdiario,0)), Sum(IsNull(#Auxiliar2.SaldoHaberInicioAsientos,0)),
  Sum(IsNull(#Auxiliar2.SaldoDebePeriodoSubdiario,0)), Sum(IsNull(#Auxiliar2.SaldoDebePeriodoAsientos,0)),
  Sum(IsNull(#Auxiliar2.SaldoHaberPeriodoSubdiario,0)), Sum(IsNull(#Auxiliar2.SaldoHaberPeriodoAsientos,0))
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdCuentaMadre

CREATE TABLE #Auxiliar4	
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(80),
			 Jerarquia VARCHAR(20),
			 IdTipoCuenta INTEGER,
			)
INSERT INTO #Auxiliar4 
 SELECT 
  Cuentas.IdCuenta,
  IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),Cuentas.Codigo),
  IsNull((Select Top 1 dc.NombreAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),Cuentas.Descripcion),
  IsNull((Select Top 1 dc.JerarquiaAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),Cuentas.Jerarquia),
  Cuentas.IdTipoCuenta
 FROM Cuentas 

SET NOCOUNT OFF

Declare @vector_E varchar(1000)
Set @vector_E='  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00'

SELECT 
 #Auxiliar3.IdCuenta,
 #Auxiliar4.Codigo as [Cuenta],
 #Auxiliar4.Jerarquia as [Jerarquias],
 #Auxiliar4.Descripcion as [Detalle],
 Case When #Auxiliar3.SaldoDebeEjercicio Is Not Null Then #Auxiliar3.SaldoDebeEjercicio Else 0 End as [SaldoDebeEjercicio],
 Case When #Auxiliar3.SaldoHaberEjercicio Is Not Null Then #Auxiliar3.SaldoHaberEjercicio Else 0 End as [SaldoHaberEjercicio],
 Case When #Auxiliar3.SaldoDebeInicioSubdiario Is Not Null Then #Auxiliar3.SaldoDebeInicioSubdiario Else 0 End + 
	Case When #Auxiliar3.SaldoDebeInicioAsientos Is Not Null Then #Auxiliar3.SaldoDebeInicioAsientos Else 0 End as [SaldoDebeInicio],
 Case When #Auxiliar3.SaldoHaberInicioSubdiario Is Not Null Then #Auxiliar3.SaldoHaberInicioSubdiario Else 0 End + 
	Case When #Auxiliar3.SaldoHaberInicioAsientos Is Not Null Then #Auxiliar3.SaldoHaberInicioAsientos Else 0 End as [SaldoHaberInicio],
 Convert(Numeric(19,2),Null) as [Saldo inicial],
 Case When #Auxiliar3.SaldoDebePeriodoSubdiario Is Not Null Then #Auxiliar3.SaldoDebePeriodoSubdiario Else 0 End + 
	Case When #Auxiliar3.SaldoDebePeriodoAsientos Is Not Null Then #Auxiliar3.SaldoDebePeriodoAsientos Else 0 End as [Saldo deudor],
 Case When #Auxiliar3.SaldoHaberPeriodoSubdiario Is Not Null  Then #Auxiliar3.SaldoHaberPeriodoSubdiario Else 0 End + 
	Case When #Auxiliar3.SaldoHaberPeriodoAsientos Is Not Null Then #Auxiliar3.SaldoHaberPeriodoAsientos Else 0 End as [Saldo acreedor],
 Convert(Numeric(19,2),Null) as [Saldo periodo],
 Convert(Numeric(19,2),Null) as [Saldo final],
 #Auxiliar4.Jerarquia,
 #Auxiliar4.IdTipoCuenta,
 @Vector_E as Vector_E,
 Convert(varchar(30),Null) as Vector_T,
 Convert(varchar(30),Null) as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar3.IdCuenta=#Auxiliar4.IdCuenta
WHERE Substring(#Auxiliar4.Jerarquia,1,1)<='5'
ORDER BY #Auxiliar4.Jerarquia, #Auxiliar4.Codigo

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4