create Procedure ProduccionProcesos_A
@IdProduccionProceso int output,
@IdProduccionSector int,
@Codigo varchar(20),
@Descripcion varchar(50),

@Obligatorio varchar(2),
@Incorpora varchar(2),
@Valida varchar(2),
@ValidaFinal varchar(2) ,
@IdUbicacion INT 

AS 

INSERT INTO [ProduccionProcesos]
(
IdProduccionSector,
Codigo,
Descripcion,
Obligatorio,
Incorpora,
Valida ,
ValidaFinal,
IdUbicacion
)
VALUES
(
@IdProduccionSector,
@Codigo,
@Descripcion,
@Obligatorio,
@Incorpora,
@Valida, 
@ValidaFinal,
@IdUbicacion
)

SELECT @IdProduccionProceso=@@identity
RETURN(@IdProduccionProceso)
