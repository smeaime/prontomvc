CREATE Procedure [dbo].[DetPolizas_A]

@IdDetallePoliza int output,
@IdPoliza int,
@IdBienAsegurado int,
@ImporteAsegurado numeric(18,2),
@IdObraActual int,
@EnUsoPor varchar(30)

AS 

INSERT INTO [DetallePolizas]
(
 IdPoliza,
 IdBienAsegurado,
 ImporteAsegurado,
 IdObraActual,
 EnUsoPor
)
VALUES
(
 @IdPoliza,
 @IdBienAsegurado,
 @ImporteAsegurado,
 @IdObraActual,
 @EnUsoPor
)

SELECT @IdDetallePoliza=@@identity

RETURN(@IdDetallePoliza)