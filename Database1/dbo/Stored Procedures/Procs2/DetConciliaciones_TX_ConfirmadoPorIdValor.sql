
CREATE PROCEDURE [dbo].[DetConciliaciones_TX_ConfirmadoPorIdValor]
@IdValor int
AS
SELECT TOP 1 DetConc.IdDetalleConciliacion, DetConc.IdConciliacion, Conciliaciones.Numero
FROM DetalleConciliaciones DetConc
LEFT OUTER JOIN Conciliaciones ON DetConc.IdConciliacion=Conciliaciones.IdConciliacion
WHERE DetConc.IdValor=@IdValor and IsNull(DetConc.Conciliado,'SI')='SI'
