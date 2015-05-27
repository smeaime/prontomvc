CREATE Procedure [dbo].[CuboDeVentas]

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
  Clientes.RazonSocial,
  DescripcionIva.Descripcion,
  Facturas.FechaFactura,
  Vendedores.Nombre,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  UnidadesOperativas.Descripcion,
  CASE WHEN Facturas.CotizacionMoneda is not null
	THEN
	 CASE 	WHEN Facturas.TipoABC='B' AND IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8  
		 THEN ROUND(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / 
				(1+(Facturas.PorcentajeIva1/100)) * Facturas.CotizacionMoneda * 
				IsNull(dfp.Porcentaje,100) / 100 ,2)
		 ELSE ROUND(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * 
				Facturas.CotizacionMoneda * IsNull(dfp.Porcentaje,100) / 100 ,2)
	 END
	ELSE 
	 CASE 	WHEN Facturas.TipoABC='B' AND IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8  
		 THEN ROUND(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / 
				(1+(Facturas.PorcentajeIva1/100)) * 
				IsNull(dfp.Porcentaje,100) / 100 ,2)
		 ELSE ROUND(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * 
				IsNull(dfp.Porcentaje,100) / 100 ,2)
	 END
  END,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Null
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
 LEFT OUTER JOIN Provincias ON dfp.IdProvinciaDestino = Provincias.IdProvincia
 WHERE (Facturas.FechaFactura between @Desde and @hasta) and 
	IsNull(Facturas.Anulada,'NO')<>'SI' and 
	IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI'

UNION ALL

 SELECT 
  Clientes.Codigo,
  Clientes.RazonSocial,
  DescripcionIva.Descripcion,
  Facturas.FechaFactura,
  Vendedores.Nombre,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  CASE WHEN UnidadesOperativas.Descripcion is not null THEN UnidadesOperativas.Descripcion ELSE 'Sin Unidad' END,
  CASE WHEN Facturas.CotizacionMoneda is not null
	THEN
	 CASE 	WHEN Facturas.TipoABC='B' AND IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8  
		 THEN ROUND(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / 
				(1+(Facturas.PorcentajeIva1/100)) * Facturas.CotizacionMoneda * 
				IsNull(dfp.Porcentaje,100) / 100 ,2)
		 ELSE ROUND(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * 
				Facturas.CotizacionMoneda * IsNull(dfp.Porcentaje,100) / 100 ,2)
	 END
	ELSE 
	 CASE 	WHEN Facturas.TipoABC='B' AND IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8  
		 THEN ROUND(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / 
				(1+(Facturas.PorcentajeIva1/100)) * IsNull(dfp.Porcentaje,100) / 100 ,2)
		 ELSE ROUND(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * 
				IsNull(dfp.Porcentaje,100) / 100 ,2)
	 END
  END,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Null
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
 LEFT OUTER JOIN Provincias ON dfp.IdProvinciaDestino = Provincias.IdProvincia
 WHERE (Facturas.FechaFactura between @Desde and @hasta) and 
	IsNull(Facturas.Anulada,'NO')<>'SI' and 
	IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI' and 
	not exists(Select Top 1 dfoc.IdDetalleFactura
			From DetalleFacturasOrdenesCompra dfoc
			Where dfoc.IdDetalleFactura=df.IdDetalleFactura)

UNION ALL

 SELECT 
  Clientes.Codigo,
  Clientes.RazonSocial,
  DescripcionIva.Descripcion,
  Devoluciones.FechaDevolucion,
  Vendedores.Nombre,  CASE 	WHEN dv.IdObra is not null
	 THEN (Select Top 1 Obras.NumeroObra From Obras
		Where dv.IdObra=Obras.IdObra)
	WHEN Devoluciones.IdObra is not null
	 THEN (Select Top 1 Obras.NumeroObra From Obras
		Where Devoluciones.IdObra=Obras.IdObra)
	ELSE 'Sin Obra'
  END,
  CASE 	WHEN dv.IdObra is not null
	 THEN (Select Top 1 UnidadesOperativas.Descripcion From UnidadesOperativas
		Where (Select Top 1 Obras.IdUnidadOperativa From Obras
			Where dv.IdObra=Obras.IdObra)=UnidadesOperativas.IdUnidadOperativa)
	WHEN Devoluciones.IdObra is not null
	 THEN (Select Top 1 UnidadesOperativas.Descripcion From UnidadesOperativas
		Where (Select Top 1 Obras.IdUnidadOperativa From Obras
			Where Devoluciones.IdObra=Obras.IdObra)=UnidadesOperativas.IdUnidadOperativa)
	ELSE 'Sin Unidad'
  END,
  CASE WHEN Devoluciones.CotizacionMoneda is not null
	THEN
	 CASE 	WHEN Devoluciones.TipoABC='B' AND IsNull(Devoluciones.IdCodigoIva,Clientes.IdCodigoIva)<>8  
		 THEN ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) / 
			(1+(Devoluciones.PorcentajeIva1/100)) * Devoluciones.CotizacionMoneda * -1
		 ELSE ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) * 
			Devoluciones.CotizacionMoneda * -1
	 END
	ELSE 
	 CASE 	WHEN Devoluciones.TipoABC='B' AND IsNull(Devoluciones.IdCodigoIva,Clientes.IdCodigoIva)<>8   
		 THEN ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) / 
			(1+(Devoluciones.PorcentajeIva1/100)) * -1
		 ELSE ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) * -1
	 END
  END,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Null
 FROM DetalleDevoluciones dv
 LEFT OUTER JOIN Devoluciones ON dv.IdDevolucion = Devoluciones.IdDevolucion
 LEFT OUTER JOIN Clientes ON Devoluciones.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN Vendedores ON Devoluciones.IdVendedor = Vendedores.IdVendedor
 LEFT OUTER JOIN Obras ON dv.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 LEFT OUTER JOIN Articulos ON dv.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 LEFT OUTER JOIN Cuentas ON Rubros.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN Provincias ON Devoluciones.IdProvinciaDestino = Provincias.IdProvincia
 WHERE (Devoluciones.FechaDevolucion between @Desde and @hasta) and 
	(Devoluciones.Anulada is null or Devoluciones.Anulada<>'SI')

