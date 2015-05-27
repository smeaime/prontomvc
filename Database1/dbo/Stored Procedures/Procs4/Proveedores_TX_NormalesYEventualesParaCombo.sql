
CREATE Procedure [dbo].[Proveedores_TX_NormalesYEventualesParaCombo]

AS 

SELECT 
 Proveedores.IdProveedor,
 Proveedores.RazonSocial+Case When Proveedores.Eventual is not null Then ' - (Eventual)' Else '' End as [Titulo]
FROM Proveedores
LEFT OUTER JOIN [Estados Proveedores] ep ON Proveedores.IdEstado = ep.IdEstado
WHERE (Proveedores.Confirmado is null or Proveedores.Confirmado<>'NO') and IsNull(ep.Activo,'SI')='SI'
ORDER by Proveedores.RazonSocial
