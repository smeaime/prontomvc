


CREATE Procedure [dbo].[Ganancias_TX_RetenidoMes]

@IdProveedor int,
@Fecha datetime,
@IdTipoRetencionGanancia int

AS 

Declare @Retenido numeric(18,2)

Set @Retenido=ISNULL((Select Sum(dopi.ImpuestoRetenido*op.CotizacionMoneda)
			 From DetalleOrdenesPagoImpuestos dopi
			 Left Outer Join OrdenesPago op On op.IdOrdenPago=dopi.IdOrdenPago
			 Where op.IdProveedor=@IdProveedor and 
				(op.Anulada is null or op.Anulada<>'SI') and 
				(op.Confirmado is null or op.Confirmado<>'NO') and 
				Year(op.FechaOrdenPago)=Year(@Fecha) and 
				Month(op.FechaOrdenPago)=Month(@Fecha) and 
				op.FechaOrdenPago<=@Fecha and 
				dopi.IdTipoRetencionGanancia is not null and 
				dopi.IdTipoRetencionGanancia=@IdTipoRetencionGanancia
			)
		,0)

Select @Retenido


