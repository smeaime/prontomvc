

--exec dbo.DetProduccionOrdenProcesos_TXPrimero

--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE PROCEDURE [dbo].[DetProduccionOrdenProcesos_TX_Uni]

@IdArticulo int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='001133'
Set @vector_T='001000'

SELECT
 Det.IdDetalleProduccionOrdenProceso,
-- Det.IdArticulo,
-- Unidades.Abreviatura as [Un.],
-- Det.Equivalencia as [Equiv.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionOrdenProcesos Det
--LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Det.IdUnidad
--WHERE (Det.IdArticulo = @IdArticulo)
--ORDER BY Unidades.Abreviatura


