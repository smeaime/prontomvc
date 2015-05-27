
CREATE Procedure [dbo].[Cuentas_TX_PresupuestoEconomico]

AS 

Declare @MesInicial int
Set @MesInicial=IsNull((Select Top 1 Month(FechaInicio) From EjerciciosContables
			Order By FechaFinalizacion Desc),1)

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01166666666666633'
Set @vector_T='05333333333333300'

IF @MesInicial=1
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=2
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=3
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=4
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=5
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=6
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=7
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=8
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=9
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=10
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=11
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END

IF @MesInicial=12
	BEGIN
		SELECT 
		 IdCuenta,
		 Codigo,
		 Descripcion as [Cuenta],
		 PresupuestoTeoricoMes12 as [Diciembre],
		 PresupuestoTeoricoMes01 as [Enero],
		 PresupuestoTeoricoMes02 as [Febrero],
		 PresupuestoTeoricoMes03 as [Marzo],
		 PresupuestoTeoricoMes04 as [Abril],
		 PresupuestoTeoricoMes05 as [Mayo],
		 PresupuestoTeoricoMes06 as [Junio],
		 PresupuestoTeoricoMes07 as [Julio],
		 PresupuestoTeoricoMes08 as [Agosto],
		 PresupuestoTeoricoMes09 as [Setiembre],
		 PresupuestoTeoricoMes10 as [Octubre],
		 PresupuestoTeoricoMes11 as [Noviembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		WHERE IdTipoCuenta=2 or IdTipoCuenta=4
		ORDER by Codigo
	END
