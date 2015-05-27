
CREATE Procedure [dbo].[ProntoIni_Actualizar]

@IdProntoIni int output,
@IdUsuario int,
@IdProntoIniClave int,
@Valor varchar(1000)

AS 

DECLARE @IdProntoIni1 int
SET @IdProntoIni1=IsNull((Select Top 1 P.IdProntoIni From ProntoIni P 
			  Where P.IdUsuario=@IdUsuario and P.IdProntoIniClave=@IdProntoIniClave),0)

IF @IdProntoIni1=0
    BEGIN
	INSERT INTO [ProntoIni]
	(
	 IdUsuario,
	 IdProntoIniClave,
	 Valor
	)
	VALUES
	(
	 @IdUsuario,
	 @IdProntoIniClave,
	 @Valor
	)
	SELECT @IdProntoIni=@@identity
    END
ELSE
    BEGIN
	UPDATE ProntoIni
	SET 
	 IdUsuario=@IdUsuario,
	 IdProntoIniClave=@IdProntoIniClave,
	 Valor=@Valor
	WHERE (IdProntoIni=@IdProntoIni1)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdProntoIni
