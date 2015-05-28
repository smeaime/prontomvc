CREATE Procedure [dbo].[DetObrasEquiposInstalados_E]

@IdDetalleObraEquipoInstalado int  

AS

DELETE [DetalleObrasEquiposInstalados]
WHERE (IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado)