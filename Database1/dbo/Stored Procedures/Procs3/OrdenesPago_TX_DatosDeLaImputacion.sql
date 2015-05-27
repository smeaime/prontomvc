
CREATE PROCEDURE [dbo].[OrdenesPago_TX_DatosDeLaImputacion]

@IdImputacion int

AS

SELECT 
 cp.TotalBruto*TiposComprobante.Coeficiente as [TotalBruto], 
 cp.NumeroReferencia, 
 cp.FechaComprobante, 
 cp.CircuitoFirmasCompleto, 
 CC.*
FROM CuentasCorrientesAcreedores CC
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CC.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CC.IdComprobante
WHERE CC.IdCtaCte = @IdImputacion
