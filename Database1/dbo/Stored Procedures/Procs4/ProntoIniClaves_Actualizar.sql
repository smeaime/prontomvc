
CREATE Procedure [dbo].[ProntoIniClaves_Actualizar]

@IdProntoIniClave int output,
@Clave varchar(1000),
@Descripcion ntext = Null,
@ValorPorDefecto varchar(1000) = Null

AS 

IF @IdProntoIniClave<=0
    BEGIN
	INSERT INTO [ProntoIniClaves]
	(Clave, Descripcion, ValorPorDefecto)
	VALUES
	(@Clave, @Descripcion, @ValorPorDefecto)
	SELECT @IdProntoIniClave=@@identity
    END
ELSE
    BEGIN
	UPDATE ProntoIniClaves
	SET Clave=@Clave, Descripcion=@Descripcion, ValorPorDefecto=@ValorPorDefecto
	WHERE (IdProntoIniClave=@IdProntoIniClave)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdProntoIniClave
