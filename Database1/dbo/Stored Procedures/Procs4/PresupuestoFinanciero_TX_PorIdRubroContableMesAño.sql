CREATE Procedure [dbo].[PresupuestoFinanciero_TX_PorIdRubroContableMesAño]

@IdRubroContable int,
@Mes int,
@Año int,
@Tipo varchar(1)

AS 

SELECT Sum(IsNull(PresupuestoIngresos,0)+IsNull(PresupuestoEgresos,0)) as [Presupuesto]
FROM PresupuestoFinanciero
WHERE IdRubroContable=@IdRubroContable and Año=@Año and Mes=@Mes and IsNull(Tipo,'M')=@Tipo