CREATE Procedure ProduccionAreas_TL
AS 
Select 
IdProduccionArea, Descripcion as [Titulo]
FROM ProduccionAreas
ORDER by IdProduccionArea
