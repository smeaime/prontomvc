





























CREATE Procedure [dbo].[FacturasCompra_T]
@IdFacturaCompra int
AS 
SELECT*
FROM FacturasCompra
where (IdFacturaCompra=@IdFacturaCompra)






























