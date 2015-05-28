CREATE Procedure PROD_TiposControlCalidad_TT

AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='01133'
Set @vector_T='01300'
SELECT 
idPROD_TiposControlCalidad,
Codigo,
Descripcion,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PROD_TiposControlCalidad 
/*LEFT OUTER JOIN ProduccionOrdenes ON  PROD_TiposControlCalidad.IdProduccionOrden = ProduccionOrdenes.IdProduccionOrden
LEFT OUTER JOIN ProduccionProcesos ON  PROD_TiposControlCalidad.IdProduccionProceso = ProduccionProcesos.IdProduccionProceso
LEFT OUTER JOIN Empleados ON  PROD_TiposControlCalidad.IdEmpleado = Empleados.IdEmpleado
LEFT OUTER JOIN Unidades ON PROD_TiposControlCalidad.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Articulos ON PROD_TiposControlCalidad.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Articulos Maquinas ON PROD_TiposControlCalidad.IdMaquina = Articulos.IdArticulo
*/
ORDER BY idPROD_TiposControlCalidad
