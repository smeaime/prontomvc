CREATE Procedure [dbo].[Acciones_TX_ParaLista]

AS 

DECLARE @vector_X varchar(40),@vector_T varchar(40)

SET @vector_X='011133'
SET @vector_T='019900'

SELECT 
 IdAccion as [IdAccion],
 Codigo+' '+Descripcion as [Titulo],
 IdAccion as [IdAux1],
 Codigo as [IdAux2],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Acciones 
ORDER BY Codigo
