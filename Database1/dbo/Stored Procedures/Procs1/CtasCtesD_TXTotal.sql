CREATE Procedure [dbo].[CtasCtesD_TXTotal]

@IdCliente int,
@Todo int,
@FechaLimite datetime,
@Consolidar int = Null

AS 

SET NOCOUNT ON

SET @Consolidar=IsNull(@Consolidar,-1)

DECLARE @ConsolidacionDeBDs VARCHAR(2), @NombreServidorWeb VARCHAR(100), @UsuarioServidorWeb VARCHAR(50), @PasswordServidorWeb VARCHAR(50), @BaseDeDatosServidorWeb VARCHAR(50), 
		@proc_name varchar(1000)

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

CREATE TABLE #Auxiliar10 
			(
			 Saldo NUMERIC(18,2),
			 IdCliente INTEGER
			)

IF Len(@NombreServidorWeb)>0 and @Consolidar>=0
  BEGIN
	EXEC sp_addlinkedserver @NombreServidorWeb
	SET @proc_name=@NombreServidorWeb+'.'+@BaseDeDatosServidorWeb+'.dbo.CtasCtesD_TXTotal'
	INSERT INTO #Auxiliar10 
		EXECUTE @proc_name @IdCliente, @Todo, @FechaLimite, @Consolidar
	EXEC sp_dropserver @NombreServidorWeb
  END

INSERT INTO #Auxiliar10 
 SELECT SUM(CtaCte.ImporteTotal*TiposComprobante.Coeficiente), CtaCte.IdCliente
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE CtaCte.IdCliente=@IdCliente and (@Todo=-1 or CtaCte.Fecha<=@FechaLimite)
 GROUP BY CtaCte.IdCliente

SET NOCOUNT OFF

SELECT SUM(IsNull(Saldo,0)) as [SaldoCta], IdCliente as [IdCliente]
FROM #Auxiliar10
GROUP BY IdCliente

DROP TABLE #Auxiliar10