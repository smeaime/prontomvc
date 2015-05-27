CREATE Procedure [dbo].[DetAutorizacionesFirmantes_A]

@IdDetalleAutorizacionFirmantes int  output,
@IdDetalleAutorizacion int,
@IdAutorizacion int,
@IdFirmante int,
@IdRubro int,
@IdSubrubro int,
@ParaTaller varchar(2),
@ImporteDesde numeric(18,2),
@ImporteHasta numeric(18,2)

AS 

INSERT INTO [DetalleAutorizacionesFirmantes]
(
 IdDetalleAutorizacion,
 IdAutorizacion,
 IdFirmante,
 IdRubro,
 IdSubrubro,
 ParaTaller,
 ImporteDesde,
 ImporteHasta
)
VALUES 
(
 @IdDetalleAutorizacion,
 @IdAutorizacion,
 @IdFirmante,
 @IdRubro,
 @IdSubrubro,
 @ParaTaller,
 @ImporteDesde,
 @ImporteHasta
)

SELECT @IdDetalleAutorizacionFirmantes=@@identity

RETURN(@IdDetalleAutorizacionFirmantes)