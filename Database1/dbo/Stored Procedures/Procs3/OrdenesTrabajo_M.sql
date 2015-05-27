
CREATE  Procedure [dbo].[OrdenesTrabajo_M]

@IdOrdenTrabajo int ,
@NumeroOrdenTrabajo varchar(20),
@Descripcion varchar(50),
@FechaInicio datetime,
@FechaEntrega datetime,
@FechaFinalizacion datetime,
@TrabajosARealizar ntext,
@IdOrdeno int,
@IdSuperviso int,
@Observaciones ntext,
@IdEquipoDestino int

AS

UPDATE OrdenesTrabajo
SET
 NumeroOrdenTrabajo=@NumeroOrdenTrabajo,
 Descripcion=@Descripcion,
 FechaInicio=@FechaInicio,
 FechaEntrega=@FechaEntrega,
 FechaFinalizacion=@FechaFinalizacion,
 TrabajosARealizar=@TrabajosARealizar,
 IdOrdeno=@IdOrdeno,
 IdSuperviso=@IdSuperviso,
 Observaciones=@Observaciones,
 IdEquipoDestino=@IdEquipoDestino
WHERE (IdOrdenTrabajo=@IdOrdenTrabajo)

RETURN(@IdOrdenTrabajo)
