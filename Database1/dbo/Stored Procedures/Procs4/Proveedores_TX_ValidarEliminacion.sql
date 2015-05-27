CREATE Procedure [dbo].[Proveedores_TX_ValidarEliminacion]

@IdProveedor int

AS 

SET NOCOUNT ON

DECLARE @sql1 NVARCHAR(4000), @DatosServidor varchar(200), @Aux varchar(200), @NombreServidorWeb varchar(100), @BaseDeDatosServidorWeb varchar(50), @proc_name varchar(1000), 
		@Todo int, @FechaDesde date, @FechaLimite date, @Consolidar int, @Pendiente varchar(1), @Separador varchar(1)

SET @DatosServidor=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
							Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
							Where pic.Clave='Datos servidor de correo'),'')
SET @Todo=-1
SET @FechaDesde=Convert(datetime,'1/1/2000')
SET @FechaLimite=GetDate()
SET @Consolidar=-1
SET @Pendiente='N'
SET @Separador=','

SET @NombreServidorWeb=''
SET @BaseDeDatosServidorWeb=''
IF Len(@DatosServidor)>0 
  BEGIN
	IF PATINDEX('%'+@Separador+'%', @DatosServidor)>0
		SET @Aux=@DatosServidor
		SET @NombreServidorWeb=Substring(@Aux,1,PATINDEX('%'+@Separador+'%', @Aux)-1)
		SET @Aux=Substring(@Aux,PATINDEX('%'+@Separador+'%', @Aux)+1,1000)
		SET @BaseDeDatosServidorWeb=Rtrim(@Aux)
  END

CREATE TABLE #Auxiliar100
			(
			 IdCtaCte INTEGER,
			 IdImputacion INTEGER,
			 TipoComprobante VARCHAR(5),
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Comprobante VARCHAR(16),
			 NumeroComprobante INTEGER,
			 Fecha DATETIME,
			 FechaVencimiento DATETIME,
			 ImporteTotal NUMERIC(18,2),
			 Saldo NUMERIC(18,2),
			 SaldoTransaccion NUMERIC(18,2),
			 FechaComprobante DATETIME,
			 IdImputacion2 INTEGER,
			 Saldo2 NUMERIC(18,2),
			 Cabeza VARCHAR(1),
			 Moneda VARCHAR(15),
			 Observaciones VARCHAR(1500),
			 IdProveedor INTEGER,
			 IdCtaCte2 INTEGER,
			 Pedidos VARCHAR(1000),
			 Vector_E VARCHAR(100),
			 Vector_T VARCHAR(100),
			 Vector_X VARCHAR(100)
			)

IF Len(@NombreServidorWeb)>0 
  BEGIN
	EXEC sp_addlinkedserver @NombreServidorWeb
	SET @proc_name=@NombreServidorWeb+'.'+@BaseDeDatosServidorWeb+'.dbo.CtasCtesA_TXPorTrs'
	INSERT INTO #Auxiliar100 
		EXECUTE @proc_name @IdProveedor, @Todo, @FechaLimite, @FechaDesde, @Consolidar, @Pendiente
	EXEC sp_dropserver @NombreServidorWeb
  END

SET @proc_name='CtasCtesA_TXPorTrs'
INSERT INTO #Auxiliar100 
	EXECUTE @proc_name @IdProveedor, @Todo, @FechaLimite, @FechaDesde, @Consolidar, @Pendiente

SET NOCOUNT OFF

SELECT * 
FROM #Auxiliar100

DROP TABLE #Auxiliar100
