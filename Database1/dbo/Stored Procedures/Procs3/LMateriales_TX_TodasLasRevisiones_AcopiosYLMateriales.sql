





























CREATE PROCEDURE [dbo].[LMateriales_TX_TodasLasRevisiones_AcopiosYLMateriales]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='00111111133'
set @vector_T='00324424200'
SELECT
DetAco.IdDetalleAcopiosRevisiones,
DetAco.IdAcopio,
'L.Acopio' as [Tipo],
Acopios.Nombre as [Nombre],
Acopios.Fecha as [Fecha],
Acopios.NumeroAcopio as [Nro.Interno],
DetAco.NumeroRevision as [Nro.Rev.],
DetAco.Fecha as [Fec.Rev.],
(Select Empleados.Nombre From Empleados Where DetAco.IdRealizo=Empleados.IdEmpleado) as [Realizo],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcopiosRevisiones DetAco
LEFT OUTER JOIN Acopios ON DetAco.IdAcopio=Acopios.IdAcopio
Union All
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
Order by [Tipo],[Nro.Interno]






























