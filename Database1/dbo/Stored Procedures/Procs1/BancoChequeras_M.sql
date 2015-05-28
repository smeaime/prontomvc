


CREATE  Procedure [dbo].[BancoChequeras_M]
@IdBancoChequera int ,
@IdBanco int,
@IdCuentaBancaria int,
@NumeroChequera int,
@DesdeCheque int,
@HastaCheque int,
@Fecha datetime,
@ProximoNumeroCheque int,
@Activa varchar(2),
@ChequeraPagoDiferido varchar(2)
As
Update BancoChequeras
Set
 IdBanco=@IdBanco,
 IdCuentaBancaria=@IdCuentaBancaria,
 NumeroChequera=@NumeroChequera,
 DesdeCheque=@DesdeCheque,
 HastaCheque=@HastaCheque,
 Fecha=@Fecha,
 ProximoNumeroCheque=@ProximoNumeroCheque,
 Activa=@Activa,
 ChequeraPagoDiferido=@ChequeraPagoDiferido
Where (IdBancoChequera=@IdBancoChequera)
Return(@IdBancoChequera)


