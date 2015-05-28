CREATE Procedure [dbo].[DetAutorizacionesFirmantes_M]

@IdDetalleAutorizacionFirmantes int,
@IdDetalleAutorizacion int,
@IdAutorizacion int,
@IdFirmante int,
@IdRubro int,
@IdSubrubro int,
@ParaTaller varchar(2),
@ImporteDesde numeric(18,2),
@ImporteHasta numeric(18,2)

AS 

UPDATE [DetalleAutorizacionesFirmantes]
SET 
 IdDetalleAutorizacion=@IdDetalleAutorizacion,
 IdAutorizacion=@IdAutorizacion,
 IdFirmante=@IdFirmante,
 IdRubro=@IdRubro,
 IdSubrubro=@IdSubrubro,
 ParaTaller=@ParaTaller,
 ImporteDesde=@ImporteDesde,
 ImporteHasta=@ImporteHasta
WHERE (IdDetalleAutorizacionFirmantes=@IdDetalleAutorizacionFirmantes)

RETURN(@IdDetalleAutorizacionFirmantes)