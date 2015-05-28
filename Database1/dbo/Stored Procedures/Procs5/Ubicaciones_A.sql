
CREATE Procedure [dbo].[Ubicaciones_A]

@IdUbicacion int  output,
@Descripcion varchar(50),
@Estanteria varchar(2),
@Modulo varchar(4),
@Gabeta varchar(4),
@IdDeposito int

AS 

INSERT INTO [Ubicaciones]
(
 Descripcion,
 Estanteria,
 Modulo,
 Gabeta,
 IdDeposito
)
VALUES
(
 @Descripcion,
 @Estanteria,
 @Modulo,
 @Gabeta,
 @IdDeposito
)

SELECT @IdUbicacion=@@identity
RETURN(@IdUbicacion)
