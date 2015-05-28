CREATE Procedure [dbo].[CuboDeVentasDetalladas]

@Desde datetime,
@Hasta datetime,
@IncluirAsientos int,
@Dts varchar(200)

AS 

SET NOCOUNT ON

TRUNCATE TABLE _TempVentasParaCubo

INSERT INTO _TempVentasParaCubo 
 SELECT 
  Clientes.Codigo,
  Substring(IsNull(Clientes.RazonSocial,''),1,50),
  DescripcionIva.Descripcion,
  Facturas.FechaFactura,
  Vendedores.Nombre,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  IsNull(UnidadesOperativas.Descripcion,'Sin Unidad'),
  Case When Facturas.TipoABC='B' and IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8 
	Then Round(((df.Cantidad*df.PrecioUnitario)*(1-(IsNull(df.Bonificacion,0)/100))*(1-(IsNull(Facturas.PorcentajeBonificacion,0)/100))) / (1+(Facturas.PorcentajeIva1/100)) * IsNull(Facturas.CotizacionMoneda,1) * IsNull(dfp.Porcentaje,100) / 100 ,2)
	Else Round(((df.Cantidad*df.PrecioUnitario)*(1-(IsNull(df.Bonificacion,0)/100))*(1-(IsNull(Facturas.PorcentajeBonificacion,0)/100))) * IsNull(Facturas.CotizacionMoneda,1) * IsNull(dfp.Porcentaje,100) / 100 ,2)
  End,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Convert(varchar,Facturas.FechaFactura,103)+' '+'FAC '+Facturas.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,'')
 FROM DetalleFacturasOrdenesCompra dfoc
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN DetalleFacturas df ON df.IdDetalleFactura = dfoc.IdDetalleFactura
 LEFT OUTER JOIN Facturas ON dfoc.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN Vendedores ON Facturas.IdVendedor = Vendedores.IdVendedor
 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 LEFT OUTER JOIN Articulos ON df.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=dfoc.IdFactura
 LEFT OUTER JOIN Provincias ON IsNull(dfp.IdProvinciaDestino,Clientes.IdProvincia) = Provincias.IdProvincia
 WHERE (Facturas.FechaFactura between @Desde and @hasta) and IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO _TempVentasParaCubo 
 SELECT 
  Clientes.Codigo,
  Substring(IsNull(Clientes.RazonSocial,''),1,50),
  DescripcionIva.Descripcion,
  Facturas.FechaFactura,
  Vendedores.Nombre,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  IsNull(UnidadesOperativas.Descripcion,'Sin Unidad'),
  Case When Facturas.TipoABC='B' and IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8 
	Then Round(((df.Cantidad*df.PrecioUnitario)*(1-(IsNull(df.Bonificacion,0)/100))*(1-(IsNull(Facturas.PorcentajeBonificacion,0)/100))) / (1+(Facturas.PorcentajeIva1/100)) * IsNull(Facturas.CotizacionMoneda,1) * IsNull(dfp.Porcentaje,100) / 100 ,2)
	Else Round(((df.Cantidad*df.PrecioUnitario)*(1-(IsNull(df.Bonificacion,0)/100))*(1-(IsNull(Facturas.PorcentajeBonificacion,0)/100))) * IsNull(Facturas.CotizacionMoneda,1) * IsNull(dfp.Porcentaje,100) / 100 ,2)
  End,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Convert(varchar,Facturas.FechaFactura,103)+' '+'FAC '+Facturas.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,'')
 FROM DetalleFacturas df
 LEFT OUTER JOIN Facturas ON df.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN Vendedores ON Facturas.IdVendedor = Vendedores.IdVendedor
 LEFT OUTER JOIN Articulos ON df.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN Obras ON Facturas.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=df.IdFactura
 LEFT OUTER JOIN Provincias ON IsNull(dfp.IdProvinciaDestino,Clientes.IdProvincia) = Provincias.IdProvincia
 WHERE (Facturas.FechaFactura between @Desde and @hasta) and IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI' and 
	not exists(Select Top 1 dfoc.IdDetalleFactura From DetalleFacturasOrdenesCompra dfoc Where dfoc.IdDetalleFactura=df.IdDetalleFactura)

