





























CREATE PROCEDURE [dbo].[DetAcopiosRevisiones_TXAcoRevTodos]
@IdAcopio int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001111111133'
set @vector_T='0000240040400'
SELECT
DetAco.IdDetalleAcopiosRevisiones,
DetAco.IdAcopio,
DetAco.IdDetalleAcopio,
DetAco.NumeroItem as [Item],
DetAco.NumeroRevision as [Numero],
DetAco.Fecha,
DetAco.Detalle,
(Select Empleados.Nombre From Empleados Where DetAco.IdRealizo=Empleados.IdEmpleado) as Realizo,
DetAco.FechaRealizacion as [Fecha realiz.],
(Select Empleados.Nombre From Empleados Where DetAco.IdAprobo=Empleados.IdEmpleado) as Aprobo,
DetAco.FechaAprobacion as [Fecha aprob.],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcopiosRevisiones DetAco
WHERE (DetAco.IdAcopio = @IdAcopio)
order by DetAco.NumeroItem






























