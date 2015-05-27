CREATE  Procedure [dbo].[GastosFletes_M]

@IdGastoFlete int,
@IdFlete int,
@Fecha datetime,
@IdConcepto int,
@Importe numeric(18,2),
@Detalle varchar(50),
@SumaResta int,
@IdDetalleLiquidacionFlete int,
@IdUsuarioDioPorCumplidoLiquidacionFletes int,
@FechaDioPorCumplidoLiquidacionFletes datetime,
@ObservacionDioPorCumplidoLiquidacionFletes ntext,
@Gravado varchar(2),
@Iva numeric(18,2),
@Total numeric(18,2),
@IdObra int,
@IdPresupuestoObrasNodo int

AS

UPDATE GastosFletes
SET
 IdFlete=@IdFlete,
 Fecha=@Fecha,
 IdConcepto=@IdConcepto,
 Importe=@Importe,
 Detalle=@Detalle,
 SumaResta=@SumaResta,
 IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete,
 IdUsuarioDioPorCumplidoLiquidacionFletes=@IdUsuarioDioPorCumplidoLiquidacionFletes,
 FechaDioPorCumplidoLiquidacionFletes=@FechaDioPorCumplidoLiquidacionFletes,
 ObservacionDioPorCumplidoLiquidacionFletes=@ObservacionDioPorCumplidoLiquidacionFletes,
 Gravado=@Gravado,
 Iva=@Iva,
 Total=@Total,
 IdObra=@IdObra,
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo
WHERE (IdGastoFlete=@IdGastoFlete)

RETURN(@IdGastoFlete)