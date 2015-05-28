
CREATE Procedure [dbo].[Bancos_TX_InformeChequesAnulados]

@FechaDesde datetime, 
@FechaHasta datetime,
@IdBanco Int

AS 

SET NOCOUNT ON
DECLARE @ActivarCircuitoChequesDiferidos varchar(2)
SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos  
						From Parametros	Where IdParametro=1),'NO')
SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111111133'
SET @vector_T='009222442024034024222244400'

SELECT
 Valores.IdValor,
 (Select top 1 TiposComprobante.DescripcionAb
  From TiposComprobante 
  Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
 Valores.IdValor as [IdVal],
 Bancos.Nombre as [Banco],
 BancoChequeras.NumeroChequera as [Chequera],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.NumeroValor as [Numero valor],
 Valores.FechaValor as [Fecha valor],
 Valores.Importe as [Importe],
 Monedas.Abreviatura as [Mon.],
 Valores.CotizacionMoneda as [Conv.a $],
 Valores.FechaComprobante as [Fec.Comp.],
 Case When Valores.Conciliado is null 
	Then 'NO' 
	Else Valores.Conciliado 
 End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null 
	Then 'NO' 
	Else Valores.MovimientoConfirmadoBanco 
 End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 CuentasBancarias.Cuenta as [Cuenta],
 Conciliaciones.Numero as [Nro.Extracto],
 Conciliaciones.FechaIngreso as [Fec.Extracto],
 tc.DescripcionAb as [Tipo Comp.],
 Valores.NumeroComprobante as [Comp.],
 Proveedores.RazonSocial as [Proveedor],
 Valores.Detalle as [Detalle],
 Empleados.Nombre as [Anulo],
 Valores.FechaAnulacion as [Fecha anul.],
 Valores.MotivoAnulacion as [Motivo anulacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
LEFT OUTER JOIN Conciliaciones ON Valores.IdConciliacion=Conciliaciones.IdConciliacion
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago = OrdenesPago.IdOrdenPago
LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
LEFT OUTER JOIN Bancos ON BancoChequeras.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN Empleados ON Valores.IdUsuarioAnulo=Empleados.IdEmpleado
WHERE Valores.FechaComprobante between @FechaDesde and @FechaHasta and 
	IsNull(Valores.Anulado,'NO')='SI' and 
	Valores.IdTipoValor=6 and 
	Valores.IdTipoComprobante=17 and 
	(@IdBanco=-1 or Valores.IdBanco=@IdBanco)
ORDER BY [Fec.Comp.],Valores.NumeroComprobante
