CREATE Procedure [dbo].[Valores_TX_PorTipoYNumeroComprobante]

@IdTipoComprobante int,
@NumeroComprobante int,
@IdValor int

AS 

SELECT Valores.*, Bancos.Nombre as [Banco], Proveedores.RazonSocial as [Proveedor]
FROM Valores
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Valores.IdProveedor
WHERE (@IdValor<=0 or Valores.IdValor<>@IdValor) and Valores.IdTipoComprobante=@IdTipoComprobante and Valores.NumeroComprobante=@NumeroComprobante