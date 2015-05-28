
CREATE Procedure [dbo].[Proveedores_TX_PorCuitParcial]

@Cuit varchar(13)

AS 

SELECT 
 Proveedores.IdProveedor,
 Proveedores.RazonSocial as [Titulo]
FROM Proveedores
LEFT OUTER JOIN [Estados Proveedores] ep ON Proveedores.IdEstado = ep.IdEstado
WHERE IsNull(Proveedores.Eventual,'NO')='NO' and IsNull(Proveedores.Confirmado,'SI')='SI' and IsNull(ep.Activo,'SI')='SI' and 
	Substring(IsNull(Cuit,''),1,Len(@Cuit))=@Cuit
ORDER by Proveedores.RazonSocial
