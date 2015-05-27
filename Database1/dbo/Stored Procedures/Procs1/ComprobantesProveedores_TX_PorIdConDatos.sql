CREATE Procedure [dbo].[ComprobantesProveedores_TX_PorIdConDatos]

@IdComprobanteProveedor int

AS 

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdCtaAdicCol1 int, @IdCtaAdicCol2 int, @IdCtaAdicCol3 int, @IdCtaAdicCol4 int, @IdCtaAdicCol5 int, @ConPresupuestadorDeObra varchar(2), 
	@IdDetallePedido int, @IdPedido int, @DetalleCondicionCompra varchar(200)

SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)

SET @IdDetallePedido=IsNull((Select Top 1 IdDetallePedido From DetalleComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor and IsNull(IdDetallePedido,0)>0),0)
IF @IdDetallePedido=0
	SET @IdPedido=IsNull((Select Top 1 IdPedido From DetalleComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor and IsNull(IdPedido,0)>0),0)
ELSE
	SET @IdPedido=IsNull((Select Top 1 IdPedido From DetallePedidos Where IdDetallePedido=@IdDetallePedido),0)

SET @DetalleCondicionCompra=IsNull((Select Top 1 DetalleCondicionCompra From Pedidos Where IdPedido=@IdPedido),'')

SET @ConPresupuestadorDeObra=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Presupuestador de obra nuevo' and IsNull(ProntoIni.Valor,'')='SI'),'')

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

CREATE TABLE #Auxiliar2 
			(
			 IdDetalleComprobanteProveedor INTEGER,
			 PresupuestoObrasNodo VARCHAR(3)
			)
IF @ConPresupuestadorDeObra='SI'
	INSERT INTO #Auxiliar2 
	 SELECT dcp.IdDetalleComprobanteProveedor, 
		Case When Exists(Select Top 1 p.IdObra From PresupuestoObrasNodos p Where p.IdObra=dcp.IdObra) and 
				IsNull(Cuentas.ImputarAPresupuestoDeObra,'')='SI' and (IsNull(dcp.IdArticulo,0)=0 or IsNull(Articulos.RegistrarStock,'SI')='NO') 
			Then Case When IsNull(dcp.IdPresupuestoObrasNodo,0)<>0 Then 'OK' Else 'ERR' End 
			Else 'NO' 
		End
	 FROM DetalleComprobantesProveedores dcp 
	 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta=Cuentas.IdCuenta
	 LEFT OUTER JOIN Articulos ON dcp.IdArticulo=Articulos.IdArticulo
	 LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo=dcp.IdPresupuestoObrasNodo
	 WHERE dcp.IdComprobanteProveedor=@IdComprobanteProveedor

SET NOCOUNT OFF

SELECT 
 cp.*,
 Case When Proveedores.IBCondicion is not null and Proveedores.IBCondicion=2
	Then (Select Top 1 dpib.AlicuotaAAplicar From DetalleProveedoresIB dpib Where dpib.IdProveedor=cp.IdProveedor and dpib.IdIBCondicion=cp.IdIBCondicion)
	Else Null
 End as [Alicuota Conv.Mul.],
 (Select Sum(dcp.Importe) From DetalleComprobantesProveedores dcp
  Where dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor and dcp.TomarEnCalculoDeImpuestos is not null and dcp.TomarEnCalculoDeImpuestos='NO') as [RestarAlBruto],
 IsNull(#Auxiliar.GravadoIVA,0) as [GravadoIVA],
 (Select Sum(IsNull(cp1.TotalIva1,0)*IsNull(cp1.CotizacionMoneda,0)) From ComprobantesProveedores cp1 Where cp1.IdComprobanteImputado=cp.IdComprobanteProveedor) as [IvaCreditos],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 E1.Nombre as [Ingreso],
 Proveedores.RazonSocial as [Proveedor], 
 IsNull(Proveedores.Direccion,'')+IsNull(' '+Localidades.Nombre,'')+IsNull(' '+Proveedores.CodigoPostal,'')+IsNull(' '+Provincias.Nombre,'') as [Domicilio],
 Proveedores.Cuit as [Cuit], 
 cc.Descripcion as [CondicionCompra],
 cp.Letra as [Letra],
 Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [NumeroCP],
 Monedas.Abreviatura as [Moneda],
 IsNull((Select Sum(IsNull(CtaCte.Saldo,0)) From CuentasCorrientesAcreedores CtaCte
	 Left Outer Join TiposComprobante tc On tc.IdTipoComprobante=CtaCte.IdTipoComp
	 Where CtaCte.IdProveedor=cp.IdProveedor and tc.Coeficiente=-1),0) as [AnticiposAAplicar],
 (Select Top 1 E.Nombre+' '+Convert(varchar,ac.FechaAutorizacion,103) From AutorizacionesPorComprobante ac 
  Left Outer Join Empleados E On E.IdEmpleado=ac.IdAutorizo
  Where ac.IdFormulario=31 and ac.IdComprobante=cp.IdComprobanteProveedor
  Order By ac.OrdenAutorizacion Desc) as [UltimoFirmante],
 IsNull(ImpuestosDirectos.Tasa,0) as [PorcentajeRetencionIVA],
 Polizas.Certificado as [PolizaCertificado],
 Polizas.NumeroEndoso as [PolizasNumeroEndoso],
 IsNull((Select Top 1 #Auxiliar2.PresupuestoObrasNodo From #Auxiliar2 Where IsNull(#Auxiliar2.PresupuestoObrasNodo,'')='ERR'),'') as [PresupuestoObraConError],
 @DetalleCondicionCompra as [DetalleCondicionCompra]
FROM ComprobantesProveedores cp 
LEFT OUTER JOIN Proveedores ON cp.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN IBCondiciones ON cp.IdIBCondicion=IBCondiciones.IdIBCondicion
LEFT OUTER JOIN #Auxiliar ON cp.IdComprobanteProveedor=#Auxiliar.IdComprobanteProveedor
LEFT OUTER JOIN Obras ON cp.IdObra=Obras.IdObra
LEFT OUTER JOIN Empleados E1 ON cp.IdUsuarioIngreso=E1.IdEmpleado
LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad=Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia=Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Proveedores.IdPais=Paises.IdPais
LEFT OUTER JOIN [Condiciones Compra] cc ON Proveedores.IdCondicionCompra=cc.IdCondicionCompra
LEFT OUTER JOIN Monedas ON cp.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN ImpuestosDirectos ON ImpuestosDirectos.IdImpuestoDirecto = cp.IdImpuestoDirecto
LEFT OUTER JOIN Polizas ON cp.IdPoliza=Polizas.IdPoliza
WHERE (cp.IdComprobanteProveedor=@IdComprobanteProveedor)

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar2