CREATE Procedure [dbo].[Proveedores_TL]

AS 

SELECT 
 Proveedores.IdProveedor,
 Proveedores.RazonSocial+IsNull(' ('+Proveedores.CodigoEmpresa+')','') as [Titulo]
FROM Proveedores
LEFT OUTER JOIN [Estados Proveedores] ep ON Proveedores.IdEstado = ep.IdEstado
WHERE IsNull(Proveedores.Eventual,'NO')='NO' and IsNull(Proveedores.Confirmado,'SI')='SI' and IsNull(ep.Activo,'SI')='SI'
ORDER by Proveedores.RazonSocial