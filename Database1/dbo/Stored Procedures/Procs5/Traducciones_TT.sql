
CREATE Procedure [dbo].[Traducciones_TT]

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111133'
SET @vector_T='0EEE4400'

SELECT
 IdTraduccion,
 Descripcion_esp as [Descripción español],
 Descripcion_ing as [Descripción ingles],
 Descripcion_por as [Descripción portugues],
 FechaAlta as [Fec.alta],
 FechaUltimaModificacion as [Fec.Ult.Mod.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Traducciones
ORDER By Descripcion_esp
