
CREATE Procedure [dbo].[Stock_TX_PartidasDisponibles]

@IdArticulo int = Null,
@Partida varchar(20) = Null

AS

SET @IdArticulo=IsNull(@IdArticulo,-1)
SET @Partida=IsNull(@Partida,'')

IF @Partida=''
    BEGIN
	SELECT Stock.Partida, Stock.Partida as [Titulo], Sum(IsNull(CantidadUnidades,0)) as [Cantidad]
	FROM Stock
	LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
	WHERE (@IdArticulo=-1 or Stock.IdArticulo=@IdArticulo) and 
		IsNull(CantidadUnidades,0)<>0 and IsNull(Articulos.RegistrarStock,'SI')='SI'
	GROUP BY Stock.Partida
	ORDER BY Stock.Partida
    END
ELSE
    BEGIN
	SELECT Stock.IdUbicacion, Sum(IsNull(CantidadUnidades,0)) as [Cantidad], 
		 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
			IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Titulo]
	FROM Stock
	LEFT OUTER JOIN Articulos ON Stock.IdArticulo=Articulos.IdArticulo
	LEFT OUTER JOIN Ubicaciones ON Stock.IdUbicacion=Ubicaciones.IdUbicacion
	LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
	WHERE (@IdArticulo=-1 or Stock.IdArticulo=@IdArticulo) and 
		IsNull(Partida,'')=@Partida and 
		IsNull(CantidadUnidades,0)<>0 and IsNull(Articulos.RegistrarStock,'SI')='SI' 
	GROUP BY Stock.IdUbicacion, Depositos.Abreviatura, Depositos.Descripcion, Ubicaciones.Descripcion, 
			Ubicaciones.Estanteria, Ubicaciones.Modulo, Ubicaciones.Gabeta
	ORDER BY Stock.IdUbicacion
    END
