CREATE Procedure [dbo].[Ganancias_TX_ImpuestoPorIdTipoRetencionGanancia]

@IdProveedor int,
@Fecha datetime,
@IdTipoRetencionGanancia int,
@ImporteAdicional numeric(18,2),
@IdOrdenPago int

AS 

SET NOCOUNT ON

DECLARE @ImporteAcumulado numeric(18,2),@TotalAcumulado numeric(18,2), @TotalAcumuladoPagos numeric(18,2),@NoImponible numeric(18,2),
		@SumaFija numeric(18,2),@PorcentajeAdicional numeric(18,2), @Desde numeric(18,2),@Excedente numeric(18,2),@Impuesto numeric(18,2),
		@MinimoARetener numeric(18,2),@ImpuestoARetener numeric(18,2), @Retenido numeric(18,2), @IdCodigoIva int, 
		@IdTipoCuentaGrupoIVA int, @IdCtaAdicCol1 int, @IdCtaAdicCol2 int, @IdCtaAdicCol3 int, @IdCtaAdicCol4 int, @IdCtaAdicCol5 int, 
		@BienesOServicios varchar(1), @Importe numeric(18,2), @FechaDesde datetime, @FechaHasta datetime, 
		@TopeMonotributoAnual_Bienes numeric(18,2), @TopeMonotributoAnual_Servicios numeric(18,2), @PorcentajeRetencionGananciasMonotributistas numeric(18,2)

SET @IdCodigoIva=IsNull((Select Top 1 IdCodigoIva From Proveedores Where IdProveedor=@IdProveedor),1)
SET @BienesOServicios=IsNull((Select Top 1 BienesOServicios From TiposRetencionGanancia Where IdTipoRetencionGanancia=@IdTipoRetencionGanancia),'B')
SET @TopeMonotributoAnual_Bienes=IsNull((Select Top 1 Valor From Parametros2 Where Campo='TopeMonotributoAnual_Bienes'),0)
SET @TopeMonotributoAnual_Servicios=IsNull((Select Top 1 Valor From Parametros2 Where Campo='TopeMonotributoAnual_Servicios'),0)
SET @PorcentajeRetencionGananciasMonotributistas=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PorcentajeRetencionGananciasMonotributistas'),0)

