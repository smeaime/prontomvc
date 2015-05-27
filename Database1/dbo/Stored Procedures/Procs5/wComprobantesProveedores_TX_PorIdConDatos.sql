CREATE Procedure [dbo].[wComprobantesProveedores_TX_PorIdConDatos]

@IdComprobanteProveedor int

AS 

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdCtaAdicCol1 int, @IdCtaAdicCol2 int, @IdCtaAdicCol3 int, @IdCtaAdicCol4 int, @IdCtaAdicCol5 int
SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar 
			(
			 IdComprobanteProveedor INTEGER,
			 GravadoIVA NUMERIC(18,2)
			)
INSERT INTO #Auxiliar 
SELECT
 dcp.IdComprobanteProveedor,
 SUM(
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then 0
				 Else 	Case When cp.Letra='A' or cp.Letra='M' 
						Then dcp.Importe
						Else dcp.Importe-(dcp.ImporteIVA1+dcp.ImporteIVA2+dcp.ImporteIVA3+dcp.ImporteIVA4+dcp.ImporteIVA5+
								  dcp.ImporteIVA6+dcp.ImporteIVA7+dcp.ImporteIVA8+dcp.ImporteIVA9+dcp.ImporteIVA10)
					End --*cp.CotizacionMoneda  
			End
		Else 0
	 End)
FROM DetalleComprobantesProveedores dcp 
LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
LEFT OUTER JOIN Cuentas ON dcp.IdCuenta=Cuentas.IdCuenta
WHERE dcp.IdComprobanteProveedor=@IdComprobanteProveedor
GROUP BY dcp.IdComprobanteProveedor

SET NOCOUNT OFF

SELECT 
 cp.*,
 Case When P1.IBCondicion is not null and P1.IBCondicion=2
	Then (Select Top 1 dpib.AlicuotaAAplicar From DetalleProveedoresIB dpib Where dpib.IdProveedor=cp.IdProveedor and dpib.IdIBCondicion=cp.IdIBCondicion)
	Else Null
 End as [Alicuota Conv.Mul.],
 (Select Sum(dcp.Importe) From DetalleComprobantesProveedores dcp
  Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and dcp.TomarEnCalculoDeImpuestos is not null and dcp.TomarEnCalculoDeImpuestos='NO') as [RestarAlBruto],
 IsNull(#Auxiliar.GravadoIVA,0) as [GravadoIVA],
 (Select Sum(IsNull(cp1.TotalIva1,0)*IsNull(cp1.CotizacionMoneda,0)) From ComprobantesProveedores cp1 Where cp1.IdComprobanteImputado=cp.IdComprobanteProveedor) as [IvaCreditos],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 E1.Nombre as [Ingreso],
 E2.Nombre as [Modifico],
 P1.RazonSocial as [Proveedor], 
 IsNull(P1.Direccion,'')+IsNull(' '+Localidades.Nombre,'')+IsNull(' '+P1.CodigoPostal,'')+IsNull(' '+Prov1.Nombre,'') as [Domicilio],
 P1.Cuit as [CuitProveedor], 
 cc.Descripcion as [CondicionCompra],
 Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [NumeroCP],
 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Numero],
 Monedas.Abreviatura as [Moneda],
 IsNull((Select Sum(IsNull(CtaCte.Saldo,0)) From CuentasCorrientesAcreedores CtaCte
	 Left Outer Join TiposComprobante tc On tc.IdTipoComprobante=CtaCte.IdTipoComp
	 Where CtaCte.IdProveedor=cp.IdProveedor and tc.Coeficiente=-1),0) as [AnticiposAAplicar],
 (Select Top 1 E.Nombre+' '+Convert(varchar,ac.FechaAutorizacion,103) From AutorizacionesPorComprobante ac 
  Left Outer Join Empleados E On E.IdEmpleado=ac.IdAutorizo
  Where ac.IdFormulario=31 and ac.IdComprobante=cp.IdComprobanteProveedor
  Order By ac.OrdenAutorizacion Desc) as [UltimoFirmante],
 TiposComprobante.Descripcion as [TipoComprobante],
 IsNull(P1.RazonSocial,C1.Descripcion) as [ProveedorCuenta],
 Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
	When cp.IdCuenta is not null Then 'F.fijo' 
	When cp.IdCuentaOtros is not null Then 'Otros' 
	Else Null
 End as [Tipo],
 P2.RazonSocial as [ProveedorFF],
 IsNull(diva1.Descripcion,IsNull(diva2.Descripcion,diva3.Descripcion)) as [CondicionIVA],
 IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [CodigoProveedor], 
 OrdenesPago.NumeroOrdenPago as [Vale],
 Prov2.Nombre as [ProvinciaDestino]
FROM ComprobantesProveedores cp 
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
LEFT OUTER JOIN Proveedores P1 ON cp.IdProveedor = P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor
LEFT OUTER JOIN Cuentas C1 ON IsNull(cp.IdCuenta,cp.IdCuentaOtros) = C1.IdCuenta
LEFT OUTER JOIN IBCondiciones ON cp.IdIBCondicion=IBCondiciones.IdIBCondicion
LEFT OUTER JOIN #Auxiliar ON cp.IdComprobanteProveedor=#Auxiliar.IdComprobanteProveedor
LEFT OUTER JOIN Obras ON cp.IdObra=Obras.IdObra
LEFT OUTER JOIN Empleados E1 ON cp.IdUsuarioIngreso=E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON cp.IdUsuarioModifico=E2.IdEmpleado
LEFT OUTER JOIN Localidades ON P1.IdLocalidad=Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias Prov1 ON P1.IdProvincia=Prov1.IdProvincia
LEFT OUTER JOIN Provincias Prov2 ON cp.IdProvinciaDestino=Prov2.IdProvincia
LEFT OUTER JOIN Paises ON P1.IdPais=Paises.IdPais
LEFT OUTER JOIN [Condiciones Compra] cc ON cp.IdCondicionCompra=cc.IdCondicionCompra
LEFT OUTER JOIN Monedas ON cp.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN DescripcionIva diva1 ON cp.IdCodigoIva = diva1.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva2 ON P1.IdCodigoIva = diva2.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva3 ON P2.IdCodigoIva = diva3.IdCodigoIva
LEFT OUTER JOIN OrdenesPago ON cp.IdOrdenPago = OrdenesPago.IdOrdenPago
WHERE (cp.IdComprobanteProveedor=@IdComprobanteProveedor)

DROP TABLE #Auxiliar
