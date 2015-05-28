
CREATE Procedure [dbo].[OtrosIngresosAlmacenSAT_A]
@IdOtroIngresoAlmacen int  output,
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
INSERT INTO OtrosIngresosAlmacenSAT
(
 NumeroOtroIngresoAlmacen,
 FechaOtroIngresoAlmacen,
 IdObra,
 Observaciones,
 Aprobo,
 TipoIngreso,
 Emitio,
 FechaRegistracion,
 EnviarEmail,
 IdOtroIngresoAlmacenOriginal,
 IdOrigenTransmision,
 FechaImportacionTransmision,
 Anulado,
 IdAutorizaAnulacion,
 FechaAnulacion
)
VALUES
(
 @NumeroOtroIngresoAlmacen,
 @FechaOtroIngresoAlmacen,
 @IdObra,
 @Observaciones,
 @Aprobo,
 @TipoIngreso,
 @Emitio,
 GetDate(),
 @EnviarEmail,
 @IdOtroIngresoAlmacenOriginal,
 @IdOrigenTransmision,
 @FechaImportacionTransmision,
 @Anulado,
 @IdAutorizaAnulacion,
 @FechaAnulacion
)
SELECT @IdOtroIngresoAlmacen=@@identity
RETURN(@IdOtroIngresoAlmacen)
