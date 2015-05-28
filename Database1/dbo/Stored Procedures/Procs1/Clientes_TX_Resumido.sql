
CREATE  Procedure [dbo].[Clientes_TX_Resumido]

@IdVendedor int = Null

AS 

SET @IdVendedor=IsNull(@IdVendedor,-1)

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111133'
SET @vector_T='0511100'

SELECT 
 Clientes.IdCliente, 
 Clientes.RazonSocial as [Razon social],
 Clientes.Codigo as [Codigo],
 V1.Nombre as [Vendedor], 
 V2.Nombre as [Cobrador], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Clientes 
LEFT OUTER JOIN Vendedores V1 ON V1.IdVendedor=Clientes.Vendedor1
LEFT OUTER JOIN Vendedores V2 ON V2.IdVendedor=Clientes.Cobrador
WHERE IsNull(Clientes.Confirmado,'SI')='SI' and (@IdVendedor=-1 or Clientes.Vendedor1=@IdVendedor)
ORDER BY Clientes.RazonSocial
