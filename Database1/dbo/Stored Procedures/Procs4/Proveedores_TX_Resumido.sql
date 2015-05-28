
CREATE  Procedure [dbo].[Proveedores_TX_Resumido]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011133'
SET @vector_T='055500'

SELECT 
 Proveedores.IdProveedor, 
 Proveedores.RazonSocial as [Razon social], 
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.NombreFantasia as [Nombre comercial],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Proveedores
WHERE IsNull(Eventual,'NO')='NO' and (Confirmado is null or Confirmado<>'NO')
ORDER BY Proveedores.RazonSocial
