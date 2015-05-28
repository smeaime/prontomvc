


CREATE Procedure [dbo].[Cuentas_TX_TT_PresupuestoEconomico]

@TipoCuenta varchar(10),
@IdCuentaEjercicioContable int

AS 

Declare @MesInicial int, @IdEjercicioContable int
Set @IdEjercicioContable=IsNull((Select Top 1 cec.IdEjercicioContable 
				 From CuentasEjerciciosContables cec  
				 Where cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable),0)
Set @MesInicial=IsNull((Select Top 1 Month(FechaInicio) From EjerciciosContables
			Where EjerciciosContables.IdEjercicioContable=@IdEjercicioContable),1)

Declare @vector_X varchar(30), @vector_T varchar(30)

IF Patindex('%(%', @TipoCuenta)<>0 

   BEGIN
	Set @vector_X='011166666666666633'
	Set @vector_T='059333333333333300'

	IF @MesInicial=1
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=2
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=3
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=4
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=5
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=6
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=7
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=8
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=9
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=10
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=11
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=12
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable

   END

ELSE 

   BEGIN
	Set @vector_X='0111166666666666633'
	Set @vector_T='0593133333333333300'

	IF @MesInicial=1
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=2
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=3
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		 @Vector_X as Vector_X
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=4
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=5
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=6
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=7
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=8
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=9
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=10
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=11
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable
	
	IF @MesInicial=12
		SELECT 
		 cec.IdCuentaEjercicioContable as [IdAux0],
		 Cuentas.Codigo,
		 cec.IdCuenta as [IdAux],
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
		FROM CuentasEjerciciosContables cec  
		LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=cec.IdCuenta
		LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
		WHERE cec.IdCuentaEjercicioContable=@IdCuentaEjercicioContable

   END



