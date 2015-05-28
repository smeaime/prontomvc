CREATE Procedure [dbo].[GastosFletes_A]

@IdGastoFlete int output,
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

INSERT INTO [GastosFletes]
(
 IdFlete,
 Fecha,
 IdConcepto,
 Importe,
 Detalle,
 SumaResta,
 IdDetalleLiquidacionFlete,
 IdUsuarioDioPorCumplidoLiquidacionFletes,
 FechaDioPorCumplidoLiquidacionFletes,
 ObservacionDioPorCumplidoLiquidacionFletes,
 Gravado,
 Iva,
 Total,
 IdObra,
 IdPresupuestoObrasNodo
)
VALUES
(
 @IdFlete,
 @Fecha,
 @IdConcepto,
 @Importe,
 @Detalle,
 @SumaResta,
 @IdDetalleLiquidacionFlete,
 @IdUsuarioDioPorCumplidoLiquidacionFletes,
 @FechaDioPorCumplidoLiquidacionFletes,
 @ObservacionDioPorCumplidoLiquidacionFletes,
 @Gravado,
 @Iva,
 @Total,
 @IdObra,
 @IdPresupuestoObrasNodo
)

SELECT @IdGastoFlete=@@identity

RETURN(@IdGastoFlete)