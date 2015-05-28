CREATE Procedure [dbo].[DetDefinicionesFlujoCajaCtas_A]

@IdDetalleDefinicionFlujoCaja int  output,
@IdDefinicionFlujoCaja int,
@IdCuenta int,
@IdRubroContable int,
@OtroConcepto varchar(50)

AS

INSERT INTO [DetalleDefinicionesFlujoCajaCuentas]
(
 IdDefinicionFlujoCaja,
 IdCuenta,
 IdRubroContable,
 OtroConcepto
)
VALUES
(
 @IdDefinicionFlujoCaja,
 @IdCuenta,
 @IdRubroContable,
 @OtroConcepto
)

SELECT @IdDetalleDefinicionFlujoCaja=@@identity

RETURN(@IdDetalleDefinicionFlujoCaja)