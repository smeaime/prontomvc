
CREATE Procedure ProduccionFichas_TX_MaterialesPorArticuloAsociadoParaCombo
@IdArticuloAsociado INT =0,
@TipoMaterial INT = 0,
@TipoEnString varchar(20) = ''
AS 
SELECT DetalleProduccionFichas.idArticulo, Articulos.Descripcion as Titulo ,Articulos.idTipo
FROM Articulos 
LEFT OUTER JOIN DetalleProduccionFichas ON DetalleProduccionFichas.idArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ProduccionFichas ON ProduccionFichas.IdProduccionFicha=DetalleProduccionFichas.IdProduccionFicha
left outer join tipos on tipos.idtipo=articulos.idTipo
WHERE (ProduccionFichas.IdArticuloAsociado=@IdArticuloAsociado OR @IdArticuloAsociado=0)
and (Articulos.idTipo=@TipoMaterial OR @TipoMaterial=0)
and (tipos.Descripcion=@TipoEnString OR @TipoEnString='')
