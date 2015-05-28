CREATE PROCEDURE [dbo].[OrdenesPago_TX_AcumuladoParaIIBB]

@IdOrdenPago int,
@Fecha datetime,
@IdProveedor int,
@BaseCalculo varchar(15)

AS

DECLARE @ImporteBaseIIBB Numeric(18,2)

IF @BaseCalculo='SIN IMPUESTOS'
  SET @ImporteBaseIIBB = Isnull((Select Sum(Case When dop.ImportePagadoSinImpuestos is not null Then dop.ImportePagadoSinImpuestos Else dop.Importe End) 
				 From DetalleOrdenesPago dop
				 Left Outer Join OrdenesPago op On op.IdOrdenPago=dop.IdOrdenPago
				 Left Outer Join CuentasCorrientesAcreedores ON CuentasCorrientesAcreedores.IdCtaCte=dop.IdImputacion
				 Left Outer Join TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesAcreedores.IdTipoComp
				 Left Outer Join ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CuentasCorrientesAcreedores.IdComprobante
				 Left Outer Join IBCondiciones ON cp.IdIBCondicion=IBCondiciones.IdIBCondicion
				 Where dop.IdOrdenPago<>@IdOrdenPago and op.IdProveedor=@IdProveedor and 
					(op.Anulada is null or op.Anulada<>'SI') and 
					Year(op.FechaOrdenPago)=Year(@Fecha) and Month(op.FechaOrdenPago)=Month(@Fecha) and 
					(IBCondiciones.AcumulaMensualmente is null or IBCondiciones.AcumulaMensualmente='NO')),0)
ELSE
  SET @ImporteBaseIIBB = Isnull((Select Sum(dop.Importe) 
				 From DetalleOrdenesPago dop
				 Left Outer Join OrdenesPago op On op.IdOrdenPago=dop.IdOrdenPago
				 Left Outer Join CuentasCorrientesAcreedores ON CuentasCorrientesAcreedores.IdCtaCte=dop.IdImputacion
				 Left Outer Join TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesAcreedores.IdTipoComp
				 Left Outer Join ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CuentasCorrientesAcreedores.IdComprobante
				 Left Outer Join IBCondiciones ON cp.IdIBCondicion=IBCondiciones.IdIBCondicion
				 Where dop.IdOrdenPago<>@IdOrdenPago and op.IdProveedor=@IdProveedor and 
					(op.Anulada is null or op.Anulada<>'SI') and 
					Year(op.FechaOrdenPago)=Year(@Fecha) and Month(op.FechaOrdenPago)=Month(@Fecha) and 
					(IBCondiciones.AcumulaMensualmente is not null and IBCondiciones.AcumulaMensualmente='SI')),0)

SELECT @ImporteBaseIIBB as [ImporteBaseIIBB]