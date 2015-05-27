
create procedure  ProduccionFicha_TX_DatosPorFicha
@idArticuloProducido int,
@idArticuloMaterial int

as

declare @tolerancia int
declare @proporcion NUMERIC(18,2)

--pero hay que traerlo pára esa fecha!!!!
set @proporcion=(select top 1 Det.cantidad/ProduccionFichas.cantidad
		FROM DetalleProduccionFichas Det
		LEFT OUTER JOIN ProduccionFichas ON 
			ProduccionFichas.IdProduccionFicha=Det.IdProduccionFicha
		where  ProduccionFichas.idArticuloAsociado=@idArticuloProducido and   
			Det.idArticulo=@idArticuloMaterial)

select @proporcion,@tolerancia

