
CREATE Procedure [dbo].[DetCuentas_M]

@IdDetalleCuenta int,
@IdCuenta int,
@NombreAnterior varchar(50),
@FechaCambio datetime,
@CodigoAnterior int,
@JerarquiaAnterior varchar(20)

AS

UPDATE [DetalleCuentas]
SET 
 IdCuenta=@IdCuenta,
 NombreAnterior=@NombreAnterior,
 FechaCambio=@FechaCambio,
 CodigoAnterior=@CodigoAnterior,
 JerarquiaAnterior=@JerarquiaAnterior
WHERE (IdDetalleCuenta=@IdDetalleCuenta)

RETURN(@IdDetalleCuenta)
