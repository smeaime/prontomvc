
CREATE Procedure [dbo].[OrdenesTrabajo_A]

@IdOrdenTrabajo int  output,
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

INSERT INTO [OrdenesTrabajo]
(
 NumeroOrdenTrabajo,
 Descripcion,
 FechaInicio,
 FechaEntrega,
 FechaFinalizacion,
 TrabajosARealizar,
 IdOrdeno,
 IdSuperviso,
 Observaciones,
 IdEquipoDestino
)
VALUES
(
 @NumeroOrdenTrabajo,
 @Descripcion,
 @FechaInicio,
 @FechaEntrega,
 @FechaFinalizacion,
 @TrabajosARealizar,
 @IdOrdeno,
 @IdSuperviso,
 @Observaciones,
 @IdEquipoDestino
)

SELECT @IdOrdenTrabajo=@@identity

RETURN(@IdOrdenTrabajo)
