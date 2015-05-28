CREATE Procedure [dbo].[DetRubrosContables_M]

@IdDetalleRubroContable int,
@IdRubroContable int,
@IdObra int,
@Porcentaje numeric(6,2)

AS

UPDATE [DetalleRubrosContables]
SET 
 IdRubroContable=@IdRubroContable,
 IdObra=@IdObra,
 Porcentaje=@Porcentaje
WHERE (IdDetalleRubroContable=@IdDetalleRubroContable)

RETURN(@IdDetalleRubroContable)