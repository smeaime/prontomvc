


CREATE Procedure [dbo].[DetCuentas_T]
@IdDetalleCuenta int
AS 
SELECT *
FROM DetalleCuentas
WHERE (IdDetalleCuenta=@IdDetalleCuenta)


