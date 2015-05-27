

create Procedure ProduccionProgRecursos_M
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

UPDATE ProduccionProgRecursos
SET
Fecha=@Fecha ,
IdMaquina=@IdMaquina ,

Cantidad=@Cantidad ,
ProgRecurso=@ProgRecurso ,

FechaInicio=@FechaInicio ,
FechaFinal=@FechaFinal ,

GrillaSerializada=@GrillaSerializada,

Fraccionado=@Fraccionado

where (IdProduccionProgRecurso=@IdProduccionProgRecurso)

RETURN(@IdProduccionProgRecurso)
