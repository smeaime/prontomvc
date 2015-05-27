
CREATE Procedure [dbo].[AutorizacionesEspecialesPorUsuario_E]

@IdAutorizacionEspecialUsuario int  

AS 

DELETE AutorizacionesEspecialesPorUsuario
WHERE (IdAutorizacionEspecialUsuario=@IdAutorizacionEspecialUsuario)
