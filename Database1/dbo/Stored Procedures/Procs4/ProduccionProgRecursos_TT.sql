CREATE Procedure ProduccionProgRecursos_TT
--@IdArticulo int
AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='0111033'
Set @vector_T='0555000'
SELECT 
 ProduccionProgRecursos.idProduccionProgRecurso,
Fecha as Creado,
FechaInicio as Inicio,
FechaFinal as Final,
'Administrador' as Usuario,

-- ProduccionAreas.Descripcion as Area,
-- ProduccionProgRecursos.Codigo,
-- ProduccionProgRecursos.Descripcion,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X

FROM ProduccionProgRecursos
order by idProduccionProgRecurso


--LEFT OUTER JOIN ProduccionAreas ON  ProduccionAreas.IdProduccionArea = ProduccionProgRecursos.IdProduccionArea
