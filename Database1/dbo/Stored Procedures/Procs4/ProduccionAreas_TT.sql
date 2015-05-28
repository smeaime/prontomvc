CREATE Procedure ProduccionAreas_TT
--@IdArticulo int
AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
---------------123456789012345678901234567890	
Set @vector_X='01133'
Set @vector_T='01100'
SELECT 
 ProduccionAreas.idProduccionArea,
 ProduccionAreas.Codigo,
 ProduccionAreas.Descripcion,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProduccionAreas
