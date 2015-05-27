CREATE Procedure [dbo].[PresupuestoObrasRedeterminaciones_TX_PorIdPresupuestoObrasNodo]

@IdPresupuestoObrasNodo int

AS 

SELECT Año as [Año], Mes as [Mes], Sum(IsNull(Importe,0)) as [Importe] 
/*
IsNull((Select Top 1 ponpxq.PrecioVentaUnitario From PresupuestoObrasNodosPxQxPresupuesto ponpxq 
			Where ponpxq.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and ponpxq.Año=PresupuestoObrasRedeterminaciones.Año and ponpxq.Mes=PresupuestoObrasRedeterminaciones.Mes and ponpxq.CodigoPresupuesto=0),0) as [PrecioVentaUnitario]
*/
FROM PresupuestoObrasRedeterminaciones 
WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo
GROUP BY Año, Mes
ORDER BY Año, Mes
