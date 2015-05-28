﻿CREATE PROCEDURE [dbo].[DetOrdenesPagoRubrosContables_TXOrdenPago]

@IdOrdenPago int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01633'
SET @vector_T='01300'

SELECT
 DetOP.IdDetalleOrdenPagoRubrosContables,
 RubrosContables.Descripcion as [Rubro contable],
 DetOP.Importe,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPagoRubrosContables DetOP
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetOP.IdRubroContable
WHERE (DetOP.IdOrdenPago = @IdOrdenPago)