CREATE Procedure [dbo].[ComprobantesProveedores_GrabarRetencionIva]

@IdComprobanteProveedor int,
@IdOrdenPagoRetencionIva int,
@ImporteRetencionIvaEnOrdenPago numeric(18,2)

AS

UPDATE ComprobantesProveedores
SET IdOrdenPagoRetencionIva=Case When @IdOrdenPagoRetencionIva=0 Then Null Else @IdOrdenPagoRetencionIva End, 
	ImporteRetencionIvaEnOrdenPago=Case When @ImporteRetencionIvaEnOrdenPago=0 Then Null Else @ImporteRetencionIvaEnOrdenPago End
WHERE IdComprobanteProveedor=@IdComprobanteProveedor