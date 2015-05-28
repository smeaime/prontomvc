





























CREATE PROCEDURE [dbo].[DetLMaterialesRevisiones_TX_Avances]
@IdLMateriales int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='00011111101101133'
set @vector_T='00000024001401400'
SELECT
DetLMatR.IdDetalleLMaterialesRevisiones,
DetLMatR.IdLMateriales,
DetLMatR.IdDetalleLMateriales,
DetalleLMateriales.NumeroItem as [Conj.],
DetalleLMateriales.NumeroOrden as [Pos.],
DetalleLMateriales.Revision as [Rev.],
DetLMatR.NumeroRevision as [Numero],
DetLMatR.Fecha,
DetLMatR.Detalle,
DetLMatR.IdRealizo,
(Select Empleados.Iniciales From Empleados Where DetLMatR.IdRealizo=Empleados.IdEmpleado) as Realizo,
DetLMatR.FechaRealizacion as [Fecha realiz.],
DetLMatR.IdAprobo,
(Select Empleados.Iniciales From Empleados Where DetLMatR.IdAprobo=Empleados.IdEmpleado) as Aprobo,
DetLMatR.FechaAprobacion as [Fecha aprob.],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleLMaterialesRevisiones DetLMatR
LEFT OUTER JOIN DetalleLMateriales ON DetalleLMateriales.IdDetalleLMateriales=DetLMatR.IdDetalleLMateriales
WHERE DetLMatR.IdLMateriales = @IdLMateriales And DetLMatR.TipoRegistro='A'
ORDER by DetLMatR.NumeroItem






























