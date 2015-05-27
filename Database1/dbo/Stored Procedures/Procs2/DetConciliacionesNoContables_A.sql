
CREATE Procedure [dbo].[DetConciliacionesNoContables_A]

@IdDetalleConciliacionNoContable int output,
@IdConciliacion int,
@Detalle varchar(50),
@FechaIngreso datetime,
@FechaCaducidad datetime,
@FechaRegistroContable datetime,
@Ingresos numeric(18,2),
@Egresos numeric(18,2)

AS 

INSERT INTO [DetalleConciliacionesNoContables]
(
 IdConciliacion,
 Detalle,
 FechaIngreso,
 FechaCaducidad,
 FechaRegistroContable,
 Ingresos,
 Egresos
)
VALUES
(
 @IdConciliacion,
 @Detalle,
 @FechaIngreso,
 @FechaCaducidad,
 @FechaRegistroContable,
 @Ingresos,
 @Egresos
)

SELECT @IdDetalleConciliacionNoContable=@@identity
RETURN(@IdDetalleConciliacionNoContable)
