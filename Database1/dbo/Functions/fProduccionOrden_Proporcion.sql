

create function fProduccionOrden_Proporcion(@idArticuloProducido int,@idArticuloMaterial int)
returns numeric(18,2)
as
begin

return (select top 1 Det.cantidad/ProduccionFichas.cantidad
		FROM DetalleProduccionFichas Det
		LEFT OUTER JOIN ProduccionFichas ON ProduccionFichas.IdProduccionFicha=Det.IdProduccionFicha
		where  ProduccionFichas.idArticuloAsociado=@idArticuloProducido and   
			Det.idArticulo=@idArticuloMaterial)

end

