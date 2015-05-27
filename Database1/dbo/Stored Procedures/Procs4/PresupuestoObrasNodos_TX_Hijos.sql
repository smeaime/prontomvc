


CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_Hijos]

@IdPresupuestoObrasNodo int

AS

SELECT * 
FROM PresupuestoObrasNodos
WHERE Patindex('%/'+Convert(varchar,@IdPresupuestoObrasNodo)+'/%',Lineage)>0 
ORDER BY Item


