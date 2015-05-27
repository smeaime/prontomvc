

CREATE Procedure [dbo].[Empleados_TX_PorGruposDelSector]
@IdSector int
AS 
SELECT DISTINCT GrupoDeCarga as [Grupo]
FROM Empleados
WHERE IdSector=@IdSector and IsNull(Activo,'SI')='SI'
ORDER BY GrupoDeCarga

