CREATE Procedure [dbo].[Regiones_A]

@IdRegion int  output,
@Descripcion varchar(50),
@Codigo int

AS 

INSERT INTO [Regiones]
(
 Descripcion,
 Codigo
)
VALUES
(
 @Descripcion,
 @Codigo
)

SELECT @IdRegion=@@identity

RETURN(@IdRegion)