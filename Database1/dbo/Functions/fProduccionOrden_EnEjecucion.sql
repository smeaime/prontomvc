

create function fProduccionOrden_EnEjecucion (@IdProduccionOrden INT,@idproduccionproceso INT)

returns int
as
begin

return (
	select count(IdProduccionOrden) 
	FROM ProduccionPartes
	WHERE (IdProduccionOrden=@IdProduccionOrden) AND (idproduccionproceso=@idproduccionproceso)
	)
end
--ProduccionPartes_tx_PorIdOrden está haciendo lo mismo

