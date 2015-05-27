
CREATE Procedure [dbo].[DetNotasCredito_A]

@IdDetalleNotaCredito int  output,
@IdNotaCredito int,
@IdConcepto int,
@Importe numeric(19,2),
@Gravado varchar(2),
@IdDiferenciaCambio int,
@IvaNoDiscriminado numeric(19,2),
@IdCuentaBancaria int,
@IdCaja int

AS

INSERT INTO [DetalleNotasCredito]
(
 IdNotaCredito,
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
 @IdNotaCredito,
 @IdConcepto,
 @Importe,
 @Gravado,
 @IdDiferenciaCambio,
 @IvaNoDiscriminado,
 @IdCuentaBancaria,
 @IdCaja
)

SELECT @IdDetalleNotaCredito=@@identity
RETURN(@IdDetalleNotaCredito)
