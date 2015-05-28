create Procedure ProduccionAreas_E
@IdProduccionArea int
AS 
DELETE [ProduccionAreas]
WHERE (IdProduccionArea=@IdProduccionArea)


