


CREATE Procedure [dbo].[Cuentas_TX_CuentasConsolidacionPorIdCuenta]

@IdCuenta int,
@Numeral int

AS 

SET NOCOUNT ON

Declare @BasePRONTO varchar(50), @sql1 nvarchar(1000)
IF @Numeral=1
	Set @BasePRONTO=IsNull((Select Top 1 Parametros.BasePRONTOConsolidacion 
				From Parametros Where Parametros.IdParametro=1),'')
ELSE
	IF @Numeral=2
		Set @BasePRONTO=IsNull((Select Top 1 Parametros.BasePRONTOConsolidacion2 
					From Parametros Where Parametros.IdParametro=1),'')
	ELSE
		Set @BasePRONTO=IsNull((Select Top 1 Parametros.BasePRONTOConsolidacion3 
					From Parametros Where Parametros.IdParametro=1),'')
IF LEN(@BasePRONTO)=0
   BEGIN
	Set @sql1='Select C.IdCuenta, C.Codigo, C.Descripcion 
			From Cuentas C 
			Where C.IdCuenta=-1'
   END
ELSE
   BEGIN
	Set @sql1='Select Top 1 C.IdCuenta, C.Codigo, C.Descripcion 
			From '+@BasePRONTO+'.dbo.Cuentas C 
			Where C.IdCuenta='+Convert(varchar,@IdCuenta)
   END

CREATE TABLE #Auxiliar1 
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(50)
			)
INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

SET NOCOUNT OFF

SELECT *
FROM #Auxiliar1

DROP TABLE #Auxiliar1


