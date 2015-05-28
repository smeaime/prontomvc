
CREATE Procedure [dbo].[Stock_TX_ExistenciaPorIdArticulo]

@IdArticulo int,
@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

SELECT 
 Stock.IdArticulo,
 Sum(IsNull(Stock.CantidadUnidades,0)) as [Stock actual]
FROM Stock 
LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
LEFT OUTER JOIN Ubicaciones ON Stock.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE Stock.IdArticulo=@IdArticulo and IsNull(Articulos.RegistrarStock,'SI')='SI' and 
	(@IdObra=-1 or IsNull(Stock.IdObra,0)=@IdObra)  
GROUP by Stock.IdArticulo
