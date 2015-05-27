



CREATE Procedure [dbo].[Articulos_TX_PorIdTipoParaCombo]
@IdTipo int
AS 
SELECT 
 IdArticulo,
 Descripcion as Titulo
FROM Articulos
WHERE IsNull(IdTipo,0)=@IdTipo and IsNull(Articulos.Activo,'')<>'NO'
ORDER by Descripcion



