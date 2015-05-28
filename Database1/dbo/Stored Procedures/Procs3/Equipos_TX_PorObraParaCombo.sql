





























CREATE PROCEDURE [dbo].[Equipos_TX_PorObraParaCombo]
@IdObra int
as
SELECT
Equipos.IdEquipo,
Equipos.Tag+'  -  ['+Equipos.Descripcion+']' as [Titulo]
FROM Equipos
WHERE (Equipos.IdObra = @IdObra)
ORDER By [Titulo]






























