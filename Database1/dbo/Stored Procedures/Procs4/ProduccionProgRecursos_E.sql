create Procedure ProduccionProgRecursos_E
@IdProduccionProgRecurso int
AS 
DELETE [ProduccionProgRecursos]
WHERE (IdProduccionProgRecurso=@IdProduccionProgRecurso)


