CREATE Procedure [dbo].[PresupuestoObrasNodosPxQxPresupuesto_TX_PorIdPresupuestoObrasNodoCodigoPresupuestoAñoMes]

@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int,
@Año int,
@Mes int

AS

SELECT * 
FROM PresupuestoObrasNodosPxQxPresupuesto
WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto and Año=@Año and Mes=@Mes

