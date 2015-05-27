

CREATE Procedure [dbo].[Traducciones_TX_TT]
@IdTraduccion int
AS 
Select 
 IdTraduccion,
 Descripcion_esp as [Descripción español],
 Descripcion_ing as [Descripción ingles],
 Descripcion_por as [Descripción portugues],
 FechaAlta as [Fec.alta],
 FechaUltimaModificacion as [Fec.Ult.Mod.]
FROM Traducciones
WHERE IdTraduccion=@IdTraduccion


