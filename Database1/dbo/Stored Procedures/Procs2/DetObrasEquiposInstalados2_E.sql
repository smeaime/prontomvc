CREATE Procedure [dbo].[DetObrasEquiposInstalados2_E]

@IdDetalleObraEquipoInstalado2 int  

AS

DELETE [DetalleObrasEquiposInstalados2]
WHERE (IdDetalleObraEquipoInstalado2=@IdDetalleObraEquipoInstalado2)