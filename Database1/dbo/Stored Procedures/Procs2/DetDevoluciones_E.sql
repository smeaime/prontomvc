﻿






























CREATE Procedure [dbo].[DetDevoluciones_E]
@IdDetalleDevoluciones int
AS 
Delete DetalleDevoluciones
where (IdDetalleDevolucion=@IdDetalleDevoluciones)































