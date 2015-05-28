
create Procedure ProduccionProgRecursos_T
@IdProduccionProgRecurso int
AS 
SELECT * 
FROM ProduccionProgRecursos
WHERE (IdProduccionProgRecurso=@IdProduccionProgRecurso)
