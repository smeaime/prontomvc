
CREATE Procedure [dbo].[Stock_TX_STK]

@IdArticulo int,
@Partida varchar(20) = Null,
@IdUbicacion int = Null,
@IdObra int = Null,
@IdUnidad int,
@NumeroCaja int = Null

AS 

SET @Partida=IsNull(@Partida,'')
SET @IdUbicacion=IsNull(@IdUbicacion,0)
SET @IdObra=IsNull(@IdObra,0)
SET @NumeroCaja=IsNull(@NumeroCaja,0)

SELECT Stock.*
FROM Stock
LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
WHERE 
	Stock.IdArticulo=@IdArticulo and 
	IsNull(Stock.Partida,'')=@Partida and 
	IsNull(Stock.IdUbicacion,0)=@IdUbicacion and 
	IsNull(Stock.IdObra,0)=@IdObra and 
	Stock.IdUnidad=@IdUnidad and 
	IsNull(Stock.NumeroCaja,0)=@NumeroCaja and 
	IsNull(Articulos.RegistrarStock,'SI')='SI'
