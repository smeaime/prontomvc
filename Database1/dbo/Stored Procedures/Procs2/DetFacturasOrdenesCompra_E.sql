﻿






























CREATE Procedure [dbo].[DetFacturasOrdenesCompra_E]
@IdDetalleFacturaOrdenesCompra int
AS 
Delete DetalleFacturasOrdenesCompra
Where (IdDetalleFacturaOrdenesCompra=@IdDetalleFacturaOrdenesCompra)































