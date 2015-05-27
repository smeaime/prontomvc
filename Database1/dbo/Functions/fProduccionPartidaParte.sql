

create function fProduccionPartidaParte(	@IdProduccionOrden int,
						@IdArticulo int, @IdColor int )
returns varchar(200)
as
begin

DECLARE @s VARCHAR(200)
SET @s = ''

select @s=@s + isnull(Partida,'') + ' // ' 
from 
(
select distinct PP.Partida
from ProduccionPartes PP
LEFT OUTER JOIN Stock ON Stock.Idstock= PP.Idstock
LEFT OUTER JOIN UnidadesEmpaque EMPAQUES ON Stock.NumeroCaja= EMPAQUES.NumeroUnidad
--LEFT OUTER JOIN Ubicaciones ON Stock.IdUbicacion = Ubicaciones.IdUbicacion
where (IdProduccionOrden = @IdProduccionOrden) 
and (PP.IdArticulo = @IdArticulo)
and (EMPAQUES.IdColor = @IdColor)
and isnull(pp.anulada,'NO')='NO'
) as AUXQUERY


return @s

end

