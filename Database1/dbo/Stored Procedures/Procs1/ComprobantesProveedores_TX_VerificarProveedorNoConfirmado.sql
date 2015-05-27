





CREATE Procedure [dbo].[ComprobantesProveedores_TX_VerificarProveedorNoConfirmado]
@IdComprobanteProveedor int
AS 
SELECT 
 Case When Proveedores.Confirmado is not null 
	Then Proveedores.Confirmado
	Else 'SI'
 End as [Confirmado]
FROM ComprobantesProveedores cp
LEFT OUTER JOIN Proveedores ON  cp.IdProveedor = Proveedores.IdProveedor
WHERE (cp.IdComprobanteProveedor=@IdComprobanteProveedor)





