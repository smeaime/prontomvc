CREATE Procedure [dbo].[CtasCtesD_TT]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 IdCliente INTEGER,
			 Codigo VARCHAR(20),
			 Cliente VARCHAR(100),
			 Saldo NUMERIC(12,2)
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
 GROUP By CtaCte.IdCliente,Clientes.Codigo,Clientes.RazonSocial

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01161111133'
SET @vector_T='02453203100'

SELECT 
 #Auxiliar.IdCliente,
 #Auxiliar.Codigo as [Codigo],
 #Auxiliar.Cliente as [Cliente],
 #Auxiliar.Saldo as [Saldo actual],
 (Select Count(*) From CuentasCorrientesDeudores CtaCte Where CtaCte.IdCliente=#Auxiliar.IdCliente) as [Cant.Reg.],
 Clientes.NombreFantasia as [Nombre comercial],
 Clientes.Direccion + ' ' + IsNull(Localidades.Nombre+' ','') + IsNull('('+Clientes.CodigoPostal+') ','') + Case When IsNull(UPPER(Provincias.Nombre),'')<>'CAPITAL FEDERAL' Then IsNull(Provincias.Nombre+' ','') Else '' End as [Direccion],
 Clientes.Telefono, 
 (Select Vendedores.Nombre From Vendedores Where Clientes.Cobrador=Vendedores.IdVendedor) as [Cobrador], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
LEFT OUTER JOIN Localidades ON Localidades.IdLocalidad=Clientes.IdLocalidad
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=Clientes.IdProvincia
ORDER BY #Auxiliar.Cliente

UPDATE Clientes
SET Saldo=(Select #Auxiliar.Saldo From #Auxiliar Where #Auxiliar.IdCliente=Clientes.IdCliente)

DROP TABLE #Auxiliar