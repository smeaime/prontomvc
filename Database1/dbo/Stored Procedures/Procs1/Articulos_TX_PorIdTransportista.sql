
CREATE Procedure [dbo].[Articulos_TX_PorIdTransportista]
@IdTransportista int
AS 
SELECT IdArticulo, Descripcion as Titulo
FROM Articulos
WHERE IsNull(Articulos.Activo,'')<>'NO' and IsNull(IdTransportista,0)=@IdTransportista
ORDER by Descripcion
