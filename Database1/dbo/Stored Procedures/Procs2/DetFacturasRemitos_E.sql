﻿






























CREATE Procedure [dbo].[DetFacturasRemitos_E]
@IdDetalleFacturaRemitos int
AS 
Delete DetalleFacturasRemitos
Where (IdDetalleFacturaRemitos=@IdDetalleFacturaRemitos)































