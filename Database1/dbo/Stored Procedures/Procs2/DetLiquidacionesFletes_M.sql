CREATE Procedure [dbo].[DetLiquidacionesFletes_M]

@IdDetalleLiquidacionFlete int,
@IdLiquidacionFlete int,
@IdTipoComprobante int,
@IdComprobante int,
@Importe numeric(18,2),
@IdTarifaFlete int,
@ValorUnitarioTarifa numeric(18,2),
@EquivalenciaAUnidadTarifa numeric(18,6),
@Tipo varchar(12)

AS

UPDATE [DetalleLiquidacionesFletes]
SET 
 IdLiquidacionFlete=@IdLiquidacionFlete,
 IdTipoComprobante=@IdTipoComprobante,
 IdComprobante=@IdComprobante,
 Importe=@Importe,
 IdTarifaFlete=@IdTarifaFlete,
 ValorUnitarioTarifa=@ValorUnitarioTarifa,
 EquivalenciaAUnidadTarifa=@EquivalenciaAUnidadTarifa,
 Tipo=@Tipo
WHERE (IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete)

RETURN(@IdDetalleLiquidacionFlete)