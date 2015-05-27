




CREATE Procedure [dbo].[PresupuestoFinanciero_A]
@IdPresupuestoFinanciero int  output,
@Año int,
@Mes int,
@Semana int,
@IdRubroContable int,
@PresupuestoIngresos numeric(18,2),
@PresupuestoEgresos numeric(18,2),
@Tipo varchar(1)
As 
Insert into [PresupuestoFinanciero]
(
 Año,
 Mes,
 Semana,
 IdRubroContable,
 PresupuestoIngresos,
 PresupuestoEgresos,
 Tipo
)
Values
(
 @Año,
 @Mes,
 @Semana,
 @IdRubroContable,
 @PresupuestoIngresos,
 @PresupuestoEgresos,
 @Tipo
)
Select @IdPresupuestoFinanciero=@@identity
Return(@IdPresupuestoFinanciero)




