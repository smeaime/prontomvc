CREATE Procedure [dbo].[BancoChequeras_A]

@IdBancoChequera int  output,
@IdBanco int,
@IdCuentaBancaria int,
@NumeroChequera int,
@DesdeCheque int,
@HastaCheque int,
@Fecha datetime,
@ProximoNumeroCheque int,
@Activa varchar(2),
@ChequeraPagoDiferido varchar(2)

AS

INSERT INTO [BancoChequeras]
(
 IdBanco,
 IdCuentaBancaria,
 NumeroChequera,
 DesdeCheque,
 HastaCheque,
 Fecha,
 ProximoNumeroCheque,
 Activa,
 ChequeraPagoDiferido
)
VALUES
(
 @IdBanco,
 @IdCuentaBancaria,
 @NumeroChequera,
 @DesdeCheque,
 @HastaCheque,
 @Fecha,
 @ProximoNumeroCheque,
 @Activa,
 @ChequeraPagoDiferido
)

SELECT @IdBancoChequera=@@identity

RETURN(@IdBancoChequera)