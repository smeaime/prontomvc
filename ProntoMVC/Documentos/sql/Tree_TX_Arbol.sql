ALTER Procedure [dbo].[Tree_TX_Arbol]
@GrupoMenu varchar(30) = Null
AS 
SET @GrupoMenu=IsNull(@GrupoMenu,'Principal')
SELECT *
FROM Tree
WHERE GrupoMenu=@GrupoMenu   --poner indice ac�
ORDER BY IdItem, Orden 