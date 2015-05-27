CREATE Procedure [dbo].[Calles_A]

@IdCalle int  output,
@Nombre varchar(50)

AS 

INSERT INTO [Calles]
(
 Nombre
)
VALUES
(
 @Nombre
)

SELECT @IdCalle=@@identity

RETURN(@IdCalle)