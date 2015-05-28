
CREATE Procedure [dbo].[Cuentas_TX_SinObrasParaCombo]

AS 

SELECT  
 IdCuenta,
 Descripcion + ' ' + Convert(varchar,Codigo) as [Titulo]
FROM Cuentas
WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and IdObra is null
GROUP By IdCuenta,Codigo,Descripcion
ORDER by Descripcion
