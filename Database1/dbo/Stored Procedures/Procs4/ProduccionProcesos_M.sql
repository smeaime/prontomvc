

create Procedure ProduccionProcesos_M
@IdProduccionProceso int output,
@IdProduccionSector int,
@Codigo varchar(20),
@Descripcion varchar(50),

@Obligatorio varchar(2),
@Incorpora varchar(2),
@Valida varchar(2),
@ValidaFinal varchar(2) ,
@IdUbicacion int
AS 

UPDATE ProduccionProcesos
SET
IdProduccionSector=@IdProduccionSector,
Codigo=@Codigo,
Descripcion=@Descripcion,
Obligatorio=@Obligatorio,
Incorpora=@Incorpora,
Valida=@Valida,
ValidaFinal=@ValidaFinal,
IdUbicacion=@IdUbicacion

where (IdProduccionProceso=@IdProduccionProceso)

RETURN(@IdProduccionProceso)
