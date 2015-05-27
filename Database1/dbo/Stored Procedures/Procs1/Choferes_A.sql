CREATE Procedure [dbo].[Choferes_A]

@IdChofer int  output,
@Nombre varchar(50),
@PathImagen1 varchar(200),
@NumeroDocumento varchar(20),
@Cuil varchar(13)

AS 

INSERT INTO [Choferes]
(
 Nombre,
 PathImagen1,
 NumeroDocumento,
 Cuil
)
VALUES
(
 @Nombre,
 @PathImagen1,
 @NumeroDocumento,
 @Cuil
)

SELECT @IdChofer=@@identity

RETURN(@IdChofer)