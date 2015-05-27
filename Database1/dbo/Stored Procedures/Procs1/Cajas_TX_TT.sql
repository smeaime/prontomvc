













CREATE Procedure [dbo].[Cajas_TX_TT]
@IdCaja int
As 
Select 
 IdCaja,
 Cajas.Descripcion as [Titulo],
 Cuentas.Codigo as [Cod.Cta.],
 Cuentas.Descripcion as [Cuenta],
 Monedas.Nombre as [Moneda]
From Cajas
Left Outer Join Cuentas On Cuentas.IdCuenta=Cajas.IdCuenta
Left Outer Join Monedas On Monedas.IdMoneda=Cajas.IdMoneda
Where (IdCaja=@IdCaja)













