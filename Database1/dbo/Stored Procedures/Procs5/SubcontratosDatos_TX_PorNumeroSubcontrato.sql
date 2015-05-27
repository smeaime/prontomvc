CREATE Procedure [dbo].[SubcontratosDatos_TX_PorNumeroSubcontrato]

@NumeroSubcontrato int = Null,
@IdProveedor int = Null,
@IdSubcontratoDatos int = Null

AS 

SET @NumeroSubcontrato=IsNull(@NumeroSubcontrato,-1)
SET @IdProveedor=IsNull(@IdProveedor,-1)
SET @IdSubcontratoDatos=IsNull(@IdSubcontratoDatos,-1)

SELECT C.*, Proveedores.RazonSocial as [Proveedor], Monedas.Abreviatura as [Moneda], Proveedores.IdCodigoIva
FROM SubcontratosDatos C
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=C.IdProveedor
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=C.IdMoneda
WHERE (@NumeroSubcontrato=-1 or C.NumeroSubcontrato=@NumeroSubcontrato) and 
	(@IdProveedor=-1 or C.IdProveedor=@IdProveedor) and 
	(@IdSubcontratoDatos=-1 or C.IdSubcontratoDatos=@IdSubcontratoDatos) 
ORDER BY Proveedores.RazonSocial, C.NumeroSubcontrato