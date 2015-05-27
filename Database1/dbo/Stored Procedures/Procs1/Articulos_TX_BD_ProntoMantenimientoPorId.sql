
CREATE Procedure [dbo].[Articulos_TX_BD_ProntoMantenimientoPorId]

@IdArticulo int, 
@IdObraPronto int = Null

AS 

SET NOCOUNT ON

DECLARE @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento From Parametros P Where P.IdParametro=1),'')
SET @sql1='Select name From master.dbo.sysdatabases WHERE name = N'+''''+@BasePRONTOMANT+''''

CREATE TABLE #Auxiliar1 (Descripcion VARCHAR(256))
INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

IF (SELECT COUNT(*) FROM #Auxiliar1)>0
   BEGIN
	DECLARE @IdObraMantenimiento int, @NumeroObra varchar(13)
	SET @IdObraMantenimiento=-1
	IF @IdObraPronto is not null
	   BEGIN
		SET @NumeroObra=IsNull((Select Top 1 O.NumeroObra From Obras O Where O.IdObra=@IdObraPronto),'')
		SET @sql1='Select Top 1 O.IdObra From '+@BasePRONTOMANT+'.dbo.Obras O Where O.NumeroObra='+''''+@NumeroObra+''''
		CREATE TABLE #Auxiliar2 (IdAux INTEGER)
		INSERT INTO #Auxiliar2 EXEC sp_executesql @sql1
		SET @IdObraMantenimiento=IsNull((Select Top 1 IdAux From #Auxiliar2),0)
		DROP TABLE #Auxiliar2
	   END

	SET NOCOUNT OFF

	SET @sql1='SELECT Art.IdArticulo, Art.Descripcion as [Material], Art.Codigo as [Codigo], Art.NumeroInventario as [NumeroInventario], Art.IdArticulo as [Id], 
			R.Descripcion as [Rubro], S.Descripcion as [Subrubro], Art.ParaMantenimiento as [P/mant.?], O.Descripcion as [Ubicacion actual], Art.Descripcion as [Titulo]
			FROM '+@BasePRONTOMANT+'.dbo.Articulos Art 
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Rubros R ON Art.IdRubro = R.IdRubro 
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Subrubros S ON Art.IdSubrubro = S.IdSubrubro 
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Obras O ON Art.IdObraActual = O.IdObra
			Where ('+Convert(varchar,@IdObraMantenimiento)+'=-1 or 
				IsNull(Art.IdObraActual,-1)='+Convert(varchar,@IdObraMantenimiento)+') and 
				Art.IdArticulo='+Convert(varchar,@IdArticulo)
	EXEC sp_executesql @sql1
   END
ELSE 
   BEGIN
	SET NOCOUNT OFF
	SELECT 
	 Art.IdArticulo,
	 Art.Descripcion as [Material],
	 Art.Codigo as [Codigo],
	 Art.NumeroInventario as [NumeroInventario],
	 Art.IdArticulo as [Id],
	 R.Descripcion as [Rubro],
	 S.Descripcion as [Subrubro],
	 Art.ParaMantenimiento as [P/mant.?],
	 Art.Descripcion as [Titulo]
	FROM Articulos Art 
	LEFT OUTER JOIN Rubros R ON Art.IdRubro = R.IdRubro 
	LEFT OUTER JOIN Subrubros S ON Art.IdSubrubro = S.IdSubrubro 
	WHERE Art.IdArticulo=@IdArticulo
   END

DROP TABLE #Auxiliar1
