
CREATE Procedure [dbo].[wCuentas_TL]

AS 

SELECT IdCuenta, Descripcion + ' ' + Convert(varchar,Codigo) as [Titulo]
FROM Cuentas
WHERE IdTipoCuenta=2 and Len(LTrim(IsNull(Descripcion,'')))>0
GROUP By IdCuenta,Codigo,Descripcion
ORDER by Descripcion

