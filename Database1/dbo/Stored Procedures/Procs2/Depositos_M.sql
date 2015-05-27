
CREATE  Procedure [dbo].[Depositos_M]

@IdDeposito int ,
@Descripcion varchar(50),
@Abreviatura varchar(10),
@IdObra int

AS

UPDATE Depositos
SET
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura,
 IdObra=@IdObra
WHERE (IdDeposito=@IdDeposito)

RETURN(@IdDeposito)
