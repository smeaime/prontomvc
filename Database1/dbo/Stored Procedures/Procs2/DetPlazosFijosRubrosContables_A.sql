CREATE Procedure [dbo].[DetPlazosFijosRubrosContables_A]

@IdDetallePlazoFijoRubrosContables int  output,
@IdPlazoFijo int,
@IdRubroContable int,
@Tipo varchar(1),
@Importe numeric(18,2)

AS

INSERT INTO [DetallePlazosFijosRubrosContables]
(
 IdPlazoFijo,
 IdRubroContable,
 Tipo,
 Importe
)
VALUES
(
 @IdPlazoFijo,
 @IdRubroContable,
 @Tipo,
 @Importe
)

SELECT @IdDetallePlazoFijoRubrosContables=@@identity

RETURN(@IdDetallePlazoFijoRubrosContables)