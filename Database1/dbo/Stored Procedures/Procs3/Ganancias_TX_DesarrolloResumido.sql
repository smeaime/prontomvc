


CREATE Procedure [dbo].[Ganancias_TX_DesarrolloResumido]

@IdProveedor int,
@Fecha datetime,
@ImporteAdicional numeric(18,2)

AS 

Declare @ImporteAcumulado numeric(18,2),@TotalAcumulado numeric(18,2),
	@TotalAcumuladoPagos numeric(18,2),@NoImponible numeric(18,2),
	@SumaFija numeric(18,2),@PorcentajeAdicional numeric(18,2),
	@Desde numeric(18,2),@Excedente numeric(18,2),@Impuesto numeric(18,2),
	@Retenido numeric(18,2),@ImpuestoARetener numeric(18,2),
	@IdTipoRetencionGanancia int,@MinimoARetener numeric(18,2)

SET NOCOUNT ON

/*
Set @NoImponible=(Select P.MinimoNoImponible From Parametros P
			Where P.IdParametro=1)
*/

IF NOT (Select P.IdTipoRetencionGanancia From Proveedores P
	Where P.IdProveedor=@IdProveedor) IS NULL
	Set @IdTipoRetencionGanancia=(Select P.IdTipoRetencionGanancia From Proveedores P
					 Where P.IdProveedor=@IdProveedor)
ELSE
	Set @IdTipoRetencionGanancia=0

IF EXISTS(Select Top 1 g.MinimoNoImponible From Ganancias g
		Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
	Set @NoImponible=(Select Top 1 g.MinimoNoImponible From Ganancias g
				Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
ELSE
	Set @NoImponible=0

IF EXISTS(Select Top 1 g.MinimoARetener From Ganancias g
		Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
	Set @MinimoARetener=(Select Top 1 g.MinimoARetener From Ganancias g
				Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
ELSE
	Set @MinimoARetener=0

IF EXISTS(Select op.IdOrdenPago From OrdenesPago op
			Where op.IdProveedor=@IdProveedor and 
				(op.Anulada is null or op.Anulada<>'SI') and 
				(op.Confirmado is null or op.Confirmado<>'NO') and 
				Year(op.FechaOrdenPago)=Year(@Fecha) and 
				Month(op.FechaOrdenPago)=Month(@Fecha))
	Set @ImporteAcumulado=(Select Sum(Case When dop.ImportePagadoSinImpuestos is not null
						Then dop.ImportePagadoSinImpuestos*op.CotizacionMoneda
						Else dop.Importe*op.CotizacionMoneda End) 
				From DetalleOrdenesPago dop
				Left Outer Join OrdenesPago op On op.IdOrdenPago=dop.IdOrdenPago
				Where op.IdProveedor=@IdProveedor and 
					(op.Anulada is null or op.Anulada<>'SI') and 
					(op.Confirmado is null or op.Confirmado<>'NO') and 
					Year(op.FechaOrdenPago)=Year(@Fecha) and 
					Month(op.FechaOrdenPago)=Month(@Fecha))
ELSE
	Set @ImporteAcumulado=0

Set @TotalAcumuladoPagos=@ImporteAdicional+@ImporteAcumulado
Set @TotalAcumulado=@TotalAcumuladoPagos-@NoImponible
IF @TotalAcumulado<0 Set @TotalAcumulado=0

IF EXISTS(Select Top 1 g.SumaFija From Ganancias g
		Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and 
			 g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
	Set @SumaFija=(Select Top 1 g.SumaFija From Ganancias g
			 Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and 
				g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
ELSE
	Set @SumaFija=0

IF EXISTS(Select Top 1 g.PorcentajeAdicional From Ganancias g
		Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and 
			 g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
	Set @PorcentajeAdicional=(Select Top 1 g.PorcentajeAdicional From Ganancias g
					Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and 
						g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
ELSE
	Set @PorcentajeAdicional=0

IF EXISTS(Select Top 1 g.Desde From Ganancias g
		Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and 
			g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
	Set @Desde=(Select Top 1 g.Desde From Ganancias g
			Where g.IdTipoRetencionGanancia=@IdTipoRetencionGanancia and 
				g.Desde<=@TotalAcumulado and g.Hasta>=@TotalAcumulado)
ELSE
	Set @Desde=0

Set @Excedente=ROUND((@TotalAcumulado-@Desde)*@PorcentajeAdicional/100,2)
Set @Impuesto=@SumaFija+@Excedente

IF EXISTS(Select op.IdOrdenPago From OrdenesPago op
			Where op.IdProveedor=@IdProveedor and 
				(op.Anulada is null or op.Anulada<>'SI') and 
				(op.Confirmado is null or op.Confirmado<>'NO') and 
				Year(op.FechaOrdenPago)=Year(@Fecha) and 
				Month(op.FechaOrdenPago)=Month(@Fecha))
	Set @Retenido=(Select Sum(Case When op.RetencionGanancias is null 
					Then 0 
					Else op.RetencionGanancias*op.CotizacionMoneda End) 
			From OrdenesPago op
			Where op.IdProveedor=@IdProveedor and 
				(op.Anulada is null or op.Anulada<>'SI') and 
				(op.Confirmado is null or op.Confirmado<>'NO') and 
				Year(op.FechaOrdenPago)=Year(@Fecha) and 
				Month(op.FechaOrdenPago)=Month(@Fecha))
ELSE
	Set @Retenido=0

IF @Impuesto<@MinimoARetener
	Set @ImpuestoARetener=0
ELSE
	IF @Impuesto-@Retenido>0 
		Set @ImpuestoARetener=@Impuesto-@Retenido
	ELSE
		Set @ImpuestoARetener=0

SET NOCOUNT OFF

SELECT @ImpuestoARetener as [ARetener]


