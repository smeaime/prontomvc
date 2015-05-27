

create Procedure ProduccionSectores_M
@IdProduccionSector int output,
@IdProduccionArea int,
@Codigo varchar(20),
@Descripcion varchar(50)
AS 

UPDATE ProduccionSectores
SET
IdProduccionArea=@IdProduccionArea,
Codigo=@Codigo,
Descripcion=@Descripcion
where (IdProduccionSector=@IdProduccionSector)

RETURN(@IdProduccionSector)
