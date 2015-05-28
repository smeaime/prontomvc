--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure ProduccionFichas_A

@IdProduccionFicha int  output,

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

BEGIN TRAN

INSERT INTO ProduccionFichas
(
	Observaciones,
	IdColor,
--con las que me conformo
	Codigo ,
	Descripcion ,
	Cantidad ,
	IdUnidad ,
	Minimo ,

        IdArticuloAsociado ,

	ArchivoAdjunto1,
	ArchivoAdjunto2,
		EstaActiva  

)
VALUES
(
 	@Observaciones,
	@IdColor,
--con las que me conformo
	@Codigo ,
	@Descripcion ,
	@Cantidad ,
	@IdUnidad ,
	@Minimo ,

        @IdArticuloAsociado ,

	@ArchivoAdjunto1 ,
	@ArchivoAdjunto2 ,
	@EstaActiva  

)

SELECT @IdProduccionFicha=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdProduccionFicha)
