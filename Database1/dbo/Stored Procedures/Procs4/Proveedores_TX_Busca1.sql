


























CREATE Procedure [dbo].[Proveedores_TX_Busca1]
@Buscar varchar(50)
AS 
SELECT 
 IdProveedor,
 Case 	When CodigoEmpresa is null
	 Then RazonSocial
	Else CodigoEmpresa+' - '+RazonSocial 
 End as [Titulo]
FROM Proveedores
WHERE Eventual is null  and (Confirmado is null or Confirmado<>'NO') and  
	 (RazonSocial LIKE '%' + @buscar + '%' OR CodigoEmpresa LIKE '%' + @buscar + '%')
ORDER by [Titulo]


























