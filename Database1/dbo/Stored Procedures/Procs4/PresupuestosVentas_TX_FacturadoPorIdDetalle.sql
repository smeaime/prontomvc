CREATE Procedure [dbo].[PresupuestosVentas_TX_FacturadoPorIdDetalle]

@IdDetallePresupuestoVenta int

AS

DECLARE @Total numeric(18,2)

SET @Total=dbo.PresupuestosVentas_FacturadoPorIdDetalle(@IdDetallePresupuestoVenta)

SELECT @Total as [Total]