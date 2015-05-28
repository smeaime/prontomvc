










CREATE Procedure [dbo].[GruposActivosFijos_TX_TT]
@IdGrupoActivoFijo int
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
WHERE (IdGrupoActivoFijo=@IdGrupoActivoFijo)
ORDER by Descripcion











