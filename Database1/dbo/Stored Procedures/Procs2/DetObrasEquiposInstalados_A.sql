CREATE Procedure [dbo].[DetObrasEquiposInstalados_A]

@IdDetalleObraEquipoInstalado int  output,
@IdObra int,
@IdArticulo int,
@Cantidad numeric(18,2),
@FechaInstalacion datetime,
@FechaDesinstalacion datetime,
@Observaciones ntext

AS 

INSERT INTO [DetalleObrasEquiposInstalados]
(
 IdObra,
 IdArticulo,
 Cantidad,
 FechaInstalacion,
 FechaDesinstalacion,
 Observaciones
)
VALUES
(
 @IdObra,
 @IdArticulo,
 @Cantidad,
 @FechaInstalacion,
 @FechaDesinstalacion,
 @Observaciones
)

SELECT @IdDetalleObraEquipoInstalado=@@identity

RETURN(@IdDetalleObraEquipoInstalado)