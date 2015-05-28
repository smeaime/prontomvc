
CREATE Procedure [dbo].[DetValoresProvincias_BorrarPorIdValor]
@IdValor int  
AS 
DELETE DetalleValoresProvincias
WHERE (IdValor=@IdValor)
