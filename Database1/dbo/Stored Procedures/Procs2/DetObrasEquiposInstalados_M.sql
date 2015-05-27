CREATE Procedure [dbo].[DetObrasEquiposInstalados_M]

@IdDetalleObraEquipoInstalado int,
@IdObra int,
@IdArticulo int,
@Cantidad numeric(18,2),
@FechaInstalacion datetime,
@FechaDesinstalacion datetime,
@Observaciones ntext

AS 

UPDATE [DetalleObrasEquiposInstalados]
SET 
 IdObra=@IdObra,
 IdArticulo=@IdArticulo,
 Cantidad=@Cantidad,
 FechaInstalacion=@FechaInstalacion,
 FechaDesinstalacion=@FechaDesinstalacion,
 Observaciones=@Observaciones
WHERE (IdDetalleObraEquipoInstalado=@IdDetalleObraEquipoInstalado)

RETURN(@IdDetalleObraEquipoInstalado)