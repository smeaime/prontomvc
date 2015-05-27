CREATE Procedure [dbo].[Proveedores_TX_TodosParaCombo]

@Tipo varchar(1) = Null,
@Activos varchar(1) = Null,
@Formato varchar(1) = Null

AS 

SET @Tipo=IsNull(@Tipo,'T')
SET @Activos=IsNull(@Activos,'T')
SET @Formato=IsNull(@Formato,'1')

SELECT 
 Proveedores.IdProveedor,
 Case When @Formato='1' Then Proveedores.RazonSocial+IsNull(' ('+CodigoEmpresa+')','') Else Proveedores.RazonSocial End as [Titulo]
FROM Proveedores
LEFT OUTER JOIN [Estados Proveedores] ep ON Proveedores.IdEstado = ep.IdEstado
WHERE IsNull(Proveedores.Confirmado,'SI')='SI' and 
	(@Activos='T' or 
		(@Activos='A' and IsNull(ep.Activo,'SI')='SI') or 
		(@Activos='I' and IsNull(ep.Activo,'SI')='NO')) and 
	(@Tipo='T' or 
		(@Tipo='N' and IsNull(Proveedores.Eventual,'NO')='NO') or 
		(@Tipo='E' and IsNull(Proveedores.Eventual,'NO')='SI'))
ORDER by Proveedores.RazonSocial