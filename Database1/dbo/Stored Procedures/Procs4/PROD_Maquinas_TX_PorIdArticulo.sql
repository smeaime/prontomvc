
create Procedure PROD_Maquinas_TX_PorIdArticulo
@IdArticulo int
AS 
SELECT * 
FROM PROD_Maquinas
WHERE (IdArticulo=@IdArticulo)
