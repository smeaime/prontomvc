﻿






























CREATE Procedure [dbo].[DetRecibos_E]
@IdDetalleRecibo int
AS 
Delete DetalleRecibos
where (IdDetalleRecibo=@IdDetalleRecibo)































