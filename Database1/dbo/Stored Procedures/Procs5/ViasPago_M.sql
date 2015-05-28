
CREATE  Procedure [dbo].[ViasPago_M]

@IdViaPago int ,
@Codigo varchar(5),
@Descripcion varchar(50)

AS

UPDATE ViasPago
SET
 Codigo=@Codigo,
 Descripcion=@Descripcion
WHERE (IdViaPago=@IdViaPago)

RETURN(@IdViaPago)
