


CREATE Procedure [dbo].[DetCuentas_E]
@IdDetalleCuenta int  
AS 
DELETE DetalleCuentas
WHERE (IdDetalleCuenta=@IdDetalleCuenta)


