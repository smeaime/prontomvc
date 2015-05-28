CREATE PROCEDURE [dbo].[DetPlazosFijosRubrosContables_TXDet]

@IdPlazoFijo int,
@Tipo varchar(1)

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01633'
SET @vector_T='05500'

SELECT
 Det.IdDetallePlazoFijoRubrosContables,
 RubrosContables.Descripcion as [Rubro contable],
 Det.Importe,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePlazosFijosRubrosContables Det
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
WHERE Det.IdPlazoFijo = @IdPlazoFijo and (@Tipo='*' or IsNull(Det.Tipo,'')=@Tipo)