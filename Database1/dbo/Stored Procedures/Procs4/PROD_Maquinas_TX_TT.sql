
CREATE Procedure PROD_Maquinas_TX_TT

@IdPROD_Maquina int

AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='001133'
Set @vector_T='001100'
SELECT 
 PROD_Maquinas.idPROD_Maquina,
 Articulos.IdArticulo,
 Articulos. Codigo,
 Articulos.Descripcion as Descripcion,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PROD_Maquinas
LEFT OUTER JOIN Articulos ON  PROD_Maquinas.IdArticulo = Articulos.IdArticulo 
WHERE (IdPROD_Maquina=@IdPROD_Maquina)