INSERT INTO _TempVentasParaCubo 
 SELECT 
  Clientes.Codigo,
  Substring(IsNull(Clientes.RazonSocial,''),1,50),
  DescripcionIva.Descripcion,
  Devoluciones.FechaDevolucion,
  Vendedores.Nombre,  
  IsNull(Obras.NumeroObra,'Sin Obra'),
  IsNull(UnidadesOperativas.Descripcion,'Sin Unidad'),
  Case When Devoluciones.TipoABC='B' and IsNull(Devoluciones.IdCodigoIva,Clientes.IdCodigoIva)<>8 
	Then Round(((dv.Cantidad*dv.PrecioUnitario)*(1-(IsNull(dv.Bonificacion,0)/100))*(1-(IsNull(Devoluciones.PorcentajeBonificacion,0)/100))) / (1+(Devoluciones.PorcentajeIva1/100)) * IsNull(Devoluciones.CotizacionMoneda,1),2) * -1
	Else Round(((dv.Cantidad*dv.PrecioUnitario)*(1-(IsNull(dv.Bonificacion,0)/100))*(1-(IsNull(Devoluciones.PorcentajeBonificacion,0)/100))) * IsNull(Devoluciones.CotizacionMoneda,1),2) * -1
  End,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Convert(varchar,Devoluciones.FechaDevolucion,103)+' '+'DEV '+Devoluciones.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,'') FROM DetalleDevoluciones dv
 LEFT OUTER JOIN Devoluciones ON dv.IdDevolucion = Devoluciones.IdDevolucion
 LEFT OUTER JOIN Clientes ON Devoluciones.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN Vendedores ON Devoluciones.IdVendedor = Vendedores.IdVendedor
 LEFT OUTER JOIN Obras ON IsNull(dv.IdObra,Devoluciones.IdObra) = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 LEFT OUTER JOIN Articulos ON dv.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN Provincias ON Clientes.IdProvincia = Provincias.IdProvincia
 WHERE (Devoluciones.FechaDevolucion between @Desde and @hasta) and IsNull(Devoluciones.Anulada,'NO')<>'SI'

