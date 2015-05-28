




CREATE Procedure [dbo].[Proveedores_TX_Busca]
@Buscar varchar(50)
as 
Select 
 IdProveedor,
 RazonSocial as [Titulo]
From Proveedores
Where Eventual is null  and (Confirmado is null or Confirmado<>'NO') and 
	RazonSocial LIKE '%' + @buscar + '%' 
Order by RazonSocial




