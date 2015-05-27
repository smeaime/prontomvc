CREATE Procedure [dbo].[ProntoMantenimiento_TX_OTsPorEquipo]

@IdArticulo int

AS 

DECLARE @BasePRONTOMANT varchar(50)

SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento From Parametros P Where P.IdParametro=1),'')

IF DB_ID(@BasePRONTOMANT) is not null
  BEGIN
	SET NOCOUNT ON
	CREATE TABLE #Auxiliar3 (IdAux1 INTEGER, IdAux2 INTEGER)
	DECLARE @sql1 nvarchar(1000), @IdEquipo int
/*
	SET @sql1='Select Top 1 Art.IdArticulo, Null 
			From Articulos 
			Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos Art On Articulos.NumeroInventario=Art.NumeroInventario
			Where Articulos.IdArticulo='+Convert(varchar,@IdArticulo)
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
	SET @IdEquipo=IsNull((Select Top 1 IdAux1 From #Auxiliar3),0)
*/
	SET @IdEquipo=@IdArticulo

	TRUNCATE TABLE #Auxiliar3
	SET @sql1='Select OT.IdOrdenTrabajo, OT.NumeroOrdenTrabajo as [Titulo]
				From '+@BasePRONTOMANT+'.dbo.OrdenesTrabajo OT 
				Where ('+Convert(varchar,@IdArticulo)+'=-1 or OT.IdArticulo='+Convert(varchar,@IdEquipo)+') and OT.FechaInicial is not null and 
						IsNull(OT.Cumplida,'''+'NO'+''')='''+'NO'+''' and IsNull(OT.Anulada,'''+'NO'+''')='''+'NO'+''''
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
	SET NOCOUNT OFF

	SELECT IdAux1 as [IdOrdenTrabajo], IdAux2 as [Titulo]
	FROM #Auxiliar3 
	ORDER by IdAux2

	DROP TABLE #Auxiliar3
  END
ELSE
	SELECT Null as [IdOrdenTrabajo], Null as [Titulo]
	WHERE 1=-1
