CREATE Procedure [dbo].[TiposRosca_TX_TT]

@IdTipoRosca int

AS 

DECLARE @sql1 nvarchar(1000), @BasePRONTOMANT varchar(50)
SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento 
				From Parametros P Where P.IdParametro=1),'')

IF DB_ID(@BasePRONTOMANT) is not null
   BEGIN
	SET NOCOUNT ON
	CREATE TABLE #Auxiliar3 
				(
				 IdTipoRosca INTEGER,
				 Descripcion VARCHAR(50),
				 Abreviatura VARCHAR(15),
				 ArticuloProntoMantenimiento VARCHAR(256)
				)
	SET @sql1='Select TiposRosca.IdTipoRosca, TiposRosca.Descripcion, 
				TiposRosca.Abreviatura, Art.Descripcion 
			From TiposRosca 
			Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos Art On TiposRosca.IdArticuloPRONTO_MANTENIMIENTO=Art.IdArticulo
			Where TiposRosca.IdTipoRosca='+Convert(varchar,@IdTipoRosca)
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
	SET NOCOUNT OFF

	SELECT IdTipoRosca, Descripcion, Abreviatura, 
		ArticuloProntoMantenimiento as [Articulo Pronto Mantenimiento asociado]
	FROM #Auxiliar3

	DROP TABLE #Auxiliar3
   END
ELSE
   BEGIN
	SELECT 
	 TiposRosca.IdTipoRosca,
	 TiposRosca.Descripcion,
	 TiposRosca.Abreviatura
	FROM TiposRosca
	WHERE TiposRosca.IdTipoRosca=@IdTipoRosca
   END