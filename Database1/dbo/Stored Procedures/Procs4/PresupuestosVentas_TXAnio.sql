CREATE Procedure [dbo].[PresupuestosVentas_TXAnio]

AS

SET NOCOUNT ON
SET ANSI_WARNINGS ON
SET ANSI_NULLS ON

DECLARE @ConsolidacionDeBDs varchar(2), @NombreServidorWeb varchar(100), @UsuarioServidorWeb varchar(50), @PasswordServidorWeb varchar(50), @BaseDeDatosServidorWeb varchar(50), @sql1 nvarchar(4000)

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

CREATE TABLE #Auxiliar1	
			(
			 Fecha DATETIME,
			 TipoVenta INTEGER
			)

IF LEN(@NombreServidorWeb)>0
   BEGIN
	SET @sql1='Select Distinct Fecha, TipoVenta 
			From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
   END
ELSE
   BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT Fecha, TipoVenta FROM PresupuestosVentas
   END

SET NOCOUNT OFF

SELECT Min(CONVERT(varchar, YEAR(Fecha))) as Período, YEAR(Fecha)
FROM #Auxiliar1
WHERE ((@ConsolidacionDeBDs='NO' and IsNull(#Auxiliar1.TipoVenta,1)=1) or (@ConsolidacionDeBDs='SI' and IsNull(#Auxiliar1.TipoVenta,1)=2))
GROUP BY YEAR(Fecha) 
ORDER BY YEAR(Fecha) desc

DROP TABLE #Auxiliar1