
CREATE Procedure [dbo].[Cuentas_TX_CuentasConsolidacionParaCombo]

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
			Where C.IdTipoCuenta=2 or C.IdTipoCuenta=4
			Group By C.IdCuenta, C.Codigo, C.Descripcion
			Order by C.Descripcion'
   END
ELSE
   BEGIN
	Set @sql1='Select C.IdCuenta, C.Codigo, C.Descripcion 
			From '+@BasePRONTO+'.dbo.Cuentas C 
			Where C.IdTipoCuenta=2 or C.IdTipoCuenta=4
			Group By C.IdCuenta, C.Codigo, C.Descripcion
			Order by C.Descripcion'
   END

CREATE TABLE #Auxiliar1 
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(50)
			)
INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

SET NOCOUNT OFF

SELECT IdCuenta, Descripcion + ' ' + Convert(varchar,Codigo) as [Titulo]
FROM #Auxiliar1
ORDER BY Codigo, Descripcion

DROP TABLE #Auxiliar1
