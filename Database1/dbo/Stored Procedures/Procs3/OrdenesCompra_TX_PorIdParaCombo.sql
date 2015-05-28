


/*
select datediff(mi,FechaInicio,FechaFinal)/60.0
from ProduccionPartes
*/


--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--exec dbo.OrdenesCompra_TX_PorIdParaCombo
CREATE Procedure OrdenesCompra_TX_PorIdParaCombo
--@IdTipo int
AS 
SELECT 
 IdOrdenCompra,
 NumeroOrdenCompra as Titulo
FROM OrdenesCompra
--WHERE IsNull(IdTipo,0)=@IdTipo and IsNull(Articulos.Activo,'')<>'NO'
ORDER by IdOrdenCompra



