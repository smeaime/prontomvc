﻿





























CREATE Procedure [dbo].[DetNotasCreditoImp_E]
@IdDetalleNotaCreditoImputaciones int
AS 
Delete DetalleNotasCreditoImputaciones
where (IdDetalleNotaCreditoImputaciones=@IdDetalleNotaCreditoImputaciones)






























