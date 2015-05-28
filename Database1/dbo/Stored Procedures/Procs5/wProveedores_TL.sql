
CREATE PROCEDURE [dbo].[wProveedores_TL]
AS 
SELECT IdProveedor, RazonSocial as [Titulo]
FROM Proveedores
--WHERE IsNull(Eventual,'NO')='NO' and IsNull(Confirmado,'SI')='SI'
ORDER BY RazonSocial

