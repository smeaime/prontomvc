





























CREATE Procedure [dbo].[FacturasCompra_TX_DetallePorComprobanteSinFormato]
@TipoComprobante int,
@IdComprobante int
AS 
Select *
FROM FacturasCompra
Where TipoComprobante=@TipoComprobante and IdComprobante=@IdComprobante






























