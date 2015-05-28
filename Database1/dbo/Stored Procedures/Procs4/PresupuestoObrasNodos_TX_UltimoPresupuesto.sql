CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_UltimoPresupuesto]

@IdObra int

AS 

SELECT Max(P.NumeroPresupuesto) as [NumeroPresupuesto]
FROM PresupuestoObrasNodosPresupuestos P
WHERE P.IdObra=@IdObra