CREATE Procedure [dbo].[OrdenesPago_LiberarGastosPorAnulacionOP]

@IdOrdenPago int

AS

UPDATE ComprobantesProveedores
SET IdOrdenPago=Null
WHERE IdOrdenPago=@IdOrdenPago

UPDATE ComprobantesProveedores
SET IdOrdenPagoRetencionIva=Null
WHERE IdOrdenPagoRetencionIva=@IdOrdenPago