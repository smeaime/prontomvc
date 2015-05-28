﻿CREATE PROCEDURE [dbo].[DetOrdenesPagoRendicionesFF_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0133'
SET @vector_T='0800'

SELECT TOP 1
 DetOP.IdDetalleOrdenPagoRendicionesFF,
 DetOP.NumeroRendicion as [Nro.Rendicion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPagoRendicionesFF DetOP