
CREATE Procedure [dbo].[Asientos_A]

@IdAsiento int  output,
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

INSERT INTO [Asientos]
(
 NumeroAsiento,
 FechaAsiento,
 Ejercicio,
 IdCuentaSubdiario,
 Concepto,
 Tipo,
 IdIngreso,
 FechaIngreso,
 IdModifico,
 FechaUltimaModificacion,
 AsientoApertura,
 BaseConsolidadaHija,
 FechaGeneracionConsolidado,
 ArchivoImportacion,
 AsignarAPresupuestoObra
)
VALUES
(
 @NumeroAsiento,
 @FechaAsiento,
 @Ejercicio,
 @IdCuentaSubdiario,
 @Concepto,
 @Tipo,
 @IdIngreso,
 @FechaIngreso,
 @IdModifico,
 @FechaUltimaModificacion,
 @AsientoApertura,
 @BaseConsolidadaHija,
 @FechaGeneracionConsolidado,
 @ArchivoImportacion,
 @AsignarAPresupuestoObra
)
SELECT @IdAsiento=@@identity
RETURN(@IdAsiento)
