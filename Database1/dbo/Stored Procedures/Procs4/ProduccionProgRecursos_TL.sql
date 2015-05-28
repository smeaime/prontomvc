CREATE Procedure ProduccionProgRecursos_TL
AS 
Select 
IdProduccionProgRecurso--, Descripcion as [Titulo]
FROM ProduccionProgRecursos 
ORDER by IdProduccionProgRecurso
