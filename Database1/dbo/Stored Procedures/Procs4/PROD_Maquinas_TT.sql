
CREATE Procedure PROD_Maquinas_TT
--@IdArticulo int
AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='00111033'
Set @vector_T='00111000'
SELECT 
 PROD_Maquinas.idPROD_Maquina,
 Articulos.IdArticulo,
 Articulos. Codigo,
 Articulos.Descripcion as Descripcion,
 PROD_Maquinas.LineaOrden,
 PROD_Maquinas.idProduccionLinea,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PROD_Maquinas
LEFT OUTER JOIN Articulos ON  PROD_Maquinas.IdArticulo = Articulos.IdArticulo 
