CREATE Procedure [dbo].[Articulos_TX_ParaMantenimiento_ParaCombo]

@IdDetalleObraDestino int = Null,
@IdObra int = Null,
@IdArticulo int = Null,
@OrigenLlamada varchar(2) = Null

AS 

SET @IdDetalleObraDestino=IsNull(@IdDetalleObraDestino,0)
SET @IdObra=IsNull(@IdObra,0)
SET @IdArticulo=IsNull(@IdArticulo,0)
SET @OrigenLlamada=IsNull(@OrigenLlamada,'')

DECLARE @LimitarEquiposDestinoSegunEtapasDeObra varchar(2), @IdTipoArticuloEquipos int, @EquipoDestinoDesdePRONTO_MANTENIMIENTO varchar(2), @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), 
	@sql1 nvarchar(2000), @BasePRONTOMANT varchar(50), @NumeroObra varchar(13), @IdObraMantenimiento int, @IdRubroUnidadesFuncionales int

SET @LimitarEquiposDestinoSegunEtapasDeObra=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='LimitarEquiposDestinoSegunEtapasDeObra'),'NO')
SET @IdTipoArticuloEquipos=IsNull((Select Top 1 Convert(int,P2.Valor) From Parametros2 P2 Where P2.Campo='IdTipoArticuloEquipos'),-1)
SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO'),'NO')
SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')
SET @NumeroObra=IsNull((Select Top 1 O.NumeroObra From Obras O Where O.IdObra=@IdObra),'S/D')
SET @IdRubroUnidadesFuncionales=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdRubroUnidadesFuncionales'),0)

IF ((@OrigenLlamada='SA' and @EquipoDestinoDesdePRONTO_MANTENIMIENTO='SI') or (@OrigenLlamada<>'SA' and @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI')) and Len(@BasePRONTOMANT)>0 
    BEGIN
	SET NOCOUNT ON

	CREATE TABLE #Auxiliar1 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))

	SET @sql1='Select Top 1 O.IdObra, Null, Null From '+@BasePRONTOMANT+'.dbo.Obras O Where O.NumeroObra='+''''+@NumeroObra+''''
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
	SET @IdObraMantenimiento=IsNull((Select Top 1 IdArticulo From #Auxiliar1),0)

	TRUNCATE TABLE #Auxiliar1
	SET @sql1='Select A.IdArticulo, A.Descripcion, A.NumeroInventario From '+@BasePRONTOMANT+'.dbo.Articulos A 
			Where ('+Convert(varchar,@IdObra)+'<=0 or IsNull(A.IdObraActual,-1)='+Convert(varchar,@IdObraMantenimiento)+') and 
				('+Convert(varchar,@IdArticulo)+'<=0 or A.IdArticulo='+Convert(varchar,@IdArticulo)+') and 
				IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
	SET NOCOUNT OFF
	
	SELECT IdArticulo, Descripcion as [Titulo], NumeroInventario
	FROM #Auxiliar1
	ORDER BY Descripcion
	
	DROP TABLE #Auxiliar1
    END
ELSE
	IF @LimitarEquiposDestinoSegunEtapasDeObra='SI'
		SELECT DISTINCT Articulos.IdArticulo, Articulos.Descripcion as [Titulo], Articulos.NumeroInventario as [NumeroInventario]
		FROM Articulos
		LEFT OUTER JOIN DetalleObrasDestinos dod ON dod.IdDetalleObraDestino=@IdDetalleObraDestino or dod.IdObra=@IdObra
		WHERE IsNull(Articulos.Activo,'')<>'NO' and IsNull(Articulos.ParaMantenimiento,'SI')='SI' and 
			(@IdObra=0 or IsNull(dod.InformacionAuxiliar,'-1')=IsNull(Articulos.NumeroManzana COLLATE Modern_Spanish_CI_AS,'-2')) and 
			(@IdTipoArticuloEquipos=-1 or IsNull(Articulos.IdTipoArticulo,0)=@IdTipoArticuloEquipos) and (@IdArticulo<=0 or Articulos.IdArticulo=@IdArticulo)
		ORDER BY Articulos.Descripcion
	ELSE
		SELECT IdArticulo, Descripcion as [Titulo], NumeroInventario as [NumeroInventario]
		FROM Articulos
		WHERE IsNull(Activo,'')<>'NO' and IsNull(ParaMantenimiento,'SI')='SI' and (@IdTipoArticuloEquipos=-1 or IsNull(IdTipoArticulo,0)=@IdTipoArticuloEquipos) and 
			(@IdArticulo<=0 or Articulos.IdArticulo=@IdArticulo) and (@IdRubroUnidadesFuncionales<=0 or Articulos.IdRubro=@IdRubroUnidadesFuncionales)
		ORDER BY Descripcion