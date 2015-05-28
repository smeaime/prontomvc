CREATE Procedure [dbo].[PresupuestosVentas_T]

@IdPresupuestoVenta int

AS 

SELECT *
FROM PresupuestosVentas
WHERE (IdPresupuestoVenta=@IdPresupuestoVenta)