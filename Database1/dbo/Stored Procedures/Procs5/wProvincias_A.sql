
CREATE Procedure [dbo].[wProvincias_A]

@IdProvincia int  output,
@Nombre varchar(50),
@Codigo varchar(2),
@IdPais int

AS

IF IsNull(@IdProvincia,0)<=0
    BEGIN
	INSERT INTO Provincias
	(
	 Nombre,
	 Codigo,
	 IdPais
	)
	VALUES
	(
	 @Nombre,
	 @Codigo,
	 @IdPais
	)
	SELECT @IdProvincia=@@identity
    END
ELSE
    BEGIN
	UPDATE Provincias
	SET 
	 Nombre=@Nombre,
	 Codigo=@Codigo,
	 IdPais=@IdPais
	WHERE (IdProvincia=@IdProvincia)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdProvincia

