CREATE PROCEDURE [dbo].[DetPlazosFijosRubrosContables_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01633'
SET @vector_T='05500'

SELECT TOP 1
 Det.IdDetallePlazoFijoRubrosContables,
 RubrosContables.Descripcion as [Rubro contable],
 Det.Importe,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePlazosFijosRubrosContables Det
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable