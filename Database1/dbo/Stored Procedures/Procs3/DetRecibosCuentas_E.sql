﻿






























CREATE Procedure [dbo].[DetRecibosCuentas_E]
@IdDetalleReciboCuentas int
AS 
Delete DetalleRecibosCuentas
where (IdDetalleReciboCuentas=@IdDetalleReciboCuentas)































