
CREATE  Procedure [dbo].[PatronesGPS_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011133'
SET @vector_T='059200'

SELECT 
 PatronesGPS.IdPatronGPS,
 PatronesGPS.Descripcion as [Descripcion patron],
 PatronesGPS.IdPatronGPS as [IdAux],
 PatronesGPS.Activa as [Activa],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PatronesGPS
ORDER BY Descripcion
