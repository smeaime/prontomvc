





























CREATE Procedure [dbo].[DetNotasCreditoImp_M]
@IdDetalleNotaCreditoImputaciones int,
@IdNotaCredito int,
@IdImputacion int,
@Importe money
as
Update DetalleNotasCreditoImputaciones
SET 
 IdNotaCredito=@IdNotaCredito,
 IdImputacion=@IdImputacion,
 Importe=@Importe
	
where (IdDetalleNotaCreditoImputaciones=@IdDetalleNotaCreditoImputaciones)
Return(@IdDetalleNotaCreditoImputaciones)






























