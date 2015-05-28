




CREATE PROCEDURE [dbo].[Equipos_TXPorObra]
@IdObra int
AS
SELECT
 Equipos.IdEquipo,
 Equipos.Descripcion,
 Equipos.Tag,
 Equipos.IdGrupoTareaHH
FROM Equipos
WHERE Equipos.IdObra = @IdObra and Equipos.ActivoHH='SI'
GROUP BY Equipos.IdEquipo,Equipos.Descripcion,Equipos.Tag,Equipos.IdGrupoTareaHH
ORDER BY Equipos.Tag




