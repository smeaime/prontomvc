CREATE Procedure [dbo].[Obras_TX_ValidarEquiposInstalados]

@IdArticulo int,
@IdDetalleObraEquipoInstalado2 int

AS 

SELECT doei2.*, Articulos.Codigo as [Equipo], Obras.NumeroObra as [Obra]
FROM DetalleObrasEquiposInstalados2 doei2
LEFT OUTER JOIN DetalleObrasEquiposInstalados doei ON doei.IdDetalleObraEquipoInstalado=doei2.IdDetalleObraEquipoInstalado
LEFT OUTER JOIN Obras ON Obras.IdObra=doei2.IdObra
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=doei.IdArticulo
WHERE (doei2.IdDetalleObraEquipoInstalado2<=0 or doei2.IdDetalleObraEquipoInstalado2<>@IdDetalleObraEquipoInstalado2) and doei2.IdArticulo=@IdArticulo and doei2.FechaDesinstalacion is null