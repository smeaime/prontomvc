
CREATE Procedure [dbo].[Stock_CalcularEquivalencias]

@IdArticulo int = Null

AS

SET @IdArticulo=IsNull(@IdArticulo,-1)

UPDATE Stock
SET Equivalencia=IsNull((Select Top 1 Case When IsNull(Equivalencia,1)=0 Then 1 Else IsNull(Equivalencia,1) End 
				From DetalleArticulosUnidades Where IdArticulo=Stock.IdArticulo and IdUnidad=Stock.IdUnidad),1)
WHERE @IdArticulo=-1 or Stock.IdArticulo=@IdArticulo

UPDATE Stock
SET CantidadEquivalencia=CantidadUnidades/Equivalencia
WHERE @IdArticulo=-1 or Stock.IdArticulo=@IdArticulo
