CREATE Procedure [dbo].[Cuentas_TX_PresupuestoEconomicoPorIdCuentaMesAño]

@IdCuenta int, 
@Mes int, 
@Año int

AS 

DECLARE @IdEjercicioContable int 
SET @IdEjercicioContable=IsNull((Select Top 1 EjerciciosContables.IdEjercicioContable From EjerciciosContables Where Convert(datetime,'01/' + Convert(varchar,@Mes) + '/' + Convert(varchar,@Año)) between FechaInicio and FechaFinalizacion),0)

SELECT 
 Case 	When @Mes=1  Then Sum(IsNull(cec.PresupuestoTeoricoMes01,0))
	When @Mes=2  Then Sum(IsNull(cec.PresupuestoTeoricoMes02,0))
	When @Mes=3  Then Sum(IsNull(cec.PresupuestoTeoricoMes03,0))
	When @Mes=4  Then Sum(IsNull(cec.PresupuestoTeoricoMes04,0))
	When @Mes=5  Then Sum(IsNull(cec.PresupuestoTeoricoMes05,0))
	When @Mes=6  Then Sum(IsNull(cec.PresupuestoTeoricoMes06,0))
	When @Mes=7  Then Sum(IsNull(cec.PresupuestoTeoricoMes07,0))
	When @Mes=8  Then Sum(IsNull(cec.PresupuestoTeoricoMes08,0))
	When @Mes=9  Then Sum(IsNull(cec.PresupuestoTeoricoMes09,0))
	When @Mes=10 Then Sum(IsNull(cec.PresupuestoTeoricoMes10,0))
	When @Mes=11 Then Sum(IsNull(cec.PresupuestoTeoricoMes11,0))
	When @Mes=12 Then Sum(IsNull(cec.PresupuestoTeoricoMes12,0))
	Else 0
 End as [Presupuesto]
FROM CuentasEjerciciosContables cec 
WHERE cec.IdCuenta=@IdCuenta and cec.IdEjercicioContable=@IdEjercicioContable