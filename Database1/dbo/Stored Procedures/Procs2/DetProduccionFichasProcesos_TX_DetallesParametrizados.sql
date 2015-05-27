

--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
CREATE PROCEDURE DetProduccionFichasProcesos_TX_DetallesParametrizados

@IdProduccionFicha int,
@NivelParametrizacion int

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
--LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
--LEFT OUTER JOIN Obras ON DetSal.IdObra = Obras.IdObra
--LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
--LEFT OUTER JOIN ValesSalida ON DetalleValesSalida.IdValeSalida = ValesSalida.IdValeSalida
--LEFT OUTER JOIN Ubicaciones ON DetSal.IdUbicacion = Ubicaciones.IdUbicacion
--LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=Det.IdProduccionProceso
WHERE (Det.IdProduccionFicha = @IdProduccionFicha)

