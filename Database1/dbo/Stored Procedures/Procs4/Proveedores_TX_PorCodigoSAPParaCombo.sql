































CREATE Procedure [dbo].[Proveedores_TX_PorCodigoSAPParaCombo]
AS 
Select 
 IdProveedor,
 Case 	When CodigoEmpresa is null
	 Then RazonSocial
	Else CodigoEmpresa+' - '+RazonSocial 
 End as [Titulo]
FROM Proveedores
WHERE Eventual is null
ORDER by [Titulo]































