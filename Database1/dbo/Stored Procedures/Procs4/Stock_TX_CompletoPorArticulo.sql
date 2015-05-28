
create Procedure Stock_TX_CompletoPorArticulo

@IdArticulo int = Null,
@Partida varchar(20) = Null,
@IdUbicacion int = Null,
@IdObra int = Null,
@IdUnidad int = Null,
@NumeroCaja int = Null

AS 

SET @Partida=IsNull(@Partida,'')
SET @IdUbicacion=IsNull(@IdUbicacion,0)
SET @IdObra=IsNull(@IdObra,0)
SET @IdObra=IsNull(@IdObra,0)
SET @NumeroCaja=IsNull(@NumeroCaja,0)

SELECT Stock.*,Articulos.Codigo,Articulos.Descripcion
FROM Stock
LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
WHERE 
	( Stock.IdArticulo=isnull(@IdArticulo,Stock.IdArticulo) or @IdArticulo=0)  and
	(IsNull(Stock.Partida,'')=@Partida or @Partida=0) and 
--	IsNull(Stock.IdUbicacion,0)=@IdUbicacion and 
--	IsNull(Stock.IdObra,0)=@IdObra and 
--	isnull(Stock.IdUnidad,0)=@IdUnidad and 
--	IsNull(Stock.NumeroCaja,0)=@NumeroCaja and 
	IsNull(Articulos.RegistrarStock,'SI')='SI'

