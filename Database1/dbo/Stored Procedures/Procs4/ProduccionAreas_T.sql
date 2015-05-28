
create Procedure ProduccionAreas_T
@IdProduccionArea int
AS 
SELECT * 
FROM ProduccionAreas
WHERE (IdProduccionArea=@IdProduccionArea)
