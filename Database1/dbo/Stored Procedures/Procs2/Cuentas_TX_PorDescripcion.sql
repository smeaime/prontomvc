CREATE Procedure [dbo].[Cuentas_TX_PorDescripcion]

@Descripcion varchar(50),
@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

SELECT TOP 1 *
FROM Cuentas
WHERE IdTipoCuenta=2 and Len(LTrim(IsNull(Descripcion,'')))>0 and Upper(Descripcion)=Upper(@Descripcion) and (@IdObra<=0 or IdObra=@IdObra)