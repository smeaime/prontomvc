
create procedure  ProduccionFichas_TX_ProporcionEntreProducidoyMaterial
@idArticuloProducido int,
@idArticuloMaterial int
as
select Det.cantidad/ProduccionFichas.cantidad
	FROM DetalleProduccionFichas Det
	LEFT OUTER JOIN ProduccionFichas ON ProduccionFichas.IdProduccionFicha=Det.IdProduccionFicha
	where  ProduccionFichas.idArticuloAsociado=@idArticuloProducido and   
		Det.idArticulo=@idArticuloMaterial
