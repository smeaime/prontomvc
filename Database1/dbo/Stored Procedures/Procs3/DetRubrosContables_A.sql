CREATE Procedure [dbo].[DetRubrosContables_A]

@IdDetalleRubroContable int output,
@IdRubroContable int,
@IdObra int,
@Porcentaje numeric(6,2)

AS 

INSERT INTO [DetalleRubrosContables]
(
 IdRubroContable,
 IdObra,
 Porcentaje
)
VALUES
(
 @IdRubroContable,
 @IdObra,
 @Porcentaje
)

SELECT @IdDetalleRubroContable=@@identity

RETURN(@IdDetalleRubroContable)