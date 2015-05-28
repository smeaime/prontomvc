
CREATE Procedure [dbo].[wSubrubros_A]

@IdSubrubro int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)

AS

IF IsNull(@IdSubrubro,0)<=0
    BEGIN
	INSERT INTO Subrubros
	(
	 Descripcion,
	 Abreviatura
	)
	VALUES
	(
	 @Descripcion,
	 @Abreviatura
	)
	
	SELECT @IdSubrubro=@@identity
    END
ELSE
    BEGIN
	UPDATE Subrubros
	SET 
	 Descripcion=@Descripcion,
	 Abreviatura=@Abreviatura
	WHERE (IdSubrubro=@IdSubrubro)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdSubrubro

