CREATE Procedure [dbo].[AutorizacionesEspecialesPorUsuario_A]

@IdAutorizacionEspecialUsuario int  output,
@IdUsuario int,
@IdCuenta int

AS 

INSERT INTO [AutorizacionesEspecialesPorUsuario]
(
 IdUsuario,
 IdCuenta
)
VALUES
(
 @IdUsuario,
 @IdCuenta
)

SELECT @IdAutorizacionEspecialUsuario=@@identity

RETURN(@IdAutorizacionEspecialUsuario)
