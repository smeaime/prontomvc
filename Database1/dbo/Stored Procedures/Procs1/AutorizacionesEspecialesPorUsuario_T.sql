

CREATE Procedure [dbo].[AutorizacionesEspecialesPorUsuario_T]

@IdAutorizacionEspecialUsuario int

AS 

SELECT *
FROM AutorizacionesEspecialesPorUsuario
WHERE (IdAutorizacionEspecialUsuario=@IdAutorizacionEspecialUsuario)
