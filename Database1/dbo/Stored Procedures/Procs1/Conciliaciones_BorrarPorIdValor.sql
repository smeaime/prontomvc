
CREATE Procedure [dbo].[Conciliaciones_BorrarPorIdValor]
@IdValor int
AS 
DELETE DetalleConciliaciones
WHERE (IdValor=@IdValor)
