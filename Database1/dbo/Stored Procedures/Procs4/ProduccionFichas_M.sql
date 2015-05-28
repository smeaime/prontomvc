
--exec ProduccionFichas_E 3

--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure ProduccionFichas_M

	@IdProduccionFicha int,

	@Observaciones ntext,

	@IdColor int,

--con las que me conformo
	@Codigo varchar(20) ,
	@Descripcion varchar(50) ,
	@Cantidad numeric(18,2),
	@IdUnidad int,
	@Minimo numeric(18,2),

        @IdArticuloAsociado int,

	@ArchivoAdjunto1 varchar(100) =NULL,
	@ArchivoAdjunto2 varchar(100) =NULL,
		@EstaActiva  varchar(2)

AS

UPDATE ProduccionFichas
SET
 Observaciones=@Observaciones,
 IdColor=@IdColor,

Codigo=@Codigo,
Descripcion=@Descripcion,
Cantidad=@Cantidad,
IdUnidad=@IdUnidad ,
Minimo=@Minimo,

IdArticuloAsociado=@IdArticuloAsociado,

ArchivoAdjunto1=@ArchivoAdjunto1,
ArchivoAdjunto2=@ArchivoAdjunto2,
EstaActiva=@EstaActiva

WHERE (IdProduccionFicha=@IdProduccionFicha)


RETURN(@IdProduccionFicha)
