
CREATE Procedure [dbo].[OrdenesTrabajo_TX_TT]

@IdOrdenTrabajo int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111133'
SET @vector_T='0556665E22500'

SELECT
 OrdenesTrabajo.IdOrdenTrabajo,
 OrdenesTrabajo.NumeroOrdenTrabajo as [Orden trabajo],
 OrdenesTrabajo.Descripcion as [Descripcion],
 OrdenesTrabajo.FechaInicio as [Fecha inicio],
 OrdenesTrabajo.FechaEntrega as [Fecha entrega],
 OrdenesTrabajo.FechaFinalizacion  as [Fecha finalizacion],
 OrdenesTrabajo.TrabajosARealizar as [Trabajos a realizar],
 Articulos.Descripcion as [Equipo destino],
 E1.Nombre as [Ordeno],
 E2.Nombre as [Superviso],
 OrdenesTrabajo.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesTrabajo
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=OrdenesTrabajo.IdOrdeno
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=OrdenesTrabajo.IdSuperviso
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=OrdenesTrabajo.IdEquipoDestino
WHERE (IdOrdenTrabajo=@IdOrdenTrabajo)
