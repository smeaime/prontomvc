CREATE Procedure [dbo].[Marcas_A]

@IdMarca int  output,
@Descripcion varchar(50),
@Codigo int

AS 

INSERT INTO [Marcas]
(
 Descripcion,
 Codigo
)
VALUES
(
 @Descripcion,
 @Codigo
)

SELECT @IdMarca=@@identity

RETURN(@IdMarca)