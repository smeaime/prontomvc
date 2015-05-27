





























CREATE PROCEDURE [dbo].[LMateriales_TX_TodasLasRevisiones]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='00111111133'
set @vector_T='00324424200'
SELECT
Det.IdDetalleLMaterialesRevisiones,
Det.IdLMateriales,
'L.Materiales' as [Tipo],
LMateriales.Nombre as [Nombre],
LMateriales.Fecha as [Fecha],
LMateriales.NumeroLMateriales as [Nro.Interno],
Det.NumeroRevision as [Nro.Rev.],
Det.Fecha as [Fec.Rev.],
(Select Empleados.Nombre From Empleados Where Det.IdRealizo=Empleados.IdEmpleado) as [Realizo],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleLMaterialesRevisiones Det
LEFT OUTER JOIN LMateriales ON Det.IdLMateriales=LMateriales.IdLMateriales
Order by LMateriales.NumeroLMateriales






























