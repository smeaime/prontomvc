CREATE PROCEDURE [dbo].[Conjuntos_CalcularCostoConjunto_Todos]

AS

UPDATE Articulos
SET 
 CostoPPP=(Select Sum(IsNull(A1.CostoPPP,0) * Det.Cantidad)
			From DetalleConjuntos Det 
			Left Outer Join Conjuntos C On C.IdConjunto=Det.IdConjunto
			Left Outer Join Articulos A1 On A1.IdArticulo=Det.IdArticulo
			Where C.IdArticulo=Articulos.IdArticulo),
 CostoPPPDolar=(Select Sum(IsNull(A1.CostoPPPDolar,0) * Det.Cantidad)
				From DetalleConjuntos Det 
				Left Outer Join Conjuntos C On C.IdConjunto=Det.IdConjunto
				Left Outer Join Articulos A1 On A1.IdArticulo=Det.IdArticulo
				Where C.IdArticulo=Articulos.IdArticulo),
 CostoReposicion=(Select Sum(IsNull(A1.CostoReposicion,0) * Det.Cantidad)
					From DetalleConjuntos Det 
					Left Outer Join Conjuntos C On C.IdConjunto=Det.IdConjunto
					Left Outer Join Articulos A1 On A1.IdArticulo=Det.IdArticulo
					Where C.IdArticulo=Articulos.IdArticulo),
 CostoReposicionDolar=(Select Sum(IsNull(A1.CostoReposicionDolar,0) * Det.Cantidad)
						From DetalleConjuntos Det 
						Left Outer Join Conjuntos C On C.IdConjunto=Det.IdConjunto
						Left Outer Join Articulos A1 On A1.IdArticulo=Det.IdArticulo
						Where C.IdArticulo=Articulos.IdArticulo)
WHERE Exists(Select Top 1 Conjuntos.IdArticulo From Conjuntos Where Conjuntos.IdArticulo=Articulos.IdArticulo)