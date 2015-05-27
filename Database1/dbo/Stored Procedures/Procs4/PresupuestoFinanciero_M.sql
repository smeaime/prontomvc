




CREATE  Procedure [dbo].[PresupuestoFinanciero_M]
@IdPresupuestoFinanciero int,
@Año int,
@Mes int,
@Semana int,
@IdRubroContable int,
@PresupuestoIngresos numeric(18,2),
@PresupuestoEgresos numeric(18,2),
@Tipo varchar(1)
As
Update PresupuestoFinanciero
Set
 Año=@Año,
 Mes=@Mes,
 Semana=@Semana,
 IdRubroContable=@IdRubroContable,
 PresupuestoIngresos=@PresupuestoIngresos,
 PresupuestoEgresos=@PresupuestoEgresos,
 Tipo=@Tipo
Where (IdPresupuestoFinanciero=@IdPresupuestoFinanciero)
Return(@IdPresupuestoFinanciero)




