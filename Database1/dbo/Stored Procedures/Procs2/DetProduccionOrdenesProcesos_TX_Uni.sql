
--exec dbo.DetProduccionOrdenProcesos_TXPrimero

--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE PROCEDURE DetProduccionOrdenesProcesos_TX_Uni

@IdArticulo int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='11110011111133'
Set @vector_T='9D110011119E00'

SELECT 
Det.IdDetalleProduccionOrdenProceso,
'    ' as [*],
FechaInicio as [Inicio],
FechaFinal as [Final],
 Det.IdProduccionProceso,
 Det.IdProduccionOrden,
 ProduccionProcesos.Descripcion,
 Det.Horas,
HorasReales as [Avance],
 ' ' as [%],
IdMaquina,
 Articulos.descripcion as Maquina,

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionOrdenProcesos Det
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=Det.IdProduccionProceso
LEFT OUTER JOIN Articulos  ON Articulos.IdArticulo=Det.IdMaquina
--LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Det.IdUnidad
--LEFT OUTER JOIN Colores ON Det.IdColor = Colores.IdColor
--WHERE (Det.IdArticulo = @IdArticulo)
--ORDER BY Unidades.Abreviatura

