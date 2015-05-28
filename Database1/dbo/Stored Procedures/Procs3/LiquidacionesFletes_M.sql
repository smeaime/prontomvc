
CREATE Procedure [dbo].[LiquidacionesFletes_M]

@IdLiquidacionFlete int,
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

UPDATE LiquidacionesFletes
SET
 IdTransportista=@IdTransportista,
 NumeroLiquidacion=@NumeroLiquidacion,
 FechaLiquidacion=@FechaLiquidacion,
 Anulada=@Anulada,
 FechaAnulacion=@FechaAnulacion,
 IdUsuarioAnulo=@IdUsuarioAnulo,
 MotivoAnulacion=@MotivoAnulacion,
 IdUsuarioIngreso=@IdUsuarioIngreso,
 FechaIngreso=@FechaIngreso,
 IdUsuarioModifico=@IdUsuarioModifico,
 FechaModifico=@FechaModifico,
 Observaciones=@Observaciones,
 IdCodigoIva=@IdCodigoIva,
 PorcentajeIva=@PorcentajeIva,
 SubtotalNoGravado=@SubtotalNoGravado,
 SubtotalGravado=@SubtotalGravado,
 Iva=@Iva,
 Total=@Total
WHERE (IdLiquidacionFlete=@IdLiquidacionFlete)

RETURN(@IdLiquidacionFlete)
