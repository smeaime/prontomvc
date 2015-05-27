CREATE Procedure [dbo].[IBCondiciones_TX_AcumuladosPorIdProveedorIdIBCondicion]

@IdProveedor int,
@Fecha datetime,
@IdIBCondicion int,
@IdOrdenPago int

AS 

SET NOCOUNT ON

Declare @ImporteAcumulado Numeric(18,2),@Retenido Numeric(18,2)

Set @ImporteAcumulado=ISNULL((Select Sum(dopi.ImportePagado*op.CotizacionMoneda)
				 From DetalleOrdenesPagoImpuestos dopi
				 Left Outer Join OrdenesPago op On op.IdOrdenPago=dopi.IdOrdenPago
				 Where op.IdProveedor=@IdProveedor and 
					(op.Anulada is null or op.Anulada<>'SI') and 
					Year(op.FechaOrdenPago)=Year(@Fecha) and 
					Month(op.FechaOrdenPago)=Month(@Fecha) and 
					op.FechaOrdenPago<=@Fecha and 
					op.IdOrdenPago<>@IdOrdenPago and 
					dopi.IdIBCondicion is not null and 
					dopi.IdIBCondicion=@IdIBCondicion
				)
			,0)

Set @Retenido=ISNULL((Select Sum(dopi.ImpuestoRetenido*op.CotizacionMoneda)
			 From DetalleOrdenesPagoImpuestos dopi
			 Left Outer Join OrdenesPago op On op.IdOrdenPago=dopi.IdOrdenPago
			 Where op.IdProveedor=@IdProveedor and 
				(op.Anulada is null or op.Anulada<>'SI') and 
				Year(op.FechaOrdenPago)=Year(@Fecha) and 
				Month(op.FechaOrdenPago)=Month(@Fecha) and 
				op.FechaOrdenPago<=@Fecha and 
				op.IdOrdenPago<>@IdOrdenPago and 
				dopi.IdIBCondicion is not null and 
				dopi.IdIBCondicion=@IdIBCondicion
			)
		,0)

SET NOCOUNT OFF

SELECT 
 @ImporteAcumulado as [ImporteAcumulado],
 @Retenido as [Retenido]