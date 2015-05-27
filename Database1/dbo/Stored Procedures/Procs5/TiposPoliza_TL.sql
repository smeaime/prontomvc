CREATE Procedure [dbo].[TiposPoliza_TL]

AS 

SELECT 
 IdTipoPoliza,
 Descripcion as Titulo
FROM TiposPoliza
ORDER by Descripcion