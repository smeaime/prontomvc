
CREATE Procedure [dbo].[DetNotasDebito_M]

@IdDetalleNotaDebito int,
@IdNotaDebito int,
@IdConcepto int,
@Importe numeric(19,2),
@Gravado varchar(2),
@IdDiferenciaCambio int,
@IvaNoDiscriminado numeric(19,2),
@IdCuentaBancaria int,
@IdCaja int

AS

UPDATE DetalleNotasDebito
SET 
 IdNotaDebito=@IdNotaDebito,
 IdConcepto=@IdConcepto,
 Importe=@Importe,
 Gravado=@Gravado,
 IdDiferenciaCambio=@IdDiferenciaCambio,
 IvaNoDiscriminado=@IvaNoDiscriminado,
 IdCuentaBancaria=@IdCuentaBancaria,
 IdCaja=@IdCaja
WHERE (IdDetalleNotaDebito=@IdDetalleNotaDebito)

RETURN(@IdDetalleNotaDebito)
