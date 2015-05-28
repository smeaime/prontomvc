

CREATE   Procedure [dbo].[PresupuestoObrasNodos_ArreglaDirectorio]

AS 

--incializa raices
UPDATE presupuestoobrasnodos 
SET Lineage='/', Depth=0 
WHERE IdNodoPadre Is Null
--pone todos los childs
WHILE EXISTS (SELECT * FROM presupuestoobrasnodos WHERE Depth is null) 
	UPDATE T 
	SET T.depth = P.Depth + 1, T.Lineage = P.Lineage + Ltrim(Str(T.IdNodoPadre,6,0)) + '/' 
	FROM presupuestoobrasnodos AS T 
	INNER JOIN presupuestoobrasnodos AS P ON (T.IdNodoPadre=P.idpresupuestoobrasnodo) 
	WHERE P.Depth>=0 AND P.Lineage Is Not Null AND T.Depth Is Null

