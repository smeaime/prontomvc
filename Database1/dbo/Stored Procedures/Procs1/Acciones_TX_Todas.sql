CREATE Procedure [dbo].[Acciones_TX_Todas]

AS 

DECLARE @vector_X varchar(40),@vector_T varchar(40)

SET @vector_X='011133'
SET @vector_T='039500'

SELECT 
 IdAccion as [IdAccion],
 Codigo as [Codigo],
 IdAccion as [IdAux1],
 Descripcion as [Descripcion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Acciones 
ORDER BY Codigo
