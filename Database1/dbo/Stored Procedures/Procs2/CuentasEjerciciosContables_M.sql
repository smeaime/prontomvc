
CREATE  Procedure [dbo].[CuentasEjerciciosContables_M]

@IdCuentaEjercicioContable int ,
@IdCuenta int,
@IdEjercicioContable int,
@PresupuestoTeoricoMes01 numeric(18,2),
@PresupuestoTeoricoMes02 numeric(18,2),
@PresupuestoTeoricoMes03 numeric(18,2),
@PresupuestoTeoricoMes04 numeric(18,2),
@PresupuestoTeoricoMes05 numeric(18,2),
@PresupuestoTeoricoMes06 numeric(18,2),
@PresupuestoTeoricoMes07 numeric(18,2),
@PresupuestoTeoricoMes08 numeric(18,2),
@PresupuestoTeoricoMes09 numeric(18,2),
@PresupuestoTeoricoMes10 numeric(18,2),
@PresupuestoTeoricoMes11 numeric(18,2),
@PresupuestoTeoricoMes12 numeric(18,2)

AS

UPDATE CuentasEjerciciosContables
SET
 IdCuenta=@IdCuenta,
 IdEjercicioContable=@IdEjercicioContable,
 PresupuestoTeoricoMes01=@PresupuestoTeoricoMes01,
 PresupuestoTeoricoMes02=@PresupuestoTeoricoMes02,
 PresupuestoTeoricoMes03=@PresupuestoTeoricoMes03,
 PresupuestoTeoricoMes04=@PresupuestoTeoricoMes04,
 PresupuestoTeoricoMes05=@PresupuestoTeoricoMes05,
 PresupuestoTeoricoMes06=@PresupuestoTeoricoMes06,
 PresupuestoTeoricoMes07=@PresupuestoTeoricoMes07,
 PresupuestoTeoricoMes08=@PresupuestoTeoricoMes08,
 PresupuestoTeoricoMes09=@PresupuestoTeoricoMes09,
 PresupuestoTeoricoMes10=@PresupuestoTeoricoMes10,
 PresupuestoTeoricoMes11=@PresupuestoTeoricoMes11,
 PresupuestoTeoricoMes12=@PresupuestoTeoricoMes12
WHERE (IdCuentaEjercicioContable=@IdCuentaEjercicioContable)

RETURN(@IdCuentaEjercicioContable)
