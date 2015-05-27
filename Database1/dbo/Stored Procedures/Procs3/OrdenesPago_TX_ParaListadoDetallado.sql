CREATE PROCEDURE [dbo].[OrdenesPago_TX_ParaListadoDetallado]

@Desde datetime,
@Hasta datetime

AS

DECLARE @vector_X varchar(50), @vector_T varchar(50), @K_Orden int, @Imputacion varchar(30), @Importe numeric(18,2), @TipoValor varchar(10), 
		@CodigoCuentaBanco varchar(50), @ImporteValor numeric(18,2), @BancoCaja varchar(100), @NumeroInterno int, @NumeroValor numeric(18,0), 
		@FechaVencimiento datetime, @Cuenta varchar(50), @CodCta int, @Debe numeric(18,2), @Haber numeric(18,2)

SET @vector_X='011111111111116666666111111116611111611661133'
SET @vector_T='0299942211220233333335215FFF74423334321332200'

SET @K_Orden=1
SET @Imputacion=''
SET @Importe=0
SET @TipoValor=''
SET @CodigoCuentaBanco=''
SET @ImporteValor=0
SET @BancoCaja=''
SET @NumeroInterno=0
SET @NumeroValor=0
SET @FechaVencimiento=Null
SET @Cuenta=''
SET @CodCta=0
SET @Debe=0
SET @Haber=0

SELECT 
 op.IdOrdenPago, 
 op.NumeroOrdenPago as [Numero], 
 @K_Orden as [K_Orden], 
 op.FechaOrdenPago as [FechaOP], 
 op.NumeroOrdenPago as [NumeroOP], 
 op.FechaOrdenPago as [Fecha Pago], 
 Case When op.Tipo='CC' Then 'Cta. cte.' When op.Tipo='FF' Then 'F. fijo' When op.Tipo='OT' Then 'Otros' Else '' End as [Tipo OP],
 Case When op.Anulada='SI' 
	Then 'Anulada'
	Else Case When op.Tipo='CC' 
			Then Case When op.Estado='CA' Then 'En caja' When op.Estado='FI' Then 'A la firma' When op.Estado='EN' Then 'Entregado' Else ''	End
			Else ''
		 End
 End as [Estado],
 Proveedores.RazonSocial as [Proveedor],
 Proveedores.CodigoEmpresa as [Cod.Prov.],
 Cuentas.Descripcion as [Cuenta contable],
 Cuentas.Codigo as [Cod.Cta.],
 Monedas.Abreviatura as [Mon.],
 Obras.NumeroObra as [Obra],
 Case When op.Valores=0 Then Null Else op.Valores End as [Valores],
 Case When op.Descuentos=0 Then Null Else op.Descuentos End as [Descuentos],
 op.RetencionIVA as [Ret.IVA],
 op.RetencionGanancias as [Ret.gan.],
 op.RetencionIBrutos as [Ret.ing.b.],
 op.RetencionSUSS as [Ret.SUSS],
 op.GastosGenerales as [Dev.F.F.],
 (Select Top 1 OrdenesPago.NumeroOrdenPago From OrdenesPago Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF) as [OP complem. FF],
 op.CotizacionDolar as [Cotiz. dolar],
 Empleados.Nombre as [Destinatario FF],
 op.Observaciones as [Observaciones],
 op.TextoAuxiliar1 as [Modalidad],
 op.TextoAuxiliar2 as [Enviar a],
 op.TextoAuxiliar3 as [Auxiliar],

 @Imputacion as [Imputacion cta. cte.],
 @Importe as [Importe],
 @Importe as [Imp.s/impuestos],

 @TipoValor as [Tipo],
 /*@CodigoCuentaBanco as [Cod.cta.banco],*/
 @BancoCaja as [Banco / Caja],
 @NumeroInterno as [Nro.interno],
 @NumeroValor as [Nro.valor],
 @FechaVencimiento as [Fecha vto.],
 @ImporteValor as [Importe valor],

 @Cuenta as [Cuenta],
 @CodCta as [Cod.],
 @Debe as [Debe],
 @Haber as [Haber],

 C1.Descripcion as [Concepto OP otros],
 C2.Descripcion as [Clasificacion s/canc.],

 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Empleados ON op.IdEmpleadoFF = Empleados.IdEmpleado
LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Conceptos C1 ON op.IdConcepto = C1.IdConcepto
LEFT OUTER JOIN Conceptos C2 ON op.IdConcepto2 = C2.IdConcepto
LEFT OUTER JOIN Obras ON op.IdObra = Obras.IdObra
WHERE op.FechaOrdenPago between @Desde and @hasta and IsNull(op.Confirmado,'')<>'NO'
ORDER BY op.FechaOrdenPago,op.NumeroOrdenPago