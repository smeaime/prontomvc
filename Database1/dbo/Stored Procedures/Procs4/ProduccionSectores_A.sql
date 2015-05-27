create Procedure ProduccionSectores_A
@IdProduccionSector int output,
@IdProduccionArea int,
@Codigo varchar(20),
@Descripcion varchar(50)

AS 

INSERT INTO [ProduccionSectores]
(
IdProduccionArea,
Codigo,
Descripcion
)
VALUES
(
@IdProduccionArea,
@Codigo,
@Descripcion
)

SELECT @IdProduccionSector=@@identity
RETURN(@IdProduccionSector)