UNION ALL

 SELECT 
  Clientes.Codigo,
  Clientes.RazonSocial,
  DescripcionIva.Descripcion,
  NotasDebito.FechaNotaDebito,
  Vendedores.Nombre,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  CASE WHEN UnidadesOperativas.Descripcion IS NOT NULL
	THEN UnidadesOperativas.Descripcion
	ELSE 'Sin Unidad'
  END,
  CASE 	WHEN NotasDebito.TipoABC='B' AND IsNull(NotasDebito.IdCodigoIva,Clientes.IdCodigoIva)<>8   
	 THEN 	ROUND(
		Case When  dnb.Gravado='SI' 
			Then IsNull(dnb.Importe,0) / (1+(NotasDebito.PorcentajeIva1/100))
			Else IsNull(dnb.Importe,0)
		End  * IsNull(NotasDebito.CotizacionMoneda,1) * IsNull(dndp.Porcentaje,100) / 100 ,2)
	 ELSE 	ROUND(IsNull(dnb.Importe,0) * IsNull(NotasDebito.CotizacionMoneda,1) * 
			IsNull(dndp.Porcentaje,100) / 100 ,2)
  END,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Null
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
 LEFT OUTER JOIN Provincias ON dndp.IdProvinciaDestino = Provincias.IdProvincia
 WHERE (NotasDebito.FechaNotaDebito between @Desde and @hasta) and 
	IsNull(NotasDebito.Anulada,'NO')<>'SI' and 
	IsNull(NotasDebito.CtaCte,'SI')='SI' and 
	IsNull(NotasDebito.NoIncluirEnCubos,'NO')<>'SI'

UNION ALL

 SELECT 
  Clientes.Codigo,
  Clientes.RazonSocial,
  DescripcionIva.Descripcion,
  NotasCredito.FechaNotaCredito,
  Vendedores.Nombre,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  CASE WHEN UnidadesOperativas.Descripcion IS NOT NULL
	THEN UnidadesOperativas.Descripcion
	ELSE 'Sin Unidad'
  END,
  CASE 	WHEN NotasCredito.TipoABC='B' AND IsNull(NotasCredito.IdCodigoIva,Clientes.IdCodigoIva)<>8   
	 THEN 	ROUND(
		Case When  dnc.Gravado='SI' 
			Then IsNull(dnc.Importe,0) / (1+(NotasCredito.PorcentajeIva1/100))
			Else IsNull(dnc.Importe,0)
		End  * IsNull(NotasCredito.CotizacionMoneda,1) * IsNull(dncp.Porcentaje,100) / 100 ,2)
	 ELSE 	ROUND(IsNull(dnc.Importe,0) * IsNull(NotasCredito.CotizacionMoneda,1) * 
			IsNull(dncp.Porcentaje,100) / 100 ,2)
  END * -1,
  Cuentas.Descripcion,
  Provincias.Nombre,
  Null
 FROM DetalleNotasCredito dnc
 LEFT OUTER JOIN NotasCredito ON dnc.IdNotaCredito = NotasCredito.IdNotaCredito
 LEFT OUTER JOIN Clientes ON NotasCredito.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN Vendedores ON NotasCredito.IdVendedor = Vendedores.IdVendedor
 LEFT OUTER JOIN Obras ON NotasCredito.IdObra = Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 LEFT OUTER JOIN Conceptos ON dnc.IdConcepto = Conceptos.IdConcepto
 LEFT OUTER JOIN Cuentas ON Conceptos.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN DetalleNotasCreditoProvincias dncp ON dncp.IdNotaCredito=NotasCredito.IdNotaCredito
 LEFT OUTER JOIN Provincias ON dncp.IdProvinciaDestino = Provincias.IdProvincia
 WHERE (NotasCredito.FechaNotaCredito between @Desde and @hasta) and 
	IsNull(NotasCredito.Anulada,'NO')<>'SI' and 
	IsNull(NotasCredito.CtaCte,'SI')='SI' and 
	IsNull(NotasCredito.NoIncluirEnCubos,'NO')<>'SI'

UNION ALL

 SELECT 
  Null,
  'Provision',
  Null,
  Asientos.FechaAsiento,
  Null,
  IsNull(Obras.NumeroObra,'Sin Obra'),
  CASE WHEN UnidadesOperativas.Descripcion IS NOT NULL
	THEN UnidadesOperativas.Descripcion
	ELSE 'Sin Unidad'
  END,
  CASE 	WHEN DetAsi.Debe is not null and DetAsi.Haber is null 
	 THEN DetAsi.Debe * -1
	WHEN DetAsi.Debe is null and DetAsi.Haber is not null 
	 THEN DetAsi.Haber
	WHEN DetAsi.Debe is not null and DetAsi.Haber is not null 
	 THEN (DetAsi.Debe - DetAsi.Haber) * -1
	 ELSE 0
  END,
  Cuentas.Descripcion,
  Null,
  Null
 FROM DetalleAsientos DetAsi 
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
 LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN Obras ON DetAsi.IdObra=Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
 WHERE (Asientos.FechaAsiento between @Desde and @Hasta) and 
	@IncluirAsientos=-1 and 
	Cuentas.Codigo between 4000 and 4999

SET NOCOUNT OFF

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts