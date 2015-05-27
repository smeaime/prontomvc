CREATE Procedure [dbo].[DetPlazosFijosRubrosContables_M]

@IdDetallePlazoFijoRubrosContables int,
@IdPlazoFijo int,
@IdRubroContable int,
@Tipo varchar(1),
@Importe numeric(18,2)

AS

UPDATE DetallePlazosFijosRubrosContables
SET 
 IdPlazoFijo=@IdPlazoFijo,
 IdRubroContable=@IdRubroContable,
 Tipo=@Tipo,
 Importe=@Importe
WHERE (IdDetallePlazoFijoRubrosContables=@IdDetallePlazoFijoRubrosContables)

RETURN(@IdDetallePlazoFijoRubrosContables)