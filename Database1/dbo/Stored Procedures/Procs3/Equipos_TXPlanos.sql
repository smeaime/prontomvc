





























CREATE PROCEDURE [dbo].[Equipos_TXPlanos]
@IdEquipo int
as
SELECT
Planos.IdPlano,
Planos.NumeroPlano + " " + Planos.Descripcion as Titulo
FROM DetalleEquipos DetEqu
LEFT OUTER JOIN Planos ON DetEqu.IdPlano = Planos.IdPlano
WHERE (DetEqu.IdEquipo = @IdEquipo)






























