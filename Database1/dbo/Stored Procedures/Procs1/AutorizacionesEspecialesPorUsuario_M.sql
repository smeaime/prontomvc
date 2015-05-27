
CREATE  Procedure [dbo].[AutorizacionesEspecialesPorUsuario_M]

@IdAutorizacionEspecialUsuario int ,
@IdUsuario int,
@IdCuenta int

AS

UPDATE AutorizacionesEspecialesPorUsuario
SET
 IdUsuario=@IdUsuario,
 IdCuenta=@IdCuenta
WHERE (IdAutorizacionEspecialUsuario=@IdAutorizacionEspecialUsuario)

RETURN(@IdAutorizacionEspecialUsuario)
