﻿






























CREATE Procedure [dbo].[DetAsientos_E]
@IdDetalleAsiento int
AS 
Delete DetalleAsientos
where (IdDetalleAsiento=@IdDetalleAsiento)































