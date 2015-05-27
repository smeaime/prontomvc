










CREATE Procedure [dbo].[GruposActivosFijos_TT]
AS 
SELECT 
 IdGrupoActivoFijo,
 Descripcion,
 Case 	When Clase='U' Then 'Bienes de Uso'
	When Clase='D' Then 'Bienes diversos'
	When Clase='I' Then 'Bienes intangibles'
	 Else Null
 End as [Clase]
FROM GruposActivosFijos
ORDER by Descripcion











