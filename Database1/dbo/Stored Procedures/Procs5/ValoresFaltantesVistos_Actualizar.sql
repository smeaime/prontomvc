CREATE Procedure [dbo].[ValoresFaltantesVistos_Actualizar]

@IdBancoChequera int,
@NumeroCheque numeric(18,0),
@IdUsuarioMarco int,
@MotivoMarcado varchar(30),
@Codigo int

AS 

DECLARE @IdValorFaltanteVisto int

SET @IdValorFaltanteVisto=IsNull((Select Top 1 IdValorFaltanteVisto From ValoresFaltantesVistos Where IdBancoChequera=@IdBancoChequera and NumeroCheque=@NumeroCheque),0)

IF @Codigo=1 
   BEGIN
	IF @IdValorFaltanteVisto=0
		INSERT INTO ValoresFaltantesVistos
		(IdBancoChequera, NumeroCheque, IdUsuarioMarco, FechaMarcado, MotivoMarcado)
		VALUES
		(@IdBancoChequera, @NumeroCheque, @IdUsuarioMarco, GetDate(), @MotivoMarcado)
   END
ELSE
   BEGIN
	IF @IdValorFaltanteVisto>0
		DELETE ValoresFaltantesVistos WHERE IdValorFaltanteVisto=@IdValorFaltanteVisto
   END