



CREATE Procedure [dbo].[Presupuestos_TX_PorNumeroConDatos]
@Numero int,
@SubNumero int
AS 
SELECT 
 Presupuestos.*,
 IsNull(Monedas.Abreviatura,Monedas.Nombre) as [Moneda],
 Proveedores.RazonSocial as [Proveedor]
FROM Presupuestos
LEFT OUTER JOIN Proveedores ON Presupuestos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON Presupuestos.IdMoneda = Monedas.IdMoneda
WHERE Numero=@Numero AND SubNumero=@SubNumero



