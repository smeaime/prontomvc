CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_TotalAvancePorMes]

@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int,
@Mes int,
@Año int

AS

SELECT Sum(IsNull(CantidadAvance,0)) as [TotalAvanceMes]
FROM PresupuestoObrasNodosPxQxPresupuestoPorDia
WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto and Mes=@Mes and Año=@Año