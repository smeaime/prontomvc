
CREATE Procedure [dbo].[Cuentas_TX_AsientoCierreEjercicio]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @CuentasResultadoDesde int,@CuentasResultadoHasta int,@IdCuentaResultadosEjercicio int,
	@TotalDebe numeric(18,2),@TotalHaber numeric(18,2), @IdAsientoApertura int

SET @CuentasResultadoDesde=(Select Top 1 CuentasResultadoDesde From Parametros Where IdParametro=1)
SET @CuentasResultadoHasta=(Select Top 1 CuentasResultadoHasta From Parametros Where IdParametro=1)
SET @IdCuentaResultadosEjercicio=(Select Top 1 IdCuentaResultadosEjercicio From Parametros Where IdParametro=1)

SET @IdAsientoApertura=IsNull((Select Top 1 IdAsiento From Asientos Where FechaAsiento=@FechaDesde and Substring(IsNull(Tipo,''),1,3)='APE'),0)

CREATE TABLE #Auxiliar1	
			(
			 IdCuentaMadre INTEGER,
			 IdCuentaGasto INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT (Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos
	 Where CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto),
  Cuentas.IdCuenta
 FROM Cuentas 
 WHERE Cuentas.IdCuentaGasto IS NOT NULL


CREATE TABLE #Auxiliar2	
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT C.IdCuenta, C.Codigo
 FROM Cuentas C
 WHERE Substring(C.Jerarquia,1,1)>='4'
-- WHERE C.Codigo between @CuentasResultadoDesde and @CuentasResultadoHasta and Substring(C.Jerarquia,1,1)<='5'

INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdCuentaGasto, Null
 FROM #Auxiliar1 
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar1.IdCuentaMadre
 WHERE Cuentas.Codigo between @CuentasResultadoDesde and @CuentasResultadoHasta and Substring(Cuentas.Jerarquia,1,1)<='5' and 
	not Exists(Select #Auxiliar2.IdCuenta From #Auxiliar2 Where #Auxiliar2.IdCuenta=#Auxiliar1.IdCuentaGasto)

UPDATE #Auxiliar2
SET Codigo=(Select Top 1 Cuentas.Codigo From Cuentas Where Cuentas.IdCuenta=#Auxiliar2.IdCuenta)
WHERE Codigo IS NULL


CREATE TABLE #Auxiliar3	
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Jerarquia VARCHAR(20),
			 Cuenta VARCHAR(50),
			 IdTipoCuenta INTEGER,
			 SaldoDebeInicioSubdiario NUMERIC(18, 2),
			 SaldoDebeInicioAsientos NUMERIC(18, 2),
			 SaldoHaberInicioSubdiario NUMERIC(18, 2),
			 SaldoHaberInicioAsientos NUMERIC(18, 2),
			 SaldoInicio NUMERIC(18, 2),
			 SaldoDebePeriodoSubdiario NUMERIC(18, 2),
			 SaldoDebePeriodoAsientos NUMERIC(18, 2),
			 SaldoDeudor NUMERIC(18, 2),
			 SaldoHaberPeriodoSubdiario NUMERIC(18, 2),
			 SaldoHaberPeriodoAsientos NUMERIC(18, 2),
			 SaldoAcreedor NUMERIC(18, 2),
			 SaldoPeriodo NUMERIC(18, 2),
			 SaldoFinal NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  #Auxiliar2.IdCuenta,
  #Auxiliar2.Codigo,
  C.Jerarquia,
  C.Descripcion,
  C.IdTipoCuenta,

  Case When @IdAsientoApertura=0
	Then (Select Sum(IsNull(Sub.Debe,0)) From Subdiarios Sub
		Where Sub.IdCuenta=C.IdCuenta and Sub.FechaComprobante<@FechaDesde)
	Else 0
  End,
  Case When @IdAsientoApertura=0
	Then (Select Sum(IsNull(DetAsi.Debe,0)) 
		From DetalleAsientos DetAsi
		Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
		Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=#Auxiliar2.IdCuenta and 
			Asientos.FechaGeneracionConsolidado is null and Asientos.FechaAsiento<@FechaDesde)
	Else 0
  End,

  Case When @IdAsientoApertura=0
	Then (Select Sum(IsNull(Sub.Haber,0)) 
		From Subdiarios Sub
		Where Sub.IdCuenta=C.IdCuenta and Sub.FechaComprobante<@FechaDesde)
	Else 0
  End,
  Case When @IdAsientoApertura=0
	Then (Select Sum(IsNull(DetAsi.Haber,0)) 
		From DetalleAsientos DetAsi
		Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
		Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=#Auxiliar2.IdCuenta and 
			Asientos.FechaGeneracionConsolidado is null and Asientos.FechaAsiento<@FechaDesde)
	Else 0
  End,

  0,

  (Select Sum(IsNull(Sub.Debe,0)) 
   From Subdiarios Sub
   Where Sub.IdCuenta=#Auxiliar2.IdCuenta and 
	 Sub.FechaComprobante>=@FechaDesde and Sub.FechaComprobante<=@FechaHasta),
  (Select Sum(IsNull(DetAsi.Debe,0)) 
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=#Auxiliar2.IdCuenta and 
	 Asientos.FechaGeneracionConsolidado is null and 
	 Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta),
  0,

  (Select Sum(IsNull(Sub.Haber,0)) 
   From Subdiarios Sub
   Where Sub.IdCuenta=#Auxiliar2.IdCuenta and 
	 Sub.FechaComprobante>=@FechaDesde and Sub.FechaComprobante<=@FechaHasta),
  (Select Sum(IsNull(DetAsi.Haber,0)) 
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=#Auxiliar2.IdCuenta and 
	 Asientos.FechaGeneracionConsolidado is null and 
	 Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta),
  0,

  0,
  0
 FROM #Auxiliar2
 LEFT OUTER JOIN Cuentas C ON C.IdCuenta=#Auxiliar2.IdCuenta

IF @IdAsientoApertura>0
    BEGIN
	UPDATE #Auxiliar3
	SET SaldoDebeInicioAsientos=IsNull((Select Sum(IsNull(D.Debe,0)) 
						From DetalleAsientos D  
						Left Outer Join Asientos On Asientos.IdAsiento=D.IdAsiento
						Where D.IdCuenta=#Auxiliar3.IdCuenta and Asientos.FechaAsiento=@FechaDesde and 
							Substring(IsNull(Asientos.Tipo,''),1,3)='APE'),0)
	UPDATE #Auxiliar3
	SET SaldoHaberInicioAsientos=IsNull((Select Sum(IsNull(D.Haber,0)) 
						From DetalleAsientos D  
						Left Outer Join Asientos On Asientos.IdAsiento=D.IdAsiento
						Where D.IdCuenta=#Auxiliar3.IdCuenta and Asientos.FechaAsiento=@FechaDesde and 
							Substring(IsNull(Asientos.Tipo,''),1,3)='APE'),0)
    END

UPDATE #Auxiliar3
SET SaldoInicio=(IsNull(SaldoDebeInicioSubdiario,0)+IsNull(SaldoDebeInicioAsientos,0)) - 
		   (IsNull(SaldoHaberInicioSubdiario,0)+IsNull(SaldoHaberInicioAsientos,0))

UPDATE #Auxiliar3
SET SaldoDeudor=(IsNull(SaldoDebePeriodoSubdiario,0)+IsNull(SaldoDebePeriodoAsientos,0))

UPDATE #Auxiliar3
SET SaldoAcreedor=(IsNull(SaldoHaberPeriodoSubdiario,0)+IsNull(SaldoHaberPeriodoAsientos,0))

UPDATE #Auxiliar3
SET SaldoPeriodo=SaldoDeudor-SaldoAcreedor

UPDATE #Auxiliar3
SET SaldoFinal=SaldoInicio+SaldoPeriodo

SET @TotalDebe=(Select Sum(Abs(SaldoFinal)) From #Auxiliar3 Where SaldoFinal<=0)
SET @TotalHaber=(Select Sum(SaldoFinal) From #Auxiliar3 Where SaldoFinal>0)

INSERT INTO #Auxiliar3 
 SELECT 
  @IdCuentaResultadosEjercicio,
  Cuentas.Codigo,
  Cuentas.Jerarquia,
  Cuentas.Descripcion,
  Cuentas.IdTipoCuenta,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  @TotalDebe,
  0,
  0,
  @TotalHaber,
  @TotalDebe-@TotalHaber,
  @TotalDebe-@TotalHaber
 FROM Cuentas
 WHERE Cuentas.IdCuenta=@IdCuentaResultadosEjercicio

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
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio)
 FROM Cuentas 

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01116633'
set @vector_T='05555500'

SELECT 
 #Auxiliar3.IdCuenta,
 IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Codigo],
 #Auxiliar3.Jerarquia,
 IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion) as [Cuenta],
 Case When #Auxiliar3.SaldoFinal<=0 
	Then #Auxiliar3.SaldoFinal * -1
	Else Null
 End as [Debe],
 Case When #Auxiliar3.SaldoFinal>0 
	Then #Auxiliar3.SaldoFinal
	Else Null
 End as [Haber],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar3.IdCuenta=#Auxiliar4.A_IdCuenta
WHERE #Auxiliar3.SaldoInicio<>0 or #Auxiliar3.SaldoDeudor<>0 or #Auxiliar3.SaldoAcreedor<>0
ORDER BY #Auxiliar3.Jerarquia

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
