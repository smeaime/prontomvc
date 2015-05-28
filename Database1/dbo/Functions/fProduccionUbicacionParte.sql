

create function fProduccionUbicacionParte(	@IdProduccionOrden int,
						@IdArticulo int)
returns varchar(200)
as
begin

DECLARE @s VARCHAR(200)
SET @s = ''

select @s=@s + isnull(Descripcion,'') + ' // ' 
from 
(
select distinct Ubicaciones.Descripcion
from ProduccionPartes PP
LEFT OUTER JOIN Stock ON Stock.idstock = PP.idstock
LEFT OUTER JOIN Ubicaciones ON PP.IdUbicacion = Ubicaciones.IdUbicacion
where (IdProduccionOrden = @IdProduccionOrden) and
 (PP.IdArticulo = @IdArticulo)
and isnull(pp.anulada,'NO')='NO'

) as AUXQUERY


return @s


end

