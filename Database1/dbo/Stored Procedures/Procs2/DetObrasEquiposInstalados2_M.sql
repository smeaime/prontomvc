CREATE Procedure [dbo].[DetObrasEquiposInstalados2_M]

@IdDetalleObraEquipoInstalado2 int,
@IdDetalleObraEquipoInstalado int,
@IdObra int,
@IdArticulo int,
@FechaInstalacion datetime,
@FechaDesinstalacion datetime,
@Observaciones ntext

AS 

UPDATE [DetalleObrasEquiposInstalados2]
SET 
 IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado,
 IdObra=@IdObra,
 IdArticulo=@IdArticulo,
 FechaInstalacion=@FechaInstalacion,
 FechaDesinstalacion=@FechaDesinstalacion,
 Observaciones=@Observaciones
WHERE (IdDetalleObraEquipoInstalado2=@IdDetalleObraEquipoInstalado2)

RETURN(@IdDetalleObraEquipoInstalado2)