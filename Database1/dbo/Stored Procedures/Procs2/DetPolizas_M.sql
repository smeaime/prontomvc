CREATE Procedure [dbo].[DetPolizas_M]

@IdDetallePoliza int,
@IdPoliza int,
@IdBienAsegurado int,
@ImporteAsegurado numeric(18,2),
@IdObraActual int,
@EnUsoPor varchar(30)

AS

UPDATE [DetallePolizas]
SET 
 IdPoliza=@IdPoliza,
 IdBienAsegurado=@IdBienAsegurado,
 ImporteAsegurado=@ImporteAsegurado,
 IdObraActual=@IdObraActual,
 EnUsoPor=@EnUsoPor
WHERE (IdDetallePoliza=@IdDetallePoliza)

RETURN(@IdDetallePoliza)