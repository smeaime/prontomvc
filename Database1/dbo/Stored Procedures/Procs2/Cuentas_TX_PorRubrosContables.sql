
CREATE Procedure [dbo].[Cuentas_TX_PorRubrosContables]

@Fecha datetime

AS

Declare @FechaMesAnterior datetime
Set @FechaMesAnterior=DateAdd(m,-1,@Fecha)

declare @FechaInicioEjercicio Datetime
Set @FechaInicioEjercicio=(Select EjerciciosPeriodos.FechaInicio
				From EjerciciosPeriodos
				Where @Fecha between FechaInicio and FechaFinalizacion)

SET NOCOUNT ON

CREATE TABLE #Auxiliar (
			 IdCuenta INTEGER,
			 Cuenta INTEGER,
			 NombreCuenta VARCHAR(50),
			 CodigoRubro INTEGER,
			 Rubro VARCHAR(50),
			 SaldoMesAnteriorSubdiarios NUMERIC(12,2),
			 SaldoMesAnteriorAsientos NUMERIC(12,2),
			 SaldoMesSubdiarios NUMERIC(12,2),
			 SaldoMesAsientos NUMERIC(12,2),
			 SaldoAcumuladoSubdiarios NUMERIC(12,2),
			 SaldoAcumuladoAsientos NUMERIC(12,2)
			)
INSERT INTO #Auxiliar 
 SELECT 
  C.IdCuenta,
  C.Codigo,
  C.Descripcion,
  RubrosContables.Codigo,
  RubrosContables.Descripcion,

  (Select Sum(
		Case 	When Sub.Debe is null and Sub.Haber is null Then 0
			When not Sub.Debe is null and Sub.Haber is null Then Sub.Debe
			When Sub.Debe is null and not Sub.Haber is null Then Sub.Haber*-1
			When not Sub.Debe is null and not Sub.Haber is null Then Sub.Debe-Sub.Haber
		End)
   From Subdiarios Sub
   Where Sub.IdCuenta=C.IdCuenta and 
	 Year(Sub.FechaComprobante)=Year(@FechaMesAnterior) and 
	 Month(Sub.FechaComprobante)=Month(@FechaMesAnterior)),

  (Select Sum(
		Case 	When DetAsi.Debe is null and DetAsi.Haber is null Then 0
			When not DetAsi.Debe is null and DetAsi.Haber is null Then DetAsi.Debe
			When DetAsi.Debe is null and not DetAsi.Haber is null Then DetAsi.Haber*-1
			When not DetAsi.Debe is null and not DetAsi.Haber is null Then DetAsi.Debe-DetAsi.Haber
		End)
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=C.IdCuenta and 
	 Year(Asientos.FechaAsiento)=Year(@FechaMesAnterior) and 
	 Month(Asientos.FechaAsiento)=Month(@FechaMesAnterior)),

  (Select Sum(
		Case 	When Sub.Debe is null and Sub.Haber is null Then 0
			When not Sub.Debe is null and Sub.Haber is null Then Sub.Debe
			When Sub.Debe is null and not Sub.Haber is null Then Sub.Haber*-1
			When not Sub.Debe is null and not Sub.Haber is null Then Sub.Debe-Sub.Haber
		End)
   From Subdiarios Sub
   Where Sub.IdCuenta=C.IdCuenta and 
	 Year(Sub.FechaComprobante)=Year(@Fecha) and 
	 Month(Sub.FechaComprobante)=Month(@Fecha)),

  (Select Sum(
		Case 	When DetAsi.Debe is null and DetAsi.Haber is null Then 0
			When not DetAsi.Debe is null and DetAsi.Haber is null Then DetAsi.Debe
			When DetAsi.Debe is null and not DetAsi.Haber is null Then DetAsi.Haber*-1
			When not DetAsi.Debe is null and not DetAsi.Haber is null Then DetAsi.Debe-DetAsi.Haber
		End)
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=C.IdCuenta and 
	 Year(Asientos.FechaAsiento)=Year(@Fecha) and 
	 Month(Asientos.FechaAsiento)=Month(@Fecha)),

  (Select Sum(
		Case 	When Sub.Debe is null and Sub.Haber is null Then 0
			When not Sub.Debe is null and Sub.Haber is null Then Sub.Debe
			When Sub.Debe is null and not Sub.Haber is null Then Sub.Haber*-1
			When not Sub.Debe is null and not Sub.Haber is null Then Sub.Debe-Sub.Haber
		End)
   From Subdiarios Sub
   Where Sub.IdCuenta=C.IdCuenta and 
	 Sub.FechaComprobante>=@FechaInicioEjercicio and Sub.FechaComprobante<=@Fecha),

  (Select Sum(
		Case 	When DetAsi.Debe is null and DetAsi.Haber is null Then 0
			When not DetAsi.Debe is null and DetAsi.Haber is null Then DetAsi.Debe
			When DetAsi.Debe is null and not DetAsi.Haber is null Then DetAsi.Haber*-1
			When not DetAsi.Debe is null and not DetAsi.Haber is null Then DetAsi.Debe-DetAsi.Haber
		End)
   From DetalleAsientos DetAsi
   Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
   Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=C.IdCuenta and 
	 Asientos.FechaAsiento>=@FechaInicioEjercicio and Asientos.FechaAsiento<=@Fecha)

 FROM Cuentas C
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=C.IdRubroContable
 WHERE C.IdRubroContable is not null
 GROUP BY C.IdCuenta,C.Codigo,C.Descripcion,RubrosContables.Codigo,RubrosContables.Descripcion
 ORDER BY C.Codigo

