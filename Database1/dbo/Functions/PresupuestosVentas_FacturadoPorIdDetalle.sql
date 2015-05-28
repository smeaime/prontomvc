CREATE FUNCTION [dbo].[PresupuestosVentas_FacturadoPorIdDetalle](@IdDetallePresupuestoVenta int)
RETURNS NUMERIC(18,2)

BEGIN
	DECLARE @Total numeric(18,2)
	SET @Total = IsNull((Select Sum(IsNull(df.Cantidad,0))
				From DetalleFacturas df
				Left Outer Join Facturas On Facturas.IdFactura=df.IdFactura
				Where IsNull(Facturas.Anulada,'')<>'SI' and df.IdDetallePresupuestoVenta=@IdDetallePresupuestoVenta),0)

	RETURN @Total
END
