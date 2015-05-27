CREATE Procedure ProduccionPlanes_TL
AS 
Select 
IdProduccionPlan--, Descripcion as [Titulo]
FROM ProduccionPlanes 
ORDER by IdProduccionPlan
