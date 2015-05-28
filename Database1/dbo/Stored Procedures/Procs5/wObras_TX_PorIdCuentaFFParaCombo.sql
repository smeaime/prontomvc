
CREATE Procedure [dbo].[wObras_TX_PorIdCuentaFFParaCombo]
@IdCuentaContableFF int
AS 
SELECT IdObra
--,NumeroObra as [Titulo]  --version original
,NumeroObra + ' - ' + Descripcion as [Titulo] 
FROM Obras
WHERE (IdCuentaContableFF=@IdCuentaContableFF)

