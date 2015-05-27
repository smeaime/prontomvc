

--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE PROCEDURE DetProduccionFichas_TXPrimero

@NivelParametrizacion int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
---------------123456789012345678901234567890	
Set @vector_X='000011111111133'
Set @vector_T='0000D3E11111100'

SELECT TOP 1
 DetSal.IdDetalleProduccionFicha,
 DetSal.IdProduccionFicha,
 DetSal.IdArticulo,
 DetSal.IdUnidad,
 '    ' as [*],
 
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as Articulo,
 Colores.Descripcion AS [Color],
 DetSal.Cantidad as [Cant.],
 isnull(Porcentaje,0) as [%],

 isnull(Tolerancia,0) as Tolerancia,
 Unidades.Descripcion as [En :],
 isnull(ProduccionProcesos.Descripcion,'') as [Proceso Asociado],

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleProduccionFichas DetSal
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON DetSal.IdColor = Colores.IdColor
LEFT OUTER JOIN ProduccionProcesos ON ProduccionProcesos.IdProduccionProceso=DetSal.IdProduccionProceso

select * from DetalleProduccionFichas

