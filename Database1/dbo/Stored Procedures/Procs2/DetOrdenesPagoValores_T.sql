﻿
































CREATE Procedure [dbo].[DetOrdenesPagoValores_T]
@IdDetalleOrdenPagoValores int
AS 
SELECT *
FROM DetalleOrdenesPagoValores
where (IdDetalleOrdenPagoValores=@IdDetalleOrdenPagoValores)

































