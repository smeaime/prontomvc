CREATE Procedure [dbo].[Articulos_TX_PorNumeroInventarioParaMantenimiento]

@NumeroInventario varchar(20), 
@IdObraPronto int = Null,
@OrigenLlamada varchar(2) = Null

AS 

SET NOCOUNT ON

SET @IdObraPronto=IsNull(@IdObraPronto,0)
SET @OrigenLlamada=IsNull(@OrigenLlamada,'')

DECLARE @EquipoDestinoDesdePRONTO_MANTENIMIENTO varchar(2), @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50), 
	@IdObraMantenimiento int, @NumeroObra varchar(13)

SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO'),'NO')
SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

IF ((@OrigenLlamada='SA' and @EquipoDestinoDesdePRONTO_MANTENIMIENTO='SI') or (@OrigenLlamada<>'SA' and @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI')) and Len(@BasePRONTOMANT)>0 
    BEGIN
	SET @IdObraMantenimiento=-1
	IF @IdObraPronto>0
	    BEGIN
		SET @NumeroObra=IsNull((Select Top 1 O.NumeroObra From Obras O Where O.IdObra=@IdObraPronto),'')
		SET @sql1='Select Top 1 O.IdObra From '+@BasePRONTOMANT+'.dbo.Obras O Where O.NumeroObra='+''''+@NumeroObra+''''
		CREATE TABLE #Auxiliar1 (IdAux INTEGER)
		INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
		SET @IdObraMantenimiento=IsNull((Select Top 1 IdAux From #Auxiliar1),0)
		DROP TABLE #Auxiliar1
	    END
	SET @sql1='SELECT Art.IdArticulo, Art.Descripcion as [Material], Art.Codigo as [Codigo], Art.NumeroInventario as [NumeroInventario], Art.IdArticulo as [Id], 
			R.Descripcion as [Rubro], S.Descripcion as [Subrubro],Art.ParaMantenimiento as [P/mant.?], O.Descripcion as [Ubicacion actual],
			Art.Descripcion as [Titulo], O.NumeroObra as [NumeroObra]
			FROM '+@BasePRONTOMANT+'.dbo.Articulos Art 
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Rubros R ON Art.IdRubro = R.IdRubro 
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Subrubros S ON Art.IdSubrubro = S.IdSubrubro 
			LEFT OUTER JOIN '+@BasePRONTOMANT+'.dbo.Obras O ON Art.IdObraActual = O.IdObra
			Where ('+Convert(varchar,@IdObraMantenimiento)+'=-1 or IsNull(Art.IdObraActual,-1)='+Convert(varchar,@IdObraMantenimiento)+') and Art.NumeroInventario='+''''+@NumeroInventario+''''
	SET NOCOUNT OFF
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
	 Art.Descripcion as [Titulo],
	 Null as [NumeroObra]
	FROM Articulos Art 
	LEFT OUTER JOIN Rubros R ON Art.IdRubro = R.IdRubro 
	LEFT OUTER JOIN Subrubros S ON Art.IdSubrubro = S.IdSubrubro 
	WHERE Art.NumeroInventario=@NumeroInventario
    END