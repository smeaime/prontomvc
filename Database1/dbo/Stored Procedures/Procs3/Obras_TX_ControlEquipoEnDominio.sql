


CREATE Procedure [dbo].[Obras_TX_ControlEquipoEnDominio]
@IdObra int,
@IdArticulo int
AS
SELECT Obras.*
FROM DetalleObrasEquiposInstalados doei
LEFT OUTER JOIN Obras ON doei.IdObra=Obras.IdObra
WHERE doei.IdObra<>@IdObra and doei.IdArticulo=@IdArticulo and 
	Obras.FechaFinalizacion is null and doei.FechaDesinstalacion is null


