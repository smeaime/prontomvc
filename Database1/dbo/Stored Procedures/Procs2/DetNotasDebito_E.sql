﻿





























CREATE Procedure [dbo].[DetNotasDebito_E]
@IdDetalleNotasDebito int
AS 
Delete DetalleNotasDebito
where (IdDetalleNotaDebito=@IdDetalleNotasDebito)






























