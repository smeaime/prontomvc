CREATE Procedure [dbo].[Conceptos_TX_PorGrupoParaCombo]

@Grupo int

AS 

SELECT IdConcepto, Descripcion as [Titulo]
FROM Conceptos 
WHERE IsNull(Grupo,0)=@Grupo
ORDER BY Descripcion