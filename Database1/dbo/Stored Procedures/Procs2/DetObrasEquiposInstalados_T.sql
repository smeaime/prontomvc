CREATE Procedure [dbo].[DetObrasEquiposInstalados_T]

@IdDetalleObraEquipoInstalado int

AS 

SELECT *
FROM [DetalleObrasEquiposInstalados]
WHERE (IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado)