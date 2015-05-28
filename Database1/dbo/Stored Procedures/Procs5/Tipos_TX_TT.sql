
CREATE Procedure [dbo].[Tipos_TX_TT]

@IdTipo int

AS 

SELECT 
 IdTipo,
 Descripcion as [Descripcion],
 Abreviatura as [Abrev.],
 Codigo as [Codigo]
FROM Tipos
WHERE IdTipo=@IdTipo and IsNull(Grupo,0)=0
