
CREATE function [dbo].[fProduccionAvanzadoMaterial](	@IdProduccionOrden int,
						@IdArticulo int, @IdColor int)
returns numeric(18,2)
as
begin

return (select sum(isnull(Cantidad,0)) 
from ProduccionPartes PP
LEFT OUTER JOIN Stock ON Stock.Idstock= PP.Idstock
LEFT OUTER JOIN UnidadesEmpaque EMPAQUES ON Stock.NumeroCaja= EMPAQUES.NumeroUnidad
where (
		IdProduccionOrden = @IdProduccionOrden) 
and (PP.IdArticulo = @IdArticulo)
and (EMPAQUES.IdColor = @IdColor)
		and isnull(pp.anulada,'NO')='NO'
	  )
--return
end
