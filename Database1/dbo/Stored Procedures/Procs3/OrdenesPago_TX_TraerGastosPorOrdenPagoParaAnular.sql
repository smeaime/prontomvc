CREATE Procedure [dbo].[OrdenesPago_TX_TraerGastosPorOrdenPagoParaAnular]

@IdOrdenPago int,
@IdOrdenPagoComplementaria int

AS

SELECT cp.IdComprobanteProveedor
FROM ComprobantesProveedores cp
WHERE cp.IdProveedor is null and (cp.IdOrdenPago=@IdOrdenPago or cp.IdOrdenPago=@IdOrdenPagoComplementaria)