INSERT INTO _TempVentasParaCubo 
 SELECT 
  Clientes.Codigo,
  Substring(IsNull(Clientes.RazonSocial,''),1,50),
  DescripcionIva.Descripcion,
  NotasDebito.FechaNotaDebito,
  Vendedores.Nombre,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  IsNull(UnidadesOperativas.Descripcion,'Sin Unidad'),
  Case When NotasDebito.TipoABC='B' AND IsNull(NotasDebito.IdCodigoIva,Clientes.IdCodigoIva)<>8  
	Then Round(Case When dnb.Gravado='SI' Then IsNull(dnb.Importe,0) / (1+(NotasDebito.PorcentajeIva1/100)) Else IsNull(dnb.Importe,0) End * IsNull(NotasDebito.CotizacionMoneda,1) * IsNull(dndp.Porcentaje,100) / 100 ,2)
	Else Round(IsNull(dnb.Importe,0) * IsNull(NotasDebito.CotizacionMoneda,1) * IsNull(dndp.Porcentaje,100) / 100 ,2)
  End,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Convert(varchar,NotasDebito.FechaNotaDebito,103)+' '+'DEB '+NotasDebito.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,'')
 FROM DetalleNotasDebito dnb
 LEFT OUTER JOIN NotasDebito ON dnb.IdNotaDebito = NotasDebito.IdNotaDebito
 LEFT OUTER JOIN Clientes ON NotasDebito.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN Vendedores ON NotasDebito.IdVendedor = Vendedores.IdVendedor
 LEFT OUTER JOIN Obras ON NotasDebito.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 LEFT OUTER JOIN Conceptos ON dnb.IdConcepto = Conceptos.IdConcepto
 LEFT OUTER JOIN Cuentas ON Conceptos.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN DetalleNotasDebitoProvincias dndp ON dndp.IdNotaDebito=NotasDebito.IdNotaDebito
 LEFT OUTER JOIN Provincias ON IsNull(dndp.IdProvinciaDestino,Clientes.IdProvincia) = Provincias.IdProvincia
 WHERE (NotasDebito.FechaNotaDebito between @Desde and @hasta) and IsNull(NotasDebito.Anulada,'NO')<>'SI' and 
	IsNull(NotasDebito.CtaCte,'SI')='SI' and IsNull(NotasDebito.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO _TempVentasParaCubo 
 SELECT 
  Clientes.Codigo,
  Substring(IsNull(Clientes.RazonSocial,''),1,50),
  DescripcionIva.Descripcion,
  NotasCredito.FechaNotaCredito,
  Vendedores.Nombre,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  IsNull(UnidadesOperativas.Descripcion,'Sin Unidad'),
  Case When NotasCredito.TipoABC='B' AND IsNull(NotasCredito.IdCodigoIva,Clientes.IdCodigoIva)<>8  
	Then Round(Case When  dnc.Gravado='SI' Then IsNull(dnc.Importe,0) / (1+(NotasCredito.PorcentajeIva1/100)) Else IsNull(dnc.Importe,0) End * IsNull(NotasCredito.CotizacionMoneda,1) * IsNull(dncp.Porcentaje,100) / 100 ,2)
	Else Round(IsNull(dnc.Importe,0) * IsNull(NotasCredito.CotizacionMoneda,1) * IsNull(dncp.Porcentaje,100) / 100 ,2)
  End * -1,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Convert(varchar,NotasCredito.FechaNotaCredito,103)+' '+'CRE '+NotasCredito.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)+' - '+
	'Cliente : '+IsNull(Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS,'')
 FROM DetalleNotasCredito dnc
 LEFT OUTER JOIN NotasCredito ON dnc.IdNotaCredito = NotasCredito.IdNotaCredito
 LEFT OUTER JOIN Clientes ON NotasCredito.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva  LEFT OUTER JOIN Vendedores ON NotasCredito.IdVendedor = Vendedores.IdVendedor
 LEFT OUTER JOIN Obras ON NotasCredito.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 LEFT OUTER JOIN Conceptos ON dnc.IdConcepto = Conceptos.IdConcepto
 LEFT OUTER JOIN Cuentas ON Conceptos.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN DetalleNotasCreditoProvincias dncp ON dncp.IdNotaCredito=NotasCredito.IdNotaCredito
 LEFT OUTER JOIN Provincias ON IsNull(dncp.IdProvinciaDestino,Clientes.IdProvincia) = Provincias.IdProvincia
 WHERE (NotasCredito.FechaNotaCredito between @Desde and @hasta) and IsNull(NotasCredito.Anulada,'NO')<>'SI' and 
	IsNull(NotasCredito.CtaCte,'SI')='SI' and IsNull(NotasCredito.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO _TempVentasParaCubo 
 SELECT 
  Null,
  'Provision',
  Null,
  Asientos.FechaAsiento,
  Null,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  IsNull(UnidadesOperativas.Descripcion,'Sin Unidad'),
  Case When DetAsi.Debe is not null and DetAsi.Haber is null Then DetAsi.Debe * -1
		When DetAsi.Debe is null and DetAsi.Haber is not null Then DetAsi.Haber
		When DetAsi.Debe is not null and DetAsi.Haber is not null Then (DetAsi.Debe - DetAsi.Haber) * -1
		Else 0
  End,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Convert(varchar,Asientos.FechaAsiento,103)+' '+'ASI '+Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento)
 FROM DetalleAsientos DetAsi 
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
 LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN Obras ON DetAsi.IdObra=Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=DetAsi.IdProvinciaDestino
 WHERE (Asientos.FechaAsiento between @Desde and @Hasta) and @IncluirAsientos=-1 and Cuentas.Codigo between 4000 and 4999

SET NOCOUNT OFF

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts