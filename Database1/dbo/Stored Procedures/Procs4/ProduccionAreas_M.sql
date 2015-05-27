

create Procedure ProduccionAreas_M
@IdProduccionArea int output,
@Codigo varchar(20),
@Descripcion varchar(50)
AS 

UPDATE ProduccionAreas
SET
Codigo=@Codigo,
Descripcion=@Descripcion
where (IdProduccionArea=@IdProduccionArea)

RETURN(@IdProduccionArea)
