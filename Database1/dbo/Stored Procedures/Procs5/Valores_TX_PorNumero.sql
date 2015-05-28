CREATE Procedure [dbo].[Valores_TX_PorNumero]

@NumeroValor numeric(18),
@IdTipoValor int = Null

AS 

SET @IdTipoValor=IsNull(@IdTipoValor,-1)

SELECT TOP 1 
 Valores.*,
 Bancos.Nombre as [Banco],
 Proveedores.RazonSocial as [Proveedor]
FROM Valores
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Valores.IdProveedor
WHERE NumeroValor=@NumeroValor and (@IdTipoValor=-1 or IdTipoValor=@IdTipoValor)