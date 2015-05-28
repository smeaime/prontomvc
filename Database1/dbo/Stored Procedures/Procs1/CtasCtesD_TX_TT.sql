CREATE Procedure [dbo].[CtasCtesD_TX_TT]

@Consolidar int = Null,
@IdVendedor int = Null

AS 

SET NOCOUNT ON

SET @Consolidar=IsNull(@Consolidar,-1)
SET @IdVendedor=IsNull(@IdVendedor,-1)

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, 
		@ConsolidacionDeBDs VARCHAR(2), @NombreServidorWeb VARCHAR(100), @UsuarioServidorWeb VARCHAR(50), @PasswordServidorWeb VARCHAR(50), @BaseDeDatosServidorWeb VARCHAR(50), 
		@proc_name varchar(1000), @vector_X varchar(30), @vector_T varchar(30), @vector_E varchar(1000)

SET @vector_X='01161111133'
SET @vector_T='02453203100'

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

CREATE TABLE #Auxiliar 
			(
			 IdCliente INTEGER,
			 Codigo VARCHAR(20),
			 Cliente VARCHAR(100),
			 Saldo NUMERIC(12,2)
			)

CREATE TABLE #Auxiliar10
			(
			 IdCliente INTEGER,
			 Codigo VARCHAR(20),
			 Cliente VARCHAR(100),
			 Saldo NUMERIC(12,2),
			 Registros INTEGER,
			 NombreFantasia VARCHAR(100),
			 Direccion VARCHAR(500),
			 Telefono VARCHAR(50),
			 Cobrador VARCHAR(50),
			 Vector_T VARCHAR(100),
			 Vector_X VARCHAR(100)
			)

INSERT INTO #Auxiliar 
 SELECT 
  CtaCte.IdCliente,
  Clientes.Codigo,
  Clientes.RazonSocial,
  Sum(IsNull(CtaCte.ImporteTotal,0)*IsNull(TiposComprobante.Coeficiente,1))
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE (@IdVendedor=-1 or Clientes.Vendedor1=@IdVendedor)
 GROUP By CtaCte.IdCliente,Clientes.Codigo,Clientes.RazonSocial

INSERT INTO #Auxiliar10 
 SELECT 
  #Auxiliar.IdCliente,
  #Auxiliar.Codigo,
  #Auxiliar.Cliente,
  #Auxiliar.Saldo,
  (Select Count(*) From CuentasCorrientesDeudores CtaCte Where CtaCte.IdCliente=#Auxiliar.IdCliente),
  Clientes.NombreFantasia,
  Clientes.Direccion  COLLATE Modern_Spanish_ci_as  + ' ' + IsNull(Localidades.Nombre+' ','') + IsNull('('+Clientes.CodigoPostal+') ','') + 
		Case When IsNull(UPPER(Provincias.Nombre),'')<>'CAPITAL FEDERAL' Then IsNull(Provincias.Nombre+' ','') Else '' End,
  Clientes.Telefono, 
  Vendedores.Nombre,
  @Vector_T,
  @Vector_X
 FROM #Auxiliar
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
 LEFT OUTER JOIN Localidades ON Localidades.IdLocalidad=Clientes.IdLocalidad
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=Clientes.IdProvincia
 LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=Clientes.Cobrador

IF Len(@NombreServidorWeb)>0 and @Consolidar>=0
  BEGIN
	EXEC sp_addlinkedserver @NombreServidorWeb
	SET @proc_name=@NombreServidorWeb+'.'+@BaseDeDatosServidorWeb+'.dbo.CtasCtesD_TX_TT'
	INSERT INTO #Auxiliar10 
		EXECUTE @proc_name @Consolidar, @IdVendedor
	EXEC sp_dropserver @NombreServidorWeb
--EXEC sp_dropserver 'serversql1'
  END

UPDATE Clientes
SET Saldo=(Select Sum(IsNull(#Auxiliar10.Saldo,0)) From #Auxiliar10 Where #Auxiliar10.IdCliente=Clientes.IdCliente)

SET NOCOUNT OFF

SELECT 
 IdCliente,
 Max(IsNull(Codigo,'')) as [Codigo],
 Max(IsNull(Cliente,'')) as [Cliente],
 Sum(IsNull(Saldo,0)) as [Saldo actual],
 Sum(IsNull(Registros,0)) as [Cant.Reg.],
 Max(IsNull(NombreFantasia,'')) as [Nombre comercial],
 Max(IsNull(Direccion,'')) as [Direccion],
 Max(IsNull(Telefono,'')) as [Telefono], 
 Max(IsNull(Cobrador,'')) as [Cobrador], 
 @vector_T as Vector_T,
 @vector_X as Vector_X
FROM #Auxiliar10
GROUP BY IdCliente
ORDER BY Cliente

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar10