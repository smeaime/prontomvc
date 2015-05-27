CREATE Procedure [dbo].[Valores_TX_Buscar]

@NumeroValor numeric(18,0) = Null,
@IdTipoValor int = Null,
@Importe numeric(18,2) = Null

AS 

SET @NumeroValor=IsNull(@NumeroValor,-1)
SET @IdTipoValor=IsNull(@IdTipoValor,-1)
SET @Importe=IsNull(@Importe,-1)

SELECT Valores.*, Bancos.Nombre as [Banco], Proveedores.RazonSocial as [Proveedor]
FROM Valores
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=Valores.IdProveedor
WHERE (@NumeroValor=-1 or NumeroValor=@NumeroValor) and 
	(@IdTipoValor=-1 or IsNull(IdTipoValor,IdTipoComprobante)=@IdTipoValor) and 
	(@Importe=-1 or Importe=@Importe)