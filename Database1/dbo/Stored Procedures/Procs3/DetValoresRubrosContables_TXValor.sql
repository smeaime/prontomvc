
CREATE PROCEDURE [dbo].[DetValoresRubrosContables_TXValor]
@IdValor int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01633'
set @vector_T='04200'
SELECT
 DetV.IdDetalleValorRubrosContables,
 RubrosContables.Descripcion as [Rubro contable],
 DetV.Importe,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleValoresRubrosContables DetV
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetV.IdRubroContable
WHERE (DetV.IdValor = @IdValor)
