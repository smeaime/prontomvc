CREATE Procedure [dbo].[EmpleadosAccesos_A]

@IdEmpleadoAcceso int  output,
@IdEmpleado int,
@Nodo varchar(50),
@Acceso bit,
@Nivel int,
@FechaDesdeParaModificacion datetime,
@FechaInicialHabilitacion datetime,
@FechaFinalHabilitacion datetime,
@CantidadAccesos int,
@FechaUltimaModificacion datetime,
@IdUsuarioModifico int,
@UsuarioNTUsuarioModifico varchar(50)

AS

INSERT INTO EmpleadosAccesos
(
 IdEmpleado,
 Nodo,
 Acceso,
 Nivel,
 FechaDesdeParaModificacion,
 FechaInicialHabilitacion,
 FechaFinalHabilitacion,
 CantidadAccesos,
 FechaUltimaModificacion,
 IdUsuarioModifico,
 UsuarioNTUsuarioModifico
)
VALUES
(
 @IdEmpleado,
 @Nodo,
 @Acceso,
 @Nivel,
 @FechaDesdeParaModificacion,
 @FechaInicialHabilitacion,
 @FechaFinalHabilitacion,
 @CantidadAccesos,
 @FechaUltimaModificacion,
 @IdUsuarioModifico,
 @UsuarioNTUsuarioModifico
)

SELECT @IdEmpleadoAcceso=@@identity

RETURN(@IdEmpleadoAcceso)