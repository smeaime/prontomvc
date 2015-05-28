
CREATE Procedure [dbo].[Asientos_M]

@IdAsiento int,
@NumeroAsiento int,
@FechaAsiento datetime,
@Ejercicio int,
@IdCuentaSubdiario int,
@Concepto varchar(50),
@Tipo varchar(5),
@IdIngreso int,
@FechaIngreso datetime,
@IdModifico int,
@FechaUltimaModificacion datetime,
@AsientoApertura varchar(2),
@BaseConsolidadaHija varchar(50),
@FechaGeneracionConsolidado datetime,
@ArchivoImportacion varchar(200),
@AsignarAPresupuestoObra varchar(2)

AS

UPDATE Asientos
SET 
 NumeroAsiento=@NumeroAsiento,
 FechaAsiento=@FechaAsiento,
 Ejercicio=@Ejercicio,
 IdCuentaSubdiario=@IdCuentaSubdiario,
 Concepto=@Concepto,
 Tipo=@Tipo,
 IdIngreso=@IdIngreso,
 FechaIngreso=@FechaIngreso,
 IdModifico=@IdModifico,
 FechaUltimaModificacion=@FechaUltimaModificacion,
 AsientoApertura=@AsientoApertura,
 BaseConsolidadaHija=@BaseConsolidadaHija,
 FechaGeneracionConsolidado=@FechaGeneracionConsolidado,
 ArchivoImportacion=@ArchivoImportacion,
 AsignarAPresupuestoObra=@AsignarAPresupuestoObra
WHERE (IdAsiento=@IdAsiento)
RETURN(@IdAsiento)
