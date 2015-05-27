




CREATE Procedure [dbo].[DetNotasCredito_M]
@IdDetalleNotaCredito int,
@IdNotaCredito int,
@IdConcepto int,
@Importe numeric(19,2),
@Gravado varchar(2),
@IdDiferenciaCambio int,
@IvaNoDiscriminado numeric(19,2),
@IdCuentaBancaria int,
@IdCaja int
As
Update DetalleNotasCredito
Set 
 IdNotaCredito=@IdNotaCredito,
 IdConcepto=@IdConcepto,
 Importe=@Importe,
 Gravado=@Gravado,
 IdDiferenciaCambio=@IdDiferenciaCambio,
 IvaNoDiscriminado=@IvaNoDiscriminado,
 IdCuentaBancaria=@IdCuentaBancaria,
 IdCaja=@IdCaja
Where (IdDetalleNotaCredito=@IdDetalleNotaCredito)
Return(@IdDetalleNotaCredito)




