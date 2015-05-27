CREATE PROCEDURE [dbo].[OrdenesPago_TX_AcumuladoParaRetenciones]

@IdOrdenPago int,
@IdProveedor int,
@FechaInicial datetime,
@FechaFinal datetime

AS

DECLARE @PagosAcumulados Numeric(18,2)

SET @PagosAcumulados = Isnull((Select Sum(IsNull(dop.ImportePagadoSinImpuestos,dop.Importe))
				 From DetalleOrdenesPago dop
				 Left Outer Join OrdenesPago op On op.IdOrdenPago=dop.IdOrdenPago
				 Left Outer Join CuentasCorrientesAcreedores Cta ON Cta.IdCtaCte=dop.IdImputacion
				 Left Outer Join TiposComprobante tc ON tc.IdTipoComprobante=Cta.IdTipoComp
				 Left Outer Join ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Cta.IdComprobante and cp.IdTipoComprobante=Cta.IdTipoComp
				 Where dop.IdOrdenPago<>@IdOrdenPago and IsNull(op.IdProveedor,0)=@IdProveedor and IsNull(op.Anulada,'')<>'SI' and 
					op.FechaOrdenPago>=@FechaInicial and op.FechaOrdenPago<=@FechaFinal),0)

SELECT @PagosAcumulados as [PagosAcumulados]