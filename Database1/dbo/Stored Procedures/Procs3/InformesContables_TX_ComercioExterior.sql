CREATE  Procedure [dbo].[InformesContables_TX_ComercioExterior]

@FechaDesde datetime,
@FechaHasta datetime

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111133'
SET @vector_T='01462022411144300'

SELECT 
 Facturas.IdFactura as [IdAux], 
 'VENTA' as [Tipo],
 Facturas.FechaFactura as [Fecha], 
 Substring(Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),1,20) as [Numero],
 Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS as [Cliente / Proveedor], 
 Monedas.Abreviatura as [Mon.],
 Facturas.Exportacion_FOB as [Valor FOB], 
 Facturas.CotizacionMoneda as [Cot.Mon.], 
 Facturas.Exportacion_PosicionAduana as [Posicion aduana], 
 Facturas.Exportacion_Despacho as [Despacho], 
 Facturas.Exportacion_Guia as [Guia], 
 Paises.Descripcion as [Pais],
 Facturas.Exportacion_FechaEmbarque as [Fecha emb.], 
 Facturas.Exportacion_FechaOficializacion as [Fecha ofic.], 
 (Select Top 1 IsNull(Bancos.Nombre,Cajas.Descripcion)
  From DetalleRecibosValores Det
  Left Outer Join Bancos On Bancos.IdBanco=Det.IdBanco
  Left Outer Join Cajas On Cajas.IdCaja=Det.IdCaja
  Where (Det.IdBanco is not null or Det.IdCaja is not null) and 
	Det.IdRecibo=(Select Top 1 Cta.IdComprobante From CuentasCorrientesDeudores Cta 
			Where Cta.IdTipoComp=2 and Cta.IdImputacion=(Select Top 1 Cta1.IdImputacion From CuentasCorrientesDeudores Cta1 Where Cta1.IdTipoComp=1 and Cta1.IdComprobante=Facturas.IdFactura))) as [Entidad interviniente],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Facturas 
LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Monedas ON Facturas.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Paises ON Facturas.Exportacion_IdPaisDestino = Paises.IdPais
WHERE Facturas.TipoABC='E' and (Facturas.FechaFactura between @FechaDesde and @FechaHasta)

UNION ALL 

SELECT 
 dcp.IdDetalleComprobanteProveedor as [IdAux], 
 'COMPRA' as [Tipo],
 cp.FechaComprobante as [Fecha], 
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],
 Proveedores.RazonSocial COLLATE Modern_Spanish_CI_AS as [Cliente / Proveedor], 
 Monedas.Abreviatura as [Mon.],
 dcp.Importacion_FOB as [Valor FOB], 
 cp.CotizacionMoneda as [Cot.Mon.], 
 dcp.Importacion_PosicionAduana as [Posicion aduana], 
 dcp.Importacion_Despacho as [Despacho], 
 dcp.Importacion_Guia as [Guia], 
 Paises.Descripcion as [Pais],
 dcp.Importacion_FechaEmbarque as [Fecha emb.], 
 dcp.Importacion_FechaOficializacion as [Fecha ofic.], 
 (Select Top 1 Bancos.Nombre
  From DetalleOrdenesPagoValores Det
  Left Outer Join Bancos On Bancos.IdBanco=Det.IdBanco
  Where Det.IdBanco is not null and 
	Det.IdOrdenPago=(Select Top 1 Cta.IdComprobante 
			 From CuentasCorrientesAcreedores Cta 
			 Where Cta.IdTipoComp=17 and 
				Cta.IdImputacion=(Select Top 1 Cta1.IdImputacion From CuentasCorrientesAcreedores Cta1 
						  Where Cta1.IdTipoComp=cp.IdTipoComprobante and Cta1.IdComprobante=cp.IdComprobanteProveedor))) as [Entidad interviniente],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleComprobantesProveedores dcp 
LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Monedas ON cp.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Paises ON dcp.Importacion_IdPaisOrigen = Paises.IdPais
WHERE cp.Letra='E' and (cp.FechaComprobante between @FechaDesde and @FechaHasta)

ORDER BY [Fecha], [Numero]