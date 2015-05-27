

create Procedure ProduccionLineas_M
@IdProduccionLinea int output,
@IdProduccionSector int,
@Codigo varchar(20),
@Descripcion varchar(50)
AS 

UPDATE ProduccionLineas
SET
IdProduccionSector=@IdProduccionSector,
Codigo=@Codigo,
Descripcion=@Descripcion
where (IdProduccionLinea=@IdProduccionLinea)

RETURN(@IdProduccionLinea)