--Analiza si el proveedor es monotributista y facturo anualmente mas que el tope de las categorias
IF @IdCodigoIva=6
  BEGIN
	SET @FechaHasta=@Fecha
	SET @FechaDesde=Dateadd(yy,-1,@FechaHasta)
	SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where Parametros.IdParametro=1),0)
	SET @IdCtaAdicCol1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
	SET @IdCtaAdicCol2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
	SET @IdCtaAdicCol3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
	SET @IdCtaAdicCol4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
	SET @IdCtaAdicCol5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)

	CREATE TABLE #Auxiliar 
				(
				 IdComprobanteProveedor INTEGER,
				 Importe NUMERIC(18,2)
				)
	INSERT INTO #Auxiliar 
	SELECT
	 dcp.IdComprobanteProveedor,
	 Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
				dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
				dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
				dcp.IdCuenta<>@IdCtaAdicCol5 
		Then dcp.Importe * IsNull(cp.CotizacionMoneda,1) * IsNull(TiposComprobante.Coeficiente,1)
		Else 0
	 End
	FROM DetalleComprobantesProveedores dcp 
	LEFT OUTER JOIN ComprobantesProveedores cp  ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
	LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = cp.IdTipoComprobante
	WHERE cp.IdProveedor=@IdProveedor and (cp.FechaRecepcion Between @FechaDesde And @FechaHasta) and IsNull(cp.BienesOServicios,'B')=@BienesOServicios
	
	SET @Importe=IsNull((Select Sum(Importe) From #Auxiliar),0)

	SET @NoImponible=0
	SET @MinimoARetener=0
	SET @Impuesto=0
	IF @BienesOServicios='B' and @Importe>@TopeMonotributoAnual_Bienes
		--SET @Impuesto=Round((@ImporteAdicional-12000)*0.10,2)
		SET @Impuesto=Round(@ImporteAdicional*@PorcentajeRetencionGananciasMonotributistas/100,2)
	IF @BienesOServicios='S' and @Importe>@TopeMonotributoAnual_Servicios
		--SET @Impuesto=Round((@ImporteAdicional-1200)*0.28,2)
		SET @Impuesto=Round(@ImporteAdicional*@PorcentajeRetencionGananciasMonotributistas/100,2)
	IF @Impuesto<0
		SET @Impuesto=0

	DROP TABLE #Auxiliar
  END
ELSE
  BEGIN
	IF EXISTS(Select Top 1 g.MinimoNoImponible From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
		SET @NoImponible=(Select Top 1 g.MinimoNoImponible From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
	ELSE
		SET @NoImponible=0
	
	IF EXISTS(Select Top 1 g.MinimoARetener From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
		SET @MinimoARetener=(Select Top 1 g.MinimoARetener From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
	ELSE
		SET @MinimoARetener=0
	
	SET @ImporteAcumulado=IsNull((Select Sum((IsNull(dopi.ImportePagado,0)+IsNull(dopi.ImporteTotalFacturasMPagadasSujetasARetencion,0))*IsNull(op.CotizacionMoneda,1))
								  From DetalleOrdenesPagoImpuestos dopi
								  Left Outer Join OrdenesPago op On op.IdOrdenPago=dopi.IdOrdenPago
								  Where op.IdProveedor=@IdProveedor and 
									(op.Anulada is null or op.Anulada<>'SI') and 
									(op.Confirmado is null or op.Confirmado<>'NO') and 
									Year(op.FechaOrdenPago)=Year(@Fecha) and 
									Month(op.FechaOrdenPago)=Month(@Fecha) and 
									op.FechaOrdenPago<=@Fecha and 
									op.IdOrdenPago<>@IdOrdenPago and 
									dopi.IdTipoRetencionGanancia is not null and 
									dopi.IdTipoRetencionGanancia=@IdTipoRetencionGanancia),0)
	
	SET @TotalAcumuladoPagos=@ImporteAdicional+@ImporteAcumulado
	SET @TotalAcumulado=@TotalAcumuladoPagos-@NoImponible
	IF @TotalAcumulado<0 Set @TotalAcumulado=0
	
	IF EXISTS(Select Top 1 g.SumaFija From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
		SET @SumaFija=(Select Top 1 g.SumaFija From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
	ELSE
		SET @SumaFija=0
	
	IF EXISTS(Select Top 1 g.PorcentajeAdicional From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
		SET @PorcentajeAdicional=(Select Top 1 g.PorcentajeAdicional From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
	ELSE
		SET @PorcentajeAdicional=0
	
	IF EXISTS(Select Top 1 g.Desde From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
		SET @Desde=(Select Top 1 g.Desde From Ganancias g Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
	ELSE
		SET @Desde=0
	
	SET @Excedente=ROUND((@TotalAcumulado-@Desde)*@PorcentajeAdicional/100,2)
	SET @Impuesto=@SumaFija+@Excedente
  END
	
SET @Retenido=IsNull((Select Sum(IsNull(dopi.ImpuestoRetenido,0)*IsNull(op.CotizacionMoneda,1))
					  From DetalleOrdenesPagoImpuestos dopi
					  Left Outer Join OrdenesPago op On op.IdOrdenPago=dopi.IdOrdenPago
					  Where op.IdProveedor=@IdProveedor and 
						(op.Anulada is null or op.Anulada<>'SI') and 
						(op.Confirmado is null or op.Confirmado<>'NO') and 
						Year(op.FechaOrdenPago)=Year(@Fecha) and 
						Month(op.FechaOrdenPago)=Month(@Fecha) and 
						op.FechaOrdenPago<=@Fecha and 
						op.IdOrdenPago<>@IdOrdenPago and 
						dopi.IdTipoRetencionGanancia is not null and 
						dopi.IdTipoRetencionGanancia=@IdTipoRetencionGanancia),0)
/*
IF @Impuesto<@MinimoARetener
	SET @ImpuestoARetener=0
ELSE
	IF @Impuesto-@Retenido>0 
		SET @ImpuestoARetener=@Impuesto-@Retenido
	ELSE
		SET @ImpuestoARetener=0
*/
SET @ImpuestoARetener=@Impuesto-@Retenido
IF @ImpuestoARetener<0 or @ImpuestoARetener<@MinimoARetener
	SET @ImpuestoARetener=0

SET NOCOUNT OFF

SELECT 
 @ImpuestoARetener as [ImpuestoARetener],
 @ImporteAcumulado as [ImporteAcumulado],
 @Retenido as [Retenido]
