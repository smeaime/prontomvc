CREATE Procedure [dbo].[Cuentas_TX_DesdeHastaConSaldos]

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

CREATE TABLE #Auxiliar4	
			(
			 A_IdCuenta INTEGER,
			 A_Codigo INTEGER,
			 A_Descripcion VARCHAR(80),
			 A_Jerarquia VARCHAR(20),
			 A_NombreAnterior VARCHAR(50),
			 A_CodigoAnterior INTEGER,
			 A_JerarquiaAnterior VARCHAR(20)
			)
INSERT INTO #Auxiliar4 
 SELECT 
  Cuentas.IdCuenta,
  Cuentas.Codigo,
  Cuentas.Descripcion,
  Cuentas.Jerarquia,
  (Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio),
  (Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio),
  (Select Top 1 dc.JerarquiaAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio)
 FROM Cuentas 


CREATE TABLE #Auxiliar1
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(80),
			 Jerarquia VARCHAR(20),
			 IdTipoCuenta INTEGER,
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
INSERT INTO #Auxiliar1 
 SELECT 

  C.IdCuenta,
  IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo),
  IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion),
  IsNull(#Auxiliar4.A_JerarquiaAnterior,#Auxiliar4.A_Jerarquia),
  C.IdTipoCuenta,

  (Select Sum(IsNull(Ejercicios.SaldoDebe,0))
   From Ejercicios
   Where Ejercicios.Ejercicio=@EjercicioInicio and Ejercicios.IdCuenta=C.IdCuenta),

  (Select Sum(IsNull(Ejercicios.SaldoHaber,0))
   From Ejercicios
   Where Ejercicios.Ejercicio=@EjercicioInicio and Ejercicios.IdCuenta=C.IdCuenta),

  (Select Sum(IsNull(Sub.Debe,0))
   From Subdiarios Sub
   Where Sub.IdCuenta=C.IdCuenta and 
	 Sub.FechaComprobante>=@FechaInicioEjercicio and Sub.FechaComprobante<@FechaDesde),

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
 LEFT OUTER JOIN #Auxiliar4 ON C.IdCuenta=#Auxiliar4.A_IdCuenta
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

SET NOCOUNT OFF

DECLARE @vector_E varchar(1000)
SET @vector_E='  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00'

SELECT 
 #Auxiliar1.IdCuenta,
 #Auxiliar1.Codigo as [Cuenta],
 #Auxiliar1.Jerarquia as [Jerarquias],
 #Auxiliar1.Descripcion as [Detalle],
 Case When #Auxiliar1.SaldoDebeEjercicio Is Not Null 
	Then #Auxiliar1.SaldoDebeEjercicio Else 0 End as [SaldoDebeEjercicio],
 Case When #Auxiliar1.SaldoHaberEjercicio Is Not Null Then #Auxiliar1.SaldoHaberEjercicio Else 0 End as [SaldoHaberEjercicio],
 Case When #Auxiliar1.SaldoDebeInicioSubdiario Is Not Null Then #Auxiliar1.SaldoDebeInicioSubdiario Else 0 End + 
	Case When #Auxiliar1.SaldoDebeInicioAsientos Is Not Null Then #Auxiliar1.SaldoDebeInicioAsientos Else 0 End as [SaldoDebeInicio],
 Case When #Auxiliar1.SaldoHaberInicioSubdiario Is Not Null Then #Auxiliar1.SaldoHaberInicioSubdiario Else 0 End + 
	Case When #Auxiliar1.SaldoHaberInicioAsientos Is Not Null Then #Auxiliar1.SaldoHaberInicioAsientos Else 0 End as [SaldoHaberInicio],
 Convert(Numeric(19,2),Null) as [Saldo inicial],
 Case When #Auxiliar1.SaldoDebePeriodoSubdiario Is Not Null Then #Auxiliar1.SaldoDebePeriodoSubdiario Else 0 End + 
	Case When #Auxiliar1.SaldoDebePeriodoAsientos Is Not Null Then #Auxiliar1.SaldoDebePeriodoAsientos Else 0 End as [Saldo deudor],
 Case When #Auxiliar1.SaldoHaberPeriodoSubdiario Is Not Null Then #Auxiliar1.SaldoHaberPeriodoSubdiario Else 0 End + 
	Case When #Auxiliar1.SaldoHaberPeriodoAsientos Is Not Null Then #Auxiliar1.SaldoHaberPeriodoAsientos Else 0 End as [Saldo acreedor],
 Convert(Numeric(19,2),Null) as [Saldo periodo],
 Convert(Numeric(19,2),Null) as [Saldo final],
 #Auxiliar1.Jerarquia,
 #Auxiliar1.IdTipoCuenta,
 @Vector_E as Vector_E,
 Convert(varchar(30),Null) as Vector_T,
 Convert(varchar(30),Null) as Vector_X
FROM #Auxiliar1
--LEFT OUTER JOIN Cuentas C ON C.IdCuenta=#Auxiliar1.IdCuenta
/* and Substring(C.Jerarquia,1,1)<='5' 
GROUP BY C.Jerarquia,C.IdCuenta,C.Codigo,C.Descripcion,C.IdTipoCuenta*/
ORDER BY #Auxiliar1.Jerarquia, #Auxiliar1.Codigo

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar4