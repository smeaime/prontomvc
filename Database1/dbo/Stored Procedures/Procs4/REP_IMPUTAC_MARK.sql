
CREATE procedure [dbo].[REP_IMPUTAC_MARK] 

@IdSubdiario  int 

AS 

IF Exists(Select Top 1 _BorradoSubdiarios.IdSubdiario
	 From _BorradoSubdiarios
	 Where _BorradoSubdiarios.IdSubdiario=@IdSubdiario)
   BEGIN
	DELETE FROM _BorradoSubdiarios
	WHERE _BorradoSubdiarios.IdSubdiario=@IdSubdiario
   END
ELSE
   BEGIN
	UPDATE Subdiarios 
	SET REP_IMPUTAC_UPD = 'R', REP_IMPUTAC_INS = 'R' 
	WHERE IdSubdiario=@IdSubdiario
   END
