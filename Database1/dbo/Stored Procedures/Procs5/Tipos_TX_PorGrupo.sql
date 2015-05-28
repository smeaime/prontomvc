
CREATE Procedure [dbo].[Tipos_TX_PorGrupo]

@Grupo int

AS 

SELECT 
 IdTipo,
 Descripcion as [Descripcion],
 Abreviatura as [Abrev.],
 Codigo as [Codigo]
FROM Tipos
WHERE IsNull(Grupo,0)=@Grupo
ORDER BY Descripcion
