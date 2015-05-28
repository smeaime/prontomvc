create Procedure ProduccionProgRecursos_A

@IdProduccionProgRecurso int output,

@Fecha datetime,
@IdMaquina int,

@Cantidad numeric(18,2),
@ProgRecurso int,

@FechaInicio datetime,
@FechaFinal datetime,

@GrillaSerializada text,

@Fraccionado numeric(18,2)

AS 

INSERT INTO [ProduccionProgRecursos]
(
Fecha ,
IdMaquina ,

Cantidad ,
ProgRecurso ,

FechaInicio ,
FechaFinal ,
GrillaSerializada,
Fraccionado
)
VALUES
(
@Fecha ,
@IdMaquina ,

@Cantidad ,
@ProgRecurso ,

@FechaInicio ,
@FechaFinal ,
@GrillaSerializada,

@Fraccionado 

)
SELECT @IdProduccionProgRecurso=@@identity
RETURN(@IdProduccionProgRecurso)
