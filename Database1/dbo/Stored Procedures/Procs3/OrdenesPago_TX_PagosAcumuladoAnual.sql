CREATE Procedure [dbo].[OrdenesPago_TX_PagosAcumuladoAnual]

@IdProveedor int,
@Fecha datetime,
@IdOrdenPagoActual int,
@IdImpuestoDirecto int = Null

AS

SET @IdImpuestoDirecto=IsNull(@IdImpuestoDirecto,IsNull((Select Top 1 IdImpuestoDirectoSUSS From Proveedores Where IdProveedor=@IdProveedor),0))

DECLARE @ImporteAcumulado numeric(18,2), @RetenidoAño numeric(18,2), @NumeroOrdenPago int, @SUSSFechaInicioVigencia datetime

SET @NumeroOrdenPago=IsNull((Select Top 1 NumeroOrdenPago From OrdenesPago Where IdOrdenPago=@IdOrdenPagoActual),0)
SET @SUSSFechaInicioVigencia=IsNull((Select Top 1 SUSSFechaInicioVigencia From Proveedores Where IdProveedor=@IdProveedor),Convert(datetime,'1/1/1900',103))

SET @ImporteAcumulado=IsNull((Select Sum(IsNull(dop.ImportePagadoSinImpuestos,0)*op.CotizacionMoneda)
								From DetalleOrdenesPago dop
								Left Outer Join OrdenesPago op On op.IdOrdenPago=dop.IdOrdenPago
								Where op.IdProveedor=@IdProveedor and IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and 
										Year(op.FechaOrdenPago)=Year(@Fecha) and op.FechaOrdenPago>=@SUSSFechaInicioVigencia and op.IdOrdenPago<>@IdOrdenPagoActual and 
										(op.FechaOrdenPago<@Fecha or (op.FechaOrdenPago=@Fecha and (@IdOrdenPagoActual=-1 or op.NumeroOrdenPago<@NumeroOrdenPago)))),0)

SET @RetenidoAño=IsNull((Select Sum(IsNull(op.RetencionSUSS,0)*op.CotizacionMoneda)
						 From OrdenesPago op
						 Left Outer Join Proveedores On Proveedores.IdProveedor=op.IdProveedor
						 Where op.IdProveedor=@IdProveedor and IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and 
								Year(op.FechaOrdenPago)=Year(@Fecha) and op.FechaOrdenPago>=@SUSSFechaInicioVigencia and op.IdOrdenPago<>@IdOrdenPagoActual and 
								(op.FechaOrdenPago<@Fecha or (op.FechaOrdenPago=@Fecha and (@IdOrdenPagoActual=-1 or op.NumeroOrdenPago<@NumeroOrdenPago))) and 
								IsNull(op.IdImpuestoDirecto,IsNull(Proveedores.IdImpuestoDirectoSUSS,0))=@IdImpuestoDirecto),0)

SELECT @ImporteAcumulado as [ImporteAcumulado], @RetenidoAño as [RetenidoAño]