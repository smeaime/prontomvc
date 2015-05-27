
CREATE  Procedure [dbo].[Ubicaciones_M]

@IdUbicacion int ,
@Descripcion varchar(50),
@Estanteria varchar(2),
@Modulo varchar(4),
@Gabeta varchar(4),
@IdDeposito int

AS

UPDATE Ubicaciones
SET
 Descripcion=@Descripcion,
 Estanteria=@Estanteria,
 Modulo=@Modulo,
 Gabeta=@Gabeta,
 IdDeposito=@IdDeposito
WHERE (IdUbicacion=@IdUbicacion)

RETURN(@IdUbicacion)
