



CREATE Procedure [dbo].[Conciliaciones_QuitarMarcaAprobacion]
@IdConciliacion int
AS 
UPDATE Conciliaciones
SET IdAprobo=Null
WHERE (IdConciliacion=@IdConciliacion)



