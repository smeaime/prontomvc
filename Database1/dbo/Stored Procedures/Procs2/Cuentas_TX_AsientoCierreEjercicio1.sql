
CREATE Procedure [dbo].[Cuentas_TX_AsientoCierreEjercicio1]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @CuentasPatrimonialesDesde int,@CuentasPatrimonialesHasta int,
	@TotalDebe numeric(18,2),@TotalHaber numeric(18,2), @IdAsientoApertura int
SET @CuentasPatrimonialesDesde=(Select Top 1 CuentasPatrimonialesDesde From Parametros Where IdParametro=1)
SET @CuentasPatrimonialesHasta=(Select Top 1 CuentasPatrimonialesHasta From Parametros Where IdParametro=1)

SET @IdAsientoApertura=IsNull((Select Top 1 IdAsiento From Asientos Where FechaAsiento=@FechaDesde and Substring(IsNull(Tipo,''),1,3)='APE'),0)

CREATE TABLE #Auxiliar2	
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT 
  C.IdCuenta,
  C.Codigo
 FROM Cuentas C
 WHERE Substring(C.Jerarquia,1,1)<='3'
-- WHERE C.Codigo between @CuentasPatrimonialesDesde and @CuentasPatrimonialesHasta and Substring(C.Jerarquia,1,1)<='5'

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
	Then (Select Sum(IsNull(Sub.Debe,0)) 
		From Subdiarios Sub
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

/*
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
*/

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

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01116633'
set @vector_T='05555500'

SELECT 
 IdCuenta,
 Codigo,
 Jerarquia,
 Cuenta,
 Case When SaldoFinal<=0 
	Then SaldoFinal * -1
	Else Null
 End as [Debe],
 Case When SaldoFinal>0 
	Then SaldoFinal
	Else Null
 End as [Haber],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
WHERE SaldoInicio<>0 or SaldoDeudor<>0 or SaldoAcreedor<>0
ORDER BY Jerarquia

DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
