





























CREATE Procedure [dbo].[DetPresupuestosHHObrasPorMes_T]
@IdDetallePresupuestoHHObrasPorMes int
AS 
SELECT *
FROM [DetallePresupuestosHHObrasPorMes]
WHERE (IdDetallePresupuestoHHObrasPorMes=@IdDetallePresupuestoHHObrasPorMes)






























