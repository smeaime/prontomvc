create Procedure ProduccionPlanes_E
@IdProduccionPlan int
AS 
DELETE [ProduccionPlanes]
WHERE (IdProduccionPlan=@IdProduccionPlan)


