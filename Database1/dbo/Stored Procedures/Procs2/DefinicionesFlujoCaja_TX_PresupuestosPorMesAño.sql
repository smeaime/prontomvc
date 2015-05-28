CREATE Procedure [dbo].[DefinicionesFlujoCaja_TX_PresupuestosPorMesAño]

@IdDefinicionFlujoCaja int,
@Mes int,
@Año int

AS 

SELECT SUM(IsNull(dfcp.Presupuesto,0)) as [Presupuesto]
FROM DetalleDefinicionesFlujoCajaPresupuestos dfcp
WHERE dfcp.IdDefinicionFlujoCaja=@IdDefinicionFlujoCaja and dfcp.Mes=@Mes and dfcp.Año=@Año