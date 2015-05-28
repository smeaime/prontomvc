CREATE Procedure Tipos_TX_PorGrupoParaCombo

@idGrupo int=null

AS 

SELECT IdTipo, Descripcion as [Titulo]
FROM Tipos 
WHERE IsNull(Grupo,0)=@idGrupo or @idgrupo is null
ORDER BY Descripcion