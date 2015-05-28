CREATE Procedure [dbo].[ListasPrecios_TX_ParaArbol]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1	(
			 A_IdListaPrecios INTEGER,
			 A_NumeroLista INTEGER,
			 A_Descripcion VARCHAR(50),
			 A_Moneda VARCHAR(50)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  IdListaPrecios,
  NumeroLista,
  Descripcion,
  Monedas.Nombre
 FROM ListasPrecios
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=ListasPrecios.IdMoneda

SET NOCOUNT OFF

SELECT 
 A_IdListaPrecios as [IdListaPrecios],
 'Lista ' + Convert(varchar,A_NumeroLista) + ' - ' + 
  A_Descripcion + ' (en ' + A_Moneda + ')' as [Lista]
FROM #Auxiliar1
ORDER by A_NumeroLista

DROP TABLE #Auxiliar1