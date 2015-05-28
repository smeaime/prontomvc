
CREATE Procedure [dbo].[wPaises_A]

@IdPais int  output,
@Descripcion varchar(50),
@Codigo varchar(3)

AS

IF IsNull(@IdPais,0)<=0
    BEGIN
	INSERT INTO Paises
	(
	 Descripcion,
	 Codigo
	)
	VALUES
	(
	 @Descripcion,
	 @Codigo
	)
	
	SELECT @IdPais=@@identity
    END
ELSE
    BEGIN
	UPDATE Paises
	SET 
	 Descripcion=@Descripcion,
	 Codigo=@Codigo
	WHERE (IdPais=@IdPais)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdPais

