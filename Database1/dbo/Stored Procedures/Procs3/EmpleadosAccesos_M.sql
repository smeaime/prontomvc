CREATE  Procedure [dbo].[EmpleadosAccesos_M]

@IdEmpleadoAcceso int,
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

UPDATE EmpleadosAccesos
SET 
 IdEmpleado=@IdEmpleado,
 Nodo=@Nodo,
 Acceso=@Acceso,
 Nivel=@Nivel,
 FechaDesdeParaModificacion=@FechaDesdeParaModificacion,
 FechaInicialHabilitacion=@FechaInicialHabilitacion,
 FechaFinalHabilitacion=@FechaFinalHabilitacion,
 CantidadAccesos=@CantidadAccesos,
 FechaUltimaModificacion=@FechaUltimaModificacion,
 IdUsuarioModifico=@IdUsuarioModifico,
 UsuarioNTUsuarioModifico=@UsuarioNTUsuarioModifico
WHERE (IdEmpleadoAcceso=@IdEmpleadoAcceso)

RETURN(@IdEmpleadoAcceso)