
CREATE Procedure [dbo].[DetNotasDebito_A]

@IdDetalleNotaDebito int  output,
@IdNotaDebito int,
@IdConcepto int,
@Importe numeric(19,2),
@Gravado varchar(2),
@IdDiferenciaCambio int,
@IvaNoDiscriminado numeric(19,2),
@IdCuentaBancaria int,
@IdCaja int

AS

INSERT INTO [DetalleNotasDebito]
(
 IdNotaDebito,
 IdConcepto,
 Importe,
 Gravado,
 IdDiferenciaCambio,
 IvaNoDiscriminado,
 IdCuentaBancaria,
 IdCaja
)
VALUES
(
 @IdNotaDebito,
 @IdConcepto,
 @Importe,
 @Gravado,
 @IdDiferenciaCambio,
 @IvaNoDiscriminado,
 @IdCuentaBancaria,
 @IdCaja
)

SELECT @IdDetalleNotaDebito=@@identity
RETURN(@IdDetalleNotaDebito)
