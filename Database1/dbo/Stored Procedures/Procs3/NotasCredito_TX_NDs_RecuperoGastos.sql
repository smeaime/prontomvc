


CREATE PROCEDURE [dbo].[NotasCredito_TX_NDs_RecuperoGastos]

@IdNotaCredito int

AS

SET NOCOUNT ON

Declare @IdComprobanteProveedor int, @IdNotaDebito int

Set @IdComprobanteProveedor=IsNull((Select Top 1 IdComprobanteProveedor
					From ComprobantesProveedores
					Where IdNotaCreditoVenta_RecuperoGastos=@IdNotaCredito),0)

Set @IdNotaDebito=IsNull((Select Top 1 IdNotaDebito
				From NotasDebito
				Where IdNotaCreditoVenta_RecuperoGastos=@IdNotaCredito),0)

SET NOCOUNT OFF

SELECT @IdComprobanteProveedor as [IdComprobanteProveedor], 
	@IdNotaDebito as [IdNotaDebito]




