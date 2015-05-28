CREATE Procedure [dbo].[DetObrasEquiposInstalados2_A]

@IdDetalleObraEquipoInstalado2 int output,
@IdDetalleObraEquipoInstalado int,
@IdObra int,
@IdArticulo int,
@FechaInstalacion datetime,
@FechaDesinstalacion datetime,
@Observaciones ntext

AS 

INSERT INTO [DetalleObrasEquiposInstalados2]
(
 IdDetalleObraEquipoInstalado,
 IdObra,
 IdArticulo,
 FechaInstalacion,
 FechaDesinstalacion,
 Observaciones
)
VALUES
(
 @IdDetalleObraEquipoInstalado,
 @IdObra,
 @IdArticulo,
 @FechaInstalacion,
 @FechaDesinstalacion,
 @Observaciones
)

SELECT @IdDetalleObraEquipoInstalado2=@@identity

RETURN(@IdDetalleObraEquipoInstalado2)