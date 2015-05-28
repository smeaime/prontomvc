





























CREATE PROCEDURE [dbo].[DetLMaterialesRevisiones_TXAcoRev]
@IdLMateriales int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001111101101133'
set @vector_T='0000024001401400'
SELECT
DetAco.IdDetalleLMaterialesRevisiones,
DetAco.IdLMateriales,
DetAco.IdDetalleLMateriales,
DetAco.NumeroItem as [Item],
DetAco.TipoRegistro as [Tipo],
DetAco.NumeroRevision as [Numero],
DetAco.Fecha,
DetAco.Detalle,
DetAco.IdRealizo,
(Select Empleados.Iniciales From Empleados Where DetAco.IdRealizo=Empleados.IdEmpleado) as Realizo,
DetAco.FechaRealizacion as [Fecha realiz.],
DetAco.IdAprobo,
(Select Empleados.Iniciales From Empleados Where DetAco.IdAprobo=Empleados.IdEmpleado) as Aprobo,
DetAco.FechaAprobacion as [Fecha aprob.],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleLMaterialesRevisiones DetAco
WHERE DetAco.IdLMateriales = @IdLMateriales
ORDER by DetAco.NumeroItem






























