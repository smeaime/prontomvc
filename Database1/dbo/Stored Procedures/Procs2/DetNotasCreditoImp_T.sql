





























CREATE Procedure [dbo].[DetNotasCreditoImp_T]
@IdDetalleNotaCreditoImputaciones int
AS 
SELECT *
FROM DetalleNotasCreditoImputaciones
where (IdDetalleNotaCreditoImputaciones=@IdDetalleNotaCreditoImputaciones)






























