
create Procedure ProduccionPlanes_T
@IdProduccionPlan int
AS 
SELECT * 
FROM ProduccionPlanes
WHERE (IdProduccionPlan=@IdProduccionPlan)
