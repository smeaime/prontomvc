


CREATE PROCEDURE [dbo].[Facturas_TX_NCs_RecuperoGastos]

@IdFactura int

AS

SET NOCOUNT ON

Declare @IdComprobanteProveedor int, @IdNotaCredito int

Set @IdComprobanteProveedor=IsNull((Select Top 1 IdComprobanteProveedor
					From ComprobantesProveedores
					Where IdFacturaVenta_RecuperoGastos=@IdFactura),0)

Set @IdNotaCredito=IsNull((Select Top 1 IdNotaCredito
				From NotasCredito
				Where IdFacturaVenta_RecuperoGastos=@IdFactura),0)

SET NOCOUNT OFF

SELECT 	@IdComprobanteProveedor as [IdComprobanteProveedor], 
	@IdNotaCredito as [IdNotaCredito]




