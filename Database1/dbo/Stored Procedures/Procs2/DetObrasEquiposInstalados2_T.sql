CREATE Procedure [dbo].[DetObrasEquiposInstalados2_T]

@IdDetalleObraEquipoInstalado2 int

AS 

SELECT *
FROM [DetalleObrasEquiposInstalados2]
WHERE (IdDetalleObraEquipoInstalado2=@IdDetalleObraEquipoInstalado2)