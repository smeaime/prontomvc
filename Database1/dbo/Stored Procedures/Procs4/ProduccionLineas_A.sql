create Procedure ProduccionLineas_A
@IdProduccionLinea int output,
@IdProduccionSector int,
@Codigo varchar(20),
@Descripcion varchar(50)

AS 

INSERT INTO [ProduccionLineas]
(
IdProduccionSector,
Codigo,
Descripcion
)
VALUES
(
@IdProduccionSector,
@Codigo,
@Descripcion
)

SELECT @IdProduccionLinea=@@identity
RETURN(@IdProduccionLinea)
