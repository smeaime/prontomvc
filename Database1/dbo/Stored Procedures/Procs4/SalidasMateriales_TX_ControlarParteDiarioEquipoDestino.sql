
CREATE Procedure [dbo].[SalidasMateriales_TX_ControlarParteDiarioEquipoDestino]

@IdEquipo int,
@Fecha datetime

AS 

DECLARE @sql1 nvarchar(1000), @BasePRONTOMANT varchar(50)
SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento 
				From Parametros P Where P.IdParametro=1),'')

IF DB_ID(@BasePRONTOMANT) is not null
   BEGIN
	SET NOCOUNT ON
	CREATE TABLE #Auxiliar3 (NumeroParteDiario INTEGER)
	SET @sql1='Select Top 1 Cab.NumeroParteDiario 
			From '+@BasePRONTOMANT+'.dbo.DetallePartesDiarios Det 
			Left Outer Join '+@BasePRONTOMANT+'.dbo.PartesDiarios Cab On Det.IdParteDiario=Cab.IdParteDiario
			Where Det.IdEquipo='+Convert(varchar,@IdEquipo)+' and 
				DateAdd(d,1,Cab.FechaParteDiario)=Convert(datetime,'+''''+Convert(varchar,@Fecha,103)+''''+')'
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
	SET NOCOUNT OFF

	SELECT *
	FROM #Auxiliar3

	DROP TABLE #Auxiliar3
   END
ELSE
   BEGIN
	SELECT 0 as [NumeroParteDiario] WHERE 1=-1
   END
