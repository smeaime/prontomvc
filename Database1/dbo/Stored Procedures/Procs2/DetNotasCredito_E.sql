﻿





























CREATE Procedure [dbo].[DetNotasCredito_E]
@IdDetalleNotasCredito int
AS 
Delete DetalleNotasCredito
where (IdDetalleNotaCredito=@IdDetalleNotasCredito)






























