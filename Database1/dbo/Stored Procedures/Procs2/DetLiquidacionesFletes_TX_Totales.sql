CREATE PROCEDURE [dbo].[DetLiquidacionesFletes_TX_Totales]

@IdLiquidacionFlete int

AS

SET NOCOUNT ON

DECLARE @Recepciones numeric(18,2), @Salidas numeric(18,2), @Fletes numeric(18,2), @OtrosSumaGravado numeric(18,2), @OtrosSumaNoGravado numeric(18,2), 
	@OtrosRestaGravado numeric(18,2), @OtrosRestaNoGravado numeric(18,2), @Consumos numeric(18,2), @PorcentajeIVA numeric(6,2), @IdCodigoIva int, 
	@Subtotal numeric(18,2), @IVA numeric(18,2), @Total numeric(18,2)

SET @PorcentajeIVA=IsNull((Select Top 1 IsNull(Iva1,0) From Parametros Where IdPArametro=1),0)
SET @IdCodigoIva=IsNull((Select Top 1 Transportistas.IdCodigoIva From Transportistas 
			 Left Outer Join LiquidacionesFletes On LiquidacionesFletes.IdTransportista = Transportistas.IdTransportista
			 Where LiquidacionesFletes.IdLiquidacionFlete=@IdLiquidacionFlete),0)

SET @Recepciones=IsNull((Select Sum(IsNull(dlf.Importe,0)) From DetalleLiquidacionesFletes dlf 
			 Left Outer Join DetalleRecepciones dr On dr.IdDetalleRecepcion = dlf.IdComprobante and dlf.IdTipoComprobante=60
			 Left Outer Join Recepciones On Recepciones.IdRecepcion = dr.IdRecepcion
			 Where dlf.IdLiquidacionFlete = @IdLiquidacionFlete and Recepciones.IdFlete is not null),0)

SET @Salidas=IsNull((Select Sum(IsNull(dlf.Importe,0)) From DetalleLiquidacionesFletes dlf 
			Left Outer Join DetalleSalidasMateriales dsm On dsm.IdDetalleSalidaMateriales = dlf.IdComprobante and dlf.IdTipoComprobante=50
			Left Outer Join SalidasMateriales On SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
			Where dlf.IdLiquidacionFlete = @IdLiquidacionFlete and SalidasMateriales.IdFlete is not null),0)

SET @Fletes=0

SET @OtrosSumaGravado=IsNull((Select Sum(IsNull(dlf.Importe,0)) From DetalleLiquidacionesFletes dlf 
				Left Outer Join GastosFletes On GastosFletes.IdGastoFlete = dlf.IdComprobante and dlf.IdTipoComprobante=120
				Where dlf.IdLiquidacionFlete = @IdLiquidacionFlete and GastosFletes.IdFlete is not null and IsNull(GastosFletes.SumaResta,1)=1 and IsNull(GastosFletes.Gravado,'SI')='SI'),0)

SET @OtrosSumaNoGravado=IsNull((Select Sum(IsNull(dlf.Importe,0)) From DetalleLiquidacionesFletes dlf 
				Left Outer Join GastosFletes On GastosFletes.IdGastoFlete = dlf.IdComprobante and dlf.IdTipoComprobante=120
				Where dlf.IdLiquidacionFlete = @IdLiquidacionFlete and GastosFletes.IdFlete is not null and IsNull(GastosFletes.SumaResta,1)=1 and IsNull(GastosFletes.Gravado,'SI')<>'SI'),0)

SET @OtrosRestaGravado=IsNull((Select Sum(IsNull(dlf.Importe,0)) From DetalleLiquidacionesFletes dlf 
				Left Outer Join GastosFletes On GastosFletes.IdGastoFlete = dlf.IdComprobante and dlf.IdTipoComprobante=120
				Where dlf.IdLiquidacionFlete = @IdLiquidacionFlete and GastosFletes.IdFlete is not null and IsNull(GastosFletes.SumaResta,1)=-1 and IsNull(GastosFletes.Gravado,'SI')='SI'),0)

SET @OtrosRestaNoGravado=IsNull((Select Sum(IsNull(dlf.Importe,0)) From DetalleLiquidacionesFletes dlf 
				Left Outer Join GastosFletes On GastosFletes.IdGastoFlete = dlf.IdComprobante and dlf.IdTipoComprobante=120
				Where dlf.IdLiquidacionFlete = @IdLiquidacionFlete and GastosFletes.IdFlete is not null and IsNull(GastosFletes.SumaResta,1)=-1 and IsNull(GastosFletes.Gravado,'SI')<>'SI'),0)

SET @Consumos=IsNull((Select Sum(IsNull(dlf.Importe,0)) From DetalleLiquidacionesFletes dlf 
			Left Outer Join DetalleSalidasMateriales dsm On dsm.IdDetalleSalidaMateriales = dlf.IdComprobante and dlf.IdTipoComprobante=50
			Left Outer Join SalidasMateriales On SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
			Where dlf.IdLiquidacionFlete = @IdLiquidacionFlete and dsm.IdFlete is not null),0)

IF @IdCodigoIva<=1
    BEGIN
	SET @Subtotal=@Recepciones+@Salidas+@Fletes+@OtrosSumaGravado+@OtrosRestaGravado+@Consumos
	SET @IVA=Round(@Subtotal*(@PorcentajeIVA/100),2)
	SET @Subtotal=@Subtotal+@OtrosSumaNoGravado+@OtrosRestaNoGravado
    END
ELSE
    BEGIN
/*
	SET @Recepciones=Round(@Recepciones*(1+(@PorcentajeIVA/100)),2)
	SET @Salidas=Round(@Salidas*(1+(@PorcentajeIVA/100)),2)
	SET @Fletes=Round(@Fletes*(1+(@PorcentajeIVA/100)),2)
	SET @OtrosSuma=Round(@OtrosSuma*(1+(@PorcentajeIVA/100)),2)
	SET @OtrosResta=Round(@OtrosResta*(1+(@PorcentajeIVA/100)),2)
	SET @Consumos=Round(@Consumos*(1+(@PorcentajeIVA/100)),2)
*/
	SET @Subtotal=@Recepciones+@Salidas+@Fletes+@OtrosSumaGravado+@OtrosSumaNoGravado+@OtrosRestaGravado+@OtrosRestaNoGravado+@Consumos
	SET @IVA=0
    END
SET @Total=@Subtotal+@IVA

SET NOCOUNT OFF

SELECT @Recepciones as [Recepciones], @Salidas as [Salidas], @Fletes as [Fletes], @OtrosSumaGravado+@OtrosSumaNoGravado as [OtrosSuma], @OtrosRestaGravado+@OtrosRestaNoGravado as [OtrosResta], 
	@Consumos as [Consumos], @Subtotal as [Subtotal], @IVA as [IVA], @Total as [Total]