
create Procedure ProduccionAreas_A
@IdProduccionArea int output,
@Codigo varchar(20),
@Descripcion varchar(50)

AS 

INSERT INTO [ProduccionAreas]
(
Codigo,
Descripcion
)
VALUES
(
@Codigo,
@Descripcion
)

SELECT @IdProduccionArea=@@identity
RETURN(@IdProduccionArea)
