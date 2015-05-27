
CREATE Procedure Articulos_TX_PorDescripcionTipoParaCombo
@IdTipo int =0,
@Descripcion varchar(20)=''

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='0111111111111111111133'
Set @vector_T='05E9113234342233046200'



DECLARE @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)
SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento 
				From Parametros P Where P.IdParametro=1),'')


IF @Descripcion='Equipo' and Len(@BasePRONTOMANT)>0 --and 1=0 --prontoMantenimiento está
begin
	SET NOCOUNT ON
	
	CREATE TABLE #Auxiliar1 (IdArticulo INTEGER, Descripcion VARCHAR(256))

	SET @sql1='Select A.IdArticulo, A.Descripcion 
			From '+@BasePRONTOMANT+'.dbo.Articulos A
			where ParaMantenimiento=''SI'''

	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

	SET NOCOUNT OFF
	
	SELECT IdArticulo, Descripcion as [Titulo]
	FROM #Auxiliar1
	ORDER by Descripcion
	
	DROP TABLE #Auxiliar1
	
	/*
	select paramantenimiento from articulos where  ParaMantenimiento='SI' --es un equipo
	select * from prontomantenimiento.dbo.articulos
	exec Articulos_TX_BD_ProntoMantenimiento
	*/

end
	else
begin
	SELECT 
	  Articulos.IdArticulo,
	 Articulos.Descripcion as Titulo
	
	FROM Articulos
	LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
	LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
	LEFT OUTER JOIN Ubicaciones ON Articulos.IdUbicacionStandar = Ubicaciones.IdUbicacion
	LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
	LEFT OUTER JOIN Tipos ON Tipos.IdTipo = Articulos.idTipo
	WHERE 
		(IsNull(Tipos.IdTipo,0)=@IdTipo or @IdTipo=0)
		and
		(	isnull(Tipos.Descripcion,'')=@Descripcion 
			or 
			@Descripcion='' 
			or
			(@Descripcion='Equipo' and ParaMantenimiento='SI')
		)
		and 
		IsNull(Articulos.Activo,'')<>'NO'
	
	ORDER by Rubros.Descripcion,Subrubros.Descripcion,Articulos.Codigo
end
