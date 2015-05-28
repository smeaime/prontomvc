
CREATE Procedure [dbo].[OtrosIngresosAlmacen_M]
@IdOtroIngresoAlmacen int,
@NumeroOtroIngresoAlmacen int,
@FechaOtroIngresoAlmacen datetime,
@IdObra int,
@Observaciones ntext,
@Aprobo int,
@TipoIngreso int,
@Emitio int,
@FechaRegistracion datetime,
@EnviarEmail tinyint,
@IdOtroIngresoAlmacenOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime,
@Anulado varchar(2),
@IdAutorizaAnulacion int,
@FechaAnulacion datetime,
@IdSalidaMateriales int = Null,
@CircuitoFirmasCompleto varchar(2) = Null
AS
UPDATE OtrosIngresosAlmacen
SET 
 NumeroOtroIngresoAlmacen=@NumeroOtroIngresoAlmacen,
 FechaOtroIngresoAlmacen=@FechaOtroIngresoAlmacen,
 IdObra=@IdObra,
 Observaciones=@Observaciones,
 Aprobo=@Aprobo,
 TipoIngreso=@TipoIngreso,
 Emitio=@Emitio,
 FechaRegistracion=@FechaRegistracion,
 EnviarEmail=@EnviarEmail,
 IdOtroIngresoAlmacenOriginal=@IdOtroIngresoAlmacenOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 FechaImportacionTransmision=@FechaImportacionTransmision,
 Anulado=@Anulado,
 IdAutorizaAnulacion=@IdAutorizaAnulacion,
 FechaAnulacion=@FechaAnulacion,
 IdSalidaMateriales=@IdSalidaMateriales,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto
WHERE (IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen)
RETURN(@IdOtroIngresoAlmacen)
