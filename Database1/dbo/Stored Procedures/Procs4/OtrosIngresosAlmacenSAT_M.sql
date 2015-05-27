
CREATE Procedure [dbo].[OtrosIngresosAlmacenSAT_M]
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
@FechaAnulacion datetime
AS
UPDATE OtrosIngresosAlmacenSAT
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
 FechaAnulacion=@FechaAnulacion
WHERE (IdOtroIngresoAlmacen=@IdOtroIngresoAlmacen)
RETURN(@IdOtroIngresoAlmacen)
