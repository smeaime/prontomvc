
CREATE Procedure PROD_TiposControlCalidad_TX_TT
@idPROD_TiposControlCalidad int

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
WHERE (idPROD_TiposControlCalidad=@idPROD_TiposControlCalidad)
ORDER BY idPROD_TiposControlCalidad
