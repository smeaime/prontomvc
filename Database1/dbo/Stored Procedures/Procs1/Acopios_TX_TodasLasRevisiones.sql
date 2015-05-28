































CREATE PROCEDURE [dbo].[Acopios_TX_TodasLasRevisiones]
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
Order by Acopios.NumeroAcopio
































