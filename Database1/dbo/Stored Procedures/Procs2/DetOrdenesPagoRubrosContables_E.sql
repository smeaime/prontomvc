﻿CREATE Procedure [dbo].[DetOrdenesPagoRubrosContables_E]

@IdDetalleOrdenPagoRubrosContables int

AS

DELETE DetalleOrdenesPagoRubrosContables
WHERE (IdDetalleOrdenPagoRubrosContables=@IdDetalleOrdenPagoRubrosContables)