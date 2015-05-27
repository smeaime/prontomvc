CREATE Procedure [dbo].[Subcontratos_TX_PendientesDeFacturar]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0011111133'
SET @vector_T='0034444100'

SELECT
 Det.IdDetalleSubcontratoDatos,
 Det.IdSubcontratoDatos,
 Det.NumeroCertificado as [Nro.Certificado],
 Det.FechaCertificado as [Fecha certificado],
 SubcontratosDatos.NumeroSubcontrato as [Nro.Subcontrato],
 Proveedores.RazonSocial as [Proveedor], 
 Monedas.Abreviatura as [Moneda],
 Det.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSubcontratosDatos Det
LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.IdSubcontratoDatos=Det.IdSubcontratoDatos
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=SubcontratosDatos.IdProveedor
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=SubcontratosDatos.IdMoneda
WHERE Not Exists(Select Top 1 dcp.IdDetalleSubcontratoDatos From DetalleComprobantesProveedores dcp Where dcp.IdDetalleSubcontratoDatos=Det.IdDetalleSubcontratoDatos)
ORDER BY Det.NumeroCertificado