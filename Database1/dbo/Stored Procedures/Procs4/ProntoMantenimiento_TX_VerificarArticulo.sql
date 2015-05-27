
CREATE Procedure [dbo].[ProntoMantenimiento_TX_VerificarArticulo]

@IdArticulo int

AS 

SELECT TOP 1 IsNull(TiposRosca.IdArticuloPRONTO_MANTENIMIENTO,0) as [IdArticulo]
FROM Articulos
LEFT OUTER JOIN TiposRosca ON Articulos.IdTipoRosca=TiposRosca.IdTipoRosca
WHERE Articulos.IdArticulo=@IdArticulo
