





























CREATE Procedure [dbo].[Presupuestos_TX_BonificacionesPorNumero]
@Numero int,
@SubNumero int
AS 
SELECT 
Sum(DetallePresupuestos.ImporteBonificacion) as [Bonificaciones]
FROM Presupuestos
Left Outer Join DetallePresupuestos On DetallePresupuestos.IdPresupuesto=Presupuestos.IdPresupuesto
WHERE Presupuestos.Numero=@Numero AND Presupuestos.SubNumero=@SubNumero






























