CREATE Procedure [dbo].[Bancos_TX_ChequesDiferidosPendientesPorIdBanco]

@IdBanco Int,
@Formato varchar(20) = Null,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null

AS 

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'')
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,0)

DECLARE @ActivarCircuitoChequesDiferidos varchar(2)

SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos From Parametros Where IdParametro=1),'NO')

SET NOCOUNT OFF

IF @Formato=''
  BEGIN
	DECLARE @vector_X varchar(50),@vector_T varchar(50)
	SET @vector_X='01111111111111111111133'
	SET @vector_T='00924420240340242222500'
	
	SELECT
	 Valores.IdValor,
	 (Select top 1 TiposComprobante.DescripcionAb From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
	 Valores.IdValor as [IdVal],
	 Valores.NumeroInterno as [Nro.Int.],
	 Valores.NumeroValor as [Numero valor],
	 Valores.FechaValor as [Fecha valor],
	 Valores.Importe as [Importe],
	 Monedas.Abreviatura as [Mon.],
	 Valores.CotizacionMoneda as [Conv.a $],
	 Valores.FechaComprobante as [Fec.Comp.],
	 Case When Valores.Conciliado is null Then 'NO' Else Valores.Conciliado End as [Conc.],
	 Case When Valores.MovimientoConfirmadoBanco is null Then 'NO' Else Valores.MovimientoConfirmadoBanco End as [Confirmado],
	 Valores.FechaConfirmacionBanco as [Fecha conf.],
	 CuentasBancarias.Cuenta as [Cuenta],
	 Conciliaciones.Numero as [Nro.Extracto],
	 Conciliaciones.FechaIngreso as [Fec.Extracto],
	 tc.DescripcionAb as [Tipo Comp.],
	 Valores.NumeroComprobante as [Comp.],
	 Proveedores.RazonSocial as [Proveedor],
	 Valores.Detalle as [Detalle],
	 OrdenesPago.Observaciones as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM Valores 
	LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
	LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
	LEFT OUTER JOIN Conciliaciones ON Valores.IdConciliacion=Conciliaciones.IdConciliacion
	LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
	LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
	LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago=OrdenesPago.IdOrdenPago
	LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
	WHERE IsNull(Valores.Anulado,'NO')<>'SI' and 
		@ActivarCircuitoChequesDiferidos='SI' and 
		Valores.IdTipoValor=6 and 
		Valores.IdTipoComprobante=17 and 
		Valores.IdBanco=@IdBanco and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO'
	ORDER BY Valores.FechaValor, Valores.NumeroComprobante
  END

IF @Formato='REPORTE_FINANCIERO'
  BEGIN
	SELECT Valores.FechaValor, Sum(IsNull(Valores.Importe,0)) as [Importe]
	FROM Valores 
	LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
	LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
	WHERE IsNull(Valores.Anulado,'NO')<>'SI' and 
		@ActivarCircuitoChequesDiferidos='SI' and 
		Valores.IdTipoValor=6 and 
		Valores.IdTipoComprobante=17 and 
		(@IdBanco=-1 or Valores.IdBanco=@IdBanco) and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO' and 
		Valores.FechaValor between @FechaDesde and @FechaHasta
	GROUP BY Valores.FechaValor
	ORDER BY Valores.FechaValor
  END