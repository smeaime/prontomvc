





























CREATE PROCEDURE [dbo].[DetPresupuestosHHObras_TX_PorEquipoObra]
@IdObra int,
@IdEquipo int
as
SELECT
IdObra,
IdEquipo,
SUM(HorasPresupuestadas) as [HorasP],
SUM(HorasTerceros) as [HorasT]
FROM DetallePresupuestosHHObras
WHERE IdObra=@IdObra and IdEquipo=@IdEquipo
GROUP BY IdObra,IdEquipo






























