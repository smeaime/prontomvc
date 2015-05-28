CREATE  Procedure [dbo].[Choferes_M]

@IdChofer int ,
@Nombre varchar(50),
@PathImagen1 varchar(200),
@NumeroDocumento varchar(20),
@Cuil varchar(13)

AS

UPDATE Choferes
SET
 Nombre=@Nombre,
 PathImagen1=@PathImagen1,
 NumeroDocumento=@NumeroDocumento,
 Cuil=@Cuil
WHERE (IdChofer=@IdChofer)

RETURN(@IdChofer)