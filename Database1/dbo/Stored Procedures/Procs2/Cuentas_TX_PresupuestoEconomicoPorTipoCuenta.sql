
CREATE Procedure [dbo].[Cuentas_TX_PresupuestoEconomicoPorTipoCuenta]

@TipoCuenta varchar(10),
@IdEjercicioContable int

AS 

Declare @MesInicial int
Set @MesInicial=IsNull((Select Top 1 Month(FechaInicio) From EjerciciosContables
			Where EjerciciosContables.IdEjercicioContable=@IdEjercicioContable),1)

Declare @vector_X varchar(30),@vector_T varchar(30)

IF Patindex('%(%', @TipoCuenta)<>0 

   BEGIN
	Set @vector_X='011166666666666633'
	Set @vector_T='059333333333333300'

	IF @MesInicial=1
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=2
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=3
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=4
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=5
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=6
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=7
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=8
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=9
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=10
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=11
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=12
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Patindex('%('+Substring(Jerarquia,1,1)+')%', @TipoCuenta)<>0
		ORDER by Cuentas.Codigo
	   END
   END

ELSE 

   BEGIN
	Set @vector_X='0111166666666666633'
	Set @vector_T='0593133333333333300'

	IF @MesInicial=1
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=2
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=3
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=4
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=5
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=6
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=7
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=8
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=9
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=10
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=11
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END

	IF @MesInicial=12
	   BEGIN
		SELECT 
		 IsNull(cec.IdCuentaEjercicioContable,Cuentas.IdCuenta*-1) as [IdAux0],
		 Cuentas.Codigo,
		 Cuentas.IdCuenta as [IdAux],
		 Cuentas.Descripcion as [Cuenta],
		 Obras.Descripcion as [Obra],
		 cec.PresupuestoTeoricoMes12 as [Diciembre],
		 cec.PresupuestoTeoricoMes01 as [Enero],
		 cec.PresupuestoTeoricoMes02 as [Febrero],
		 cec.PresupuestoTeoricoMes03 as [Marzo],
		 cec.PresupuestoTeoricoMes04 as [Abril],
		 cec.PresupuestoTeoricoMes05 as [Mayo],
		 cec.PresupuestoTeoricoMes06 as [Junio],
		 cec.PresupuestoTeoricoMes07 as [Julio],
		 cec.PresupuestoTeoricoMes08 as [Agosto],
		 cec.PresupuestoTeoricoMes09 as [Setiembre],
		 cec.PresupuestoTeoricoMes10 as [Octubre],
		 cec.PresupuestoTeoricoMes11 as [Noviembre],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM Cuentas 
		LEFT OUTER JOIN CuentasEjerciciosContables cec ON Cuentas.IdCuenta=cec.IdCuenta and 
							cec.IdEjercicioContable=@IdEjercicioContable
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa=UnidadesOperativas.IdUnidadOperativa
		WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and Convert(integer,@TipoCuenta)=IsNull(UnidadesOperativas.IdUnidadOperativa,0)
		ORDER by Cuentas.Codigo
	   END
   END
