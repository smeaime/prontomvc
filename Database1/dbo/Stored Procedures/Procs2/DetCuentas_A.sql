
CREATE Procedure [dbo].[DetCuentas_A]
@IdDetalleCuenta int  output,
@IdCuenta int,
@NombreAnterior varchar(50),
@FechaCambio datetime,
@CodigoAnterior int,
@JerarquiaAnterior varchar(20)
AS 
INSERT INTO [DetalleCuentas]
(
 IdCuenta,
 NombreAnterior,
 FechaCambio,
 CodigoAnterior,
 JerarquiaAnterior
)
VALUES 
(
 @IdCuenta,
 @NombreAnterior,
 @FechaCambio,
 @CodigoAnterior,
 @JerarquiaAnterior
)
SELECT @IdDetalleCuenta=@@identity
RETURN(@IdDetalleCuenta)
