




CREATE Procedure [dbo].[Cajas_TX_PorIdCuentaParaCombo]
@IdCuenta int
AS 
Select 
 IdCaja,
 Descripcion as [Titulo]
From Cajas
Where IdCuenta=@IdCuenta
Order by Descripcion




