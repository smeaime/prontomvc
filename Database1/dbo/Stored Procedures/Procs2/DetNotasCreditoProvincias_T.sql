




CREATE Procedure [dbo].[DetNotasCreditoProvincias_T]
@IdDetalleNotaCreditoProvincias int
AS 
SELECT *
FROM [DetalleNotasCreditoProvincias]
WHERE (IdDetalleNotaCreditoProvincias=@IdDetalleNotaCreditoProvincias)





