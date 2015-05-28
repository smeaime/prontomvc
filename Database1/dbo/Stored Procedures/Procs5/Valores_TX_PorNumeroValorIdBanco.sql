
CREATE Procedure [dbo].[Valores_TX_PorNumeroValorIdBanco]

@NumeroValor numeric(18),
@IdBanco int

AS 

SELECT TOP 1 
 Valores.*,
 Bancos.Nombre as [Banco],
 Proveedores.RazonSocial as [Proveedor]
FROM Valores
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Valores.IdProveedor
WHERE Valores.NumeroValor=@NumeroValor and Valores.IdBanco=@IdBanco
