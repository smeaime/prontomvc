
--exec dbo.DetProduccionFichaProcesos_TXPrimero

--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE PROCEDURE DetProduccionFichasProcesos_TX_Uni

@IdArticulo int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='10011133'
Set @vector_T='100D3300'

SELECT 
Det.IdDetalleProduccionFichaProceso,
 Det.IdProduccionProceso,
 Det.IdProduccionFicha,
 '    ' as [*],
 ProduccionProcesos.Descripcion,
 Det.Horas,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionFichaProcesos Det
--LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Det.IdUnidad
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=Det.IdProduccionProceso
--WHERE (Det.IdArticulo = @IdArticulo)
--ORDER BY Unidades.Abreviatura

