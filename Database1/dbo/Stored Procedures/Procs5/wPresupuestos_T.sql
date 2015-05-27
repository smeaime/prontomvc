
CREATE Procedure [dbo].[wPresupuestos_T]
@IdPresupuesto int=null
AS 

SET @IdPresupuesto=IsNull(@IdPresupuesto,-1)

SELECT *,
Proveedores.RazonSocial as [Proveedor]
FROM Presupuestos Cab
LEFT OUTER JOIN Proveedores ON Cab.IdProveedor = Proveedores.IdProveedor
WHERE (@IdPresupuesto=-1 or IdPresupuesto=@IdPresupuesto)
order by idPresupuesto DESC

