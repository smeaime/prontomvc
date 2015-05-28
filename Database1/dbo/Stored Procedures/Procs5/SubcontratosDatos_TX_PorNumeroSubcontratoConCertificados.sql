
CREATE Procedure [dbo].[SubcontratosDatos_TX_PorNumeroSubcontratoConCertificados]

@NumeroSubcontrato int = Null,
@IdProveedor int = Null

AS 

SET @NumeroSubcontrato=IsNull(@NumeroSubcontrato,-1)
SET @IdProveedor=IsNull(@IdProveedor,-1)

SELECT Det.*, Proveedores.RazonSocial as [Proveedor], C.NumeroSubcontrato, C.IdProveedor, C.PorcentajeAnticipoFinanciero, C.NumeroSubcontrato, C.DescripcionSubcontrato
FROM DetalleSubcontratosDatos Det
LEFT OUTER JOIN SubcontratosDatos C ON C.IdSubcontratoDatos=Det.IdSubcontratoDatos
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=C.IdProveedor
WHERE (@NumeroSubcontrato=-1 or C.NumeroSubcontrato=@NumeroSubcontrato) and (@IdProveedor=-1 or C.IdProveedor=@IdProveedor) 
ORDER BY Proveedores.RazonSocial, C.NumeroSubcontrato, Det.NumeroCertificado