SET NOCOUNT OFF


declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='000111166633'
set @vector_T='000014155900'

Select
 IdCuenta,
 0 as [Ord1],
 CodigoRubro as [Ord2],
 CodigoRubro as [Cod.],
 Rubro,
 Cuenta,
 NombreCuenta as [Nombre de la cuenta],
 IsNull(SaldoMesAnteriorSubdiarios,0)+IsNull(SaldoMesAnteriorAsientos,0) as [Saldo mes ant.],
 IsNull(SaldoMesSubdiarios,0)+IsNull(SaldoMesAsientos,0) as [Salso del mes],
 IsNull(SaldoAcumuladoSubdiarios,0)+IsNull(SaldoAcumuladoAsientos,0) as [Saldo acumulado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
From #Auxiliar
Where (IsNull(SaldoMesAnteriorSubdiarios,0)+IsNull(SaldoMesAnteriorAsientos,0))<>0 Or 
	(IsNull(SaldoMesSubdiarios,0)+IsNull(SaldoMesAsientos,0))<>0 Or 
	(IsNull(SaldoAcumuladoSubdiarios,0)+IsNull(SaldoAcumuladoAsientos,0))<>0

Union All

Select
 0,
 1 as [Ord1],
 CodigoRubro as [Ord2],
 CodigoRubro as [Cod.],
 'TOTAL RUBRO' as [Rubro],
 Null as [Cuenta],
 Null as [Nombre de la cuenta],
 Sum(IsNull(SaldoMesAnteriorSubdiarios,0)+IsNull(SaldoMesAnteriorAsientos,0)) as [Saldo mes ant.],
 Sum(IsNull(SaldoMesSubdiarios,0)+IsNull(SaldoMesAsientos,0)) as [Salso del mes],
 Sum(IsNull(SaldoAcumuladoSubdiarios,0)+IsNull(SaldoAcumuladoAsientos,0)) as [Saldo acumulado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
From #Auxiliar
Where (IsNull(SaldoMesAnteriorSubdiarios,0)+IsNull(SaldoMesAnteriorAsientos,0))<>0 Or 
	(IsNull(SaldoMesSubdiarios,0)+IsNull(SaldoMesAsientos,0))<>0 Or 
	(IsNull(SaldoAcumuladoSubdiarios,0)+IsNull(SaldoAcumuladoAsientos,0))<>0
Group By CodigoRubro

Union All

Select
 0,
 2 as [Ord1],
 CodigoRubro as [Ord2],
 Null as [Cod.],
 Null as [Rubro],
 Null as [Cuenta],
 Null as [Nombre de la cuenta],
 Null as [Saldo mes ant.],
 Null as [Salso del mes],
 Null as [Saldo acumulado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
From #Auxiliar
Where (IsNull(SaldoMesAnteriorSubdiarios,0)+IsNull(SaldoMesAnteriorAsientos,0))<>0 Or 
	(IsNull(SaldoMesSubdiarios,0)+IsNull(SaldoMesAsientos,0))<>0 Or 
	(IsNull(SaldoAcumuladoSubdiarios,0)+IsNull(SaldoAcumuladoAsientos,0))<>0
Group By CodigoRubro

Order By [Ord2],[Ord1],[Rubro],[Cuenta]

DROP TABLE #Auxiliar
