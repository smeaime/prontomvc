
CREATE Procedure [dbo].[LiquidacionesFletes_A]

@IdLiquidacionFlete int output,
@IdTransportista int,
@NumeroLiquidacion int,
@FechaLiquidacion datetime,
@Anulada varchar(2),
@FechaAnulacion datetime,
@IdUsuarioAnulo int,
@MotivoAnulacion ntext,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,
@Observaciones ntext,
@IdCodigoIva int,
@PorcentajeIva numeric(6,2),
@SubtotalNoGravado numeric(18,2),
@SubtotalGravado numeric(18,2),
@Iva numeric(18,2),
@Total numeric(18,2)

AS 

INSERT INTO LiquidacionesFletes
(
 IdTransportista,
 NumeroLiquidacion,
 FechaLiquidacion,
 Anulada,
 FechaAnulacion,
 IdUsuarioAnulo,
 MotivoAnulacion,
 IdUsuarioIngreso,
 FechaIngreso,
 IdUsuarioModifico,
 FechaModifico,
 Observaciones,
 IdCodigoIva,
 PorcentajeIva,
 SubtotalNoGravado,
 SubtotalGravado,
 Iva,
 Total
)
VALUES 
(
 @IdTransportista,
 @NumeroLiquidacion,
 @FechaLiquidacion,
 @Anulada,
 @FechaAnulacion,
 @IdUsuarioAnulo,
 @MotivoAnulacion,
 @IdUsuarioIngreso,
 @FechaIngreso,
 @IdUsuarioModifico,
 @FechaModifico,
 @Observaciones,
 @IdCodigoIva,
 @PorcentajeIva,
 @SubtotalNoGravado,
 @SubtotalGravado,
 @Iva,
 @Total
)

SELECT @IdLiquidacionFlete=@@identity

RETURN(@IdLiquidacionFlete)
