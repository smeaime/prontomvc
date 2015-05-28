CREATE Procedure Articulos_TX_ProduciblesParaCombo
@IdTipo int=0
AS 
SELECT  
 IdArticulo,
 articulos.Descripcion as Titulo
FROM Articulos
left outer join tipos on tipos.idtipo=articulos.idtipo
left outer join produccionfichas on  produccionfichas.idArticuloAsociado=articulos.idarticulo
WHERE tipos.Descripcion='Semielaborado' 
	or tipos.Descripcion='Terminado' 
	or not produccionfichas.idarticuloasociado is null
ORDER by articulos.Descripcion
