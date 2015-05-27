

create function fProduccionAvanzado(	@IdProduccionOrden int,
					@IdProduccionProceso int)
returns numeric(18,2)
as
begin

return (

--select sum(Horas) 
select sum(datediff(mi,FechaInicio,FechaFinal)/60.0)
from ProduccionPartes
where (IdProduccionOrden = @IdProduccionOrden) and
 (IdProduccionProceso = @IdProduccionProceso))

--return
end